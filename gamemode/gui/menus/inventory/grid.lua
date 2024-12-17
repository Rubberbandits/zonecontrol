zonecontrol = zonecontrol or {}

local PANEL = {}

local GRID_X_SIZE = 64
local GRID_Y_SIZE = 64

function PANEL:Init()
	self.max_x = math.floor(self:GetWide() / GRID_X_SIZE)
	self.max_y = math.floor(self:GetTall() / GRID_Y_SIZE)

	self:Reset()
end

function PANEL:SetItems(items)
	self:Reset()

	for _,item in pairs(items) do
		self:AddItem(item.class, item.x, item.y)
	end
end

// Use real item objects instead
function PANEL:AddItem(class, x, y)
	local item_data = GAMEMODE.Items[class]
	if not item_data then return end

	local item = {class = class, x = x, y = y, w = item_data.W, h = item_data.H}
	table.insert(self.items, item)

	self.grid = self.grid or {}

	self:SetGridsByBounds(item, x, y, item.w, item.h)
end

function PANEL:RemoveItem(item)
	if not item then error("RemoveItem failed: invalid item") end

	self:SetGridsByBounds({}, item.x, item.y, item.w, item.h)

	for idx,grid_item in pairs(self.items) do
		if grid_item == item then
			table.remove(self.items, idx)
		end
	end
end

function PANEL:Reset()
	self.items = {}
	self.grid = {}
	self.highlighted = {}

	for x = 1, self.max_x do
		self.grid[x] = {}
		self.highlighted[x] = {}
		for y = 1, self.max_y do
			self.grid[x][y] = {}
		end
	end
end

function PANEL:SetGridsByBounds(value, x, y, w, h)
	local mins, maxs = self:GetGridsByBounds(x, y, w, h)
	for grid_w = mins[1], maxs[1] do
		self.grid[grid_w] = self.grid[grid_w] or {}
		for grid_h = mins[2], maxs[2] do
			self.grid[grid_w][grid_h] = value
		end
	end

	return mins, maxs
end

function PANEL:GetItemByCoord(x, y)
	if not self.grid or not self.grid[x] or not self.grid[x][y] then
		return
	end

	local grid_data = self.grid[x][y]
	if not grid_data.class then return end

	return grid_data
end

function PANEL:GetGridByPos(x, y)
	if not self.cursor_inside then
		return 0, 0
	end

	return math.Clamp(math.ceil(x / GRID_X_SIZE), 1, self.max_x), math.Clamp(math.ceil(y / GRID_Y_SIZE), 1, self.max_y)
end

function PANEL:GetGridsByBounds(x, y, w, h)
	local mins = {math.Clamp(x, 1, self.max_x - w + 1), math.Clamp(y, 1, self.max_y - h + 1)}
	local maxs = {math.Clamp(x + w - 1, x, self.max_x), math.Clamp(y + h - 1, y, self.max_y)}

	return mins, maxs
end

function PANEL:GetItemByBounds(x, y, w, h)
	local mins, maxs = self:GetGridsByBounds(x, y, w, h)
	for grid_w = mins[1], maxs[1] do
		self.grid[grid_w] = self.grid[grid_w] or {}
		for grid_h = mins[2], maxs[2] do
			local grid_data = self.grid[grid_w][grid_h]
			if grid_data.class then return grid_data end
		end
	end
end

function PANEL:PerformLayout(w, h)
	self.max_x = math.floor(w / GRID_X_SIZE)
	self.max_y = math.floor(h / GRID_Y_SIZE)

	// Recompute grid
	self.grid = {}
	for x = 1, self.max_x do
		self.highlighted[x] = {}
		self.grid[x] = self.grid[x] or {}
		for y = 1, self.max_y do
			self.grid[x][y] = self.grid[x][y] or {}
		end
	end

	// Recompute item positions
	for idx,item in pairs(self.items) do
		self:SetGridsByBounds(item, item.x, item.y, item.w, item.h)
	end
end

function PANEL:OnMousePressed(keyCode)
	local x, y = self:CursorPos()
	local grid_x, grid_y = self:GetGridByPos(x, y)
	if grid_x == 0 or grid_y == 0 then
		return
	end

	local item = self:GetItemByCoord(grid_x, grid_y)
	if not item then return end
	if keyCode == MOUSE_LEFT then
		self.dragging = item
	end

	if keyCode == MOUSE_RIGHT then
		print(grid_x, grid_y)
	end
end

