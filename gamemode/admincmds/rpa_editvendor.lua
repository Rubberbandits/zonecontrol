

kingston.admin.registerCommand("editvendor", {
	syntax = "<none>",
	description = "Edit the vendor you are currently looking at.",
	arguments = {},
	onRun = function(ply)
		local vendor = ply:GetEyeTraceNoCursor().Entity
		if !vendor.Vendor then
			return false, "entity is not a vendor"
		end
		
		net.Start("VendorOpenMenu")
			net.WriteEntity(vendor)
			
			net.WriteUInt(table.Count(vendor.Items), 32)
			for class,data in next, vendor.Items do
				net.WriteString(class)
				net.WriteFloat(data.BuyFactor)
				net.WriteFloat(data.SellFactor)
			end
			net.WriteBool(true)
		net.Send(ply)
	end,
})