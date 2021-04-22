local function EditVendor(ply, args)
	local vendor = ply:GetEyeTraceNoCursor().Entity
	if !vendor.Vendor then
		ply:Notify(nil, COLOR_ERROR, "This entity is not a vendor!")
		return
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
end
concommand.AddAdmin("rpa_editvendor", EditVendor)