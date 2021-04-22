include("shared.lua")

local function VendorOpenMenu(len)
	local vendor = net.ReadEntity()
	local itemCount = net.ReadUInt(32)
	local data = {}
	for i = 1, itemCount do
		data[net.ReadString()] = {
			BuyFactor = net.ReadFloat(),
			SellFactor = net.ReadFloat(),
		}
	end

	local adminMenu = net.ReadBool()

	GAMEMODE.VendorMenu = vgui.Create("zc_vendor")
	GAMEMODE.VendorMenu:SetVendor(vendor)
	GAMEMODE.VendorMenu:PopulateData(data)
	if adminMenu then
		GAMEMODE.VendorMenu:OpenAdmin()
	end
end
net.Receive("VendorOpenMenu", VendorOpenMenu)

hook.Add("NetworkedItemReceived", "STALKER.RefreshVendorUI", function()
	if IsValid(GAMEMODE.VendorMenu) then
		GAMEMODE.VendorMenu:PopulateInventory()
	end
end)