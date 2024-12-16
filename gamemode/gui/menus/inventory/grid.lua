local PANEL = {}

local GRID_X_SIZE = 64
local GRID_Y_SIZE = 64

function PANEL:Init()
	self.items = {}
	self.max_x = math.floor(self:GetWide() / GRID_X_SIZE)
	self.max_y = math.floor(self:GetTall() / GRID_Y_SIZE)
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
end

function PANEL:PerformLayout(w, h)
	self.max_x = math.floor(w / GRID_X_SIZE)
	self.max_y = math.floor(h / GRID_Y_SIZE)
end

function PANEL:OnMousePressed(keyCode)
	local x, y = self:CursorPos()
	local w, h = self:GetSize()
	local grid_x, grid_y = math.floor(x / GRID_X_SIZE), math.floor(y / GRID_Y_SIZE)

	if grid_x > self.max_x or grid_y > self.max_y then
		return
	end

	if keyCode == MOUSE_LEFT then
		print(grid_x, grid_y)
		self.dragging = 
	end

	if keyCode == MOUSE_RIGHT then
		print(grid_x, grid_y)
	end
end

function PANEL:OnMouseReleased(keyCode)
	local x, y = self:CursorPos()
	local w, h = self:GetSize()
	local grid_x, grid_y = math.floor(x / GRID_X_SIZE), math.floor(y / GRID_Y_SIZE)

	if grid_x > self.max_x or grid_y > self.max_y then
		return
	end

	if keyCode == MOUSE_LEFT then
		print(grid_x, grid_y)
	end

	if keyCode == MOUSE_RIGHT then
		print(grid_x, grid_y)
	end
end

function PANEL:OnCursorMoved(x, y)
	if not self.last_moved then
		self.last_moved = CurTime()
	end

	self.last_moved = CurTime()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, w, h)

	//surface.SetDrawColor(200, 200, 200, 255)
	for row = 1, self.max_x do
		for column = 1, self.max_y do
			if self.grid[row] and self.grid[row][column] then
				surface.SetDrawColor(255, 0, 0, 255)
				// Render item icon
			else
				surface.SetDrawColor(200, 200, 200, 255)
			end

			surface.DrawRect(row * GRID_X_SIZE, column * GRID_Y_SIZE, GRID_X_SIZE, GRID_Y_SIZE)
		end
	end
end

vgui.Register("InventoryGrid", PANEL, "EditablePanel")