function PANEL:OnMouseReleased(keyCode)
	local grid_x, grid_y = self:GetGridByPos(self:CursorPos())
	if grid_x == 0 or grid_y == 0 then
		return
	end

	if keyCode == MOUSE_LEFT and self.dragging then
		// set all grids to not highlight
		for x = 1, self.max_x do
			self.highlighted[x] = {}
		end

		// Check grids to see if occupied
		local item = self:GetItemByBounds(grid_x, grid_y, self.dragging.w, self.dragging.h)
		if not item or item == self.dragging then
			local origin = self.dragging.origin
			if origin then
				self:RemoveItem(self.dragging)
				origin:RemoveItem(self.dragging)
				table.insert(self.items, self.dragging)
			else
				// Clear out last grid position
				self:SetGridsByBounds({}, self.dragging.x, self.dragging.y, self.dragging.w, self.dragging.h)
			end

			// Set new grid positions
			local mins, _ = self:SetGridsByBounds(self.dragging, grid_x, grid_y, self.dragging.w, self.dragging.h)

			self.dragging.x = mins[1]
			self.dragging.y = mins[2]
			self.dragging.origin = nil
		end

		self.dragging = nil
	end

	if keyCode == MOUSE_RIGHT then
		// Open context menu
	end
end

function PANEL:CanDrop(target)
	return IsValid(target) and target:GetName() == "InventoryGrid"
end

function PANEL:TransitionDraggedItem(target)
	print("TransitionDraggedItem")
	if not self.dragging then return end

	target.dragging = self.dragging
	target.dragging.origin = self

	self.dragging = nil
end

function PANEL:OnCursorMoved(x, y)
	self.last_moved = CurTime()
	self.current_x, self.current_y = self:GetGridByPos(x, y)

	if not self.dragging then return end
	for grid_x = 1, self.max_x do
		self.highlighted[grid_x] = {}
	end

	local mins, maxs = self:GetGridsByBounds(self.current_x, self.current_y, self.dragging.w, self.dragging.h)
	for w = mins[1], maxs[1] do
		for h = mins[2], maxs[2] do
			self.highlighted[w][h] = true
		end
	end
end

function PANEL:OnCursorEntered()
	self.cursor_inside = true
end

function PANEL:OnCursorExited()
	self.cursor_inside = false

	for grid_x = 1, self.max_x do
		self.highlighted[grid_x] = {}
	end
end

function PANEL:Think()
	if not self.dragging then return end

	local grid_x, grid_y = self:GetGridByPos(self:LocalCursorPos())
	// Outside of the bounds of the panel
	if grid_x == 0 or grid_y == 0 then
		local target = vgui.GetHoveredPanel()
		if not self:CanDrop(target) then return end

		self:TransitionDraggedItem(target)
		return
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(200, 200, 200, 255)
	for row = 1, self.max_x do
		for column = 1, self.max_y do
			surface.DrawOutlinedRect((row - 1) * GRID_X_SIZE, (column - 1) * GRID_Y_SIZE, GRID_X_SIZE, GRID_Y_SIZE)

			local highlighted = self.highlighted[row][column]
			if not highlighted then continue end

			if highlighted then
				surface.SetDrawColor(0, 180, 0, 100)
				surface.DrawRect((row - 1) * GRID_X_SIZE, (column - 1) * GRID_Y_SIZE, GRID_X_SIZE, GRID_Y_SIZE)
				surface.SetDrawColor(200, 200, 200, 255)
			end
		end
	end

	for idx,item in pairs(self.items) do
		if self.dragging == item then continue end
		if item.origin then continue end

		local exIcon = ikon:getIcon(item.class)
		if exIcon then
			surface.SetMaterial(exIcon)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((item.x - 1) * GRID_X_SIZE, (item.y - 1) * GRID_Y_SIZE, item.w * GRID_X_SIZE, item.h * GRID_Y_SIZE)
		else
			local item_data = GAMEMODE.Items[item.class]
			ikon:renderIcon(
				item.class,
				item.w,
				item.h,
				item_data.Model,
				item_data.CamInfo
			)
		end
	end
end

function PANEL:PaintOver(w, h)
	// Draw dragging icon
	if self.dragging and self.current_x > 0 and self.current_y > 0 then
		local mins, _ = self:GetGridsByBounds(self.current_x, self.current_y, self.dragging.w, self.dragging.h)
		local exIcon = ikon:getIcon(self.dragging.class)
		if exIcon then
			surface.SetMaterial(exIcon)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((mins[1] - 1) * GRID_X_SIZE, (mins[2] - 1) * GRID_Y_SIZE, self.dragging.w * GRID_X_SIZE, self.dragging.h * GRID_Y_SIZE)
		end
	end

	if not self.last_moved or CurTime() - self.last_moved < 1 then
		return
	end

	if self.grid and self.grid[self.current_x] and self.grid[self.current_x][self.current_y] then
		// Draw Tooltip
	end
end

vgui.Register("InventoryGrid", PANEL, "EditablePanel")

function zonecontrol.TestInventory()
	local frame = vgui.Create("DFrame")
	frame:SetSize(800, 600)
	frame:Center()
	frame:MakePopup()

	local grid = frame:Add("InventoryGrid")
	grid:Dock(FILL)
	grid:SetItems({
		{class = "weapon_srp_659", x = 2, y = 1},
	})

	local frame = vgui.Create("DFrame")
	frame:SetSize(800, 600)
	frame:Center()
	frame:MakePopup()

	local grid = frame:Add("InventoryGrid")
	grid:Dock(FILL)
end