local PANEL = {}

function PANEL:Init()
	self:SetPaintBackground(true)
end

function PANEL:SetItem(item)
	self.item = item
end

function PANEL:Setup()
	local item = self.item
	if not item then return end

	if item.functions then
		for key,func_data in next, item.functions do
			if not func_data.CanRun(item) then continue end

			local name = isfunction(func_data.SelectionName) and func_data.SelectionName(item) or func_data.SelectionName
			self:AddOption(name, function()
				item:CallFunction(key, true)
			end)
		end
	end

	if item.DynamicFunctions then
		for key,func_data in next, item:DynamicFunctions() do
			if not func_data.CanRun(item) then continue end

			self:AddOption(func_data.SelectionName, function()
				netstream.Start("ItemCallDynamicFunction", item:GetID(), key)
				func_data.OnUse(item)
			end)
		end
	end

	if item.CanSplitStack and item:CanSplitStack() then
		self:AddOption("split", function()
			netstream.Start("SplitStack", item:GetID())
		end)
	end

	if item.CanDrop and item:CanDrop() then
		if LocalPlayer():IsAdmin() then
			self:AddOption("edit", function()
				GAMEMODE.ItemEditor = vgui.Create("CItemCreator")
				GAMEMODE.ItemEditor:SetItem(item)
			end)
		end

		self:AddOption("drop", function()
			netstream.Start("ItemDrop", item:GetID())
			item:DropItem()
		end)
	end
end

vgui.Register("ItemContextMenu", PANEL, "DMenu")