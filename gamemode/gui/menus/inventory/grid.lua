local PANEL = {}

local GRID_X_SIZE = 64
local GRID_Y_SIZE = 64

function PANEL:Init()
	self.items = {}
	self.max_x = math.floor(self:GetWide() / GRID_X_SIZE)
	self.max_y = math.floor(self:GetTall() / GRID_Y_SIZE)

	self.grid = {}
	for x = 1, self.max_x do
		self.grid[x] = {}
		for y = 1, self.max_y do
			self.grid[x][y] = {}
		end
	end
end

function PANEL:SetItems(items)
	for _,item in pairs(items) do
		self:AddItem(item.class, item.x, item.y)
	end
end

// Use real item objects instead
function PANEL:AddItem(class, x, y)
	local item = {class = class, x = x, y = y}
	table.insert(self.items, item)

	self.grid = self.grid or {}
	self.grid[x] = self.grid[x] or {}
	self.grid[x][y] = item

	// Also consider the size of the item
end

function PANEL:GetItemByCoord(x, y)
	if not self.grid or not self.grid[x] or not self.grid[x][y] then
		return
	end

	return self.grid[x][y]
end

function PANEL:GetGridByPos(x, y)
	if not self.cursor_inside then
		return 0, 0
	end

	return math.Clamp(math.floor(x / GRID_X_SIZE), 1, self.max_x), math.Clamp(math.floor(y / GRID_Y_SIZE), 1, self.max_y)
end

function PANEL:PerformLayout(w, h)
	self.max_x = math.floor(w / GRID_X_SIZE)
	self.max_y = math.floor(h / GRID_Y_SIZE)
end

function PANEL:OnMousePressed(keyCode)
	local x, y = self:CursorPos()
	local w, h = self:GetSize()
	local grid_x, grid_y = self:GetGridByPos()
	if grid_x == 0 or grid_y == 0 then
		return
	end
	if grid_x > self.max_x or grid_y > self.max_y then
		return
	end

	if keyCode == MOUSE_LEFT then
		print(grid_x, grid_y)
		self.dragging = self:GetItemByCoord(grid_x, grid_y) or nil
	end

	if keyCode == MOUSE_RIGHT then
		local item = self:GetItemByCoord(grid_x, grid_y)
		if not item then return end

		print(grid_x, grid_y)
	end
end

function PANEL:OnMouseReleased(keyCode)
	local x, y = self:CursorPos()
	local w, h = self:GetSize()
	local grid_x, grid_y = self:GetGridByPos(x, y)

	if grid_x > self.max_x or grid_y > self.max_y then
		return
	end

	if keyCode == MOUSE_LEFT and self.dragging then
		print(string.format("Item dropped at (%d,%d)", grid_x, grid_y))
		// Check grids to see if occupied
	end

	if keyCode == MOUSE_RIGHT then
		print(grid_x, grid_y)
	end
end

function PANEL:OnCursorMoved(x, y)
	self.last_moved = CurTime()
	self.current_x, self.current_y = self:GetGridByPos(x, y)
	
	if self.dragging and self.current_x > 0 and self.current_y > 0 then
		self.grid[current_x][current_y]["highlight"] = true
		// Consider self.dragging.width and self.dragging.height
	else
		self.grid[current_x][current_y]["highlight"] = false
	end
end

function PANEL:OnCursorEntered()
	self.cursor_inside = true
end

function PANEL:OnCursorExited()
	self.cursor_inside = false
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(200, 200, 200, 255)
	for row = 1, self.max_x do
		for column = 1, self.max_y do
			surface.DrawOutlinedRect(row * GRID_X_SIZE, column * GRID_Y_SIZE, GRID_X_SIZE, GRID_Y_SIZE)

			local grid_data = self.grid[row][column]
			if grid_data.highlight then
				surface.SetDrawColor(0, 255, 0, 255)
				surface.DrawRect(row * GRID_X_SIZE, column * GRID_Y_SIZE, GRID_X_SIZE, GRID_Y_SIZE)
			end
		end
	end

	for idx,item in pairs(self.items) do
		// Draw item icons
	end
end

function PANEL:PaintOver(w, h)
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
end