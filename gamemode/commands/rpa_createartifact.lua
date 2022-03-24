

kingston.admin.registerCommand("itemcreateartifact", {
	syntax = "<string item>",
	description = "Spawn an invisible artifact that has to be revealed with a detector",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, item)
		if item == "" then
			netstream.Start(ply, "nAListArtifacts", "")
			return
		end

		local itemData = GAMEMODE:GetItemByID(item)
		
		if itemData then
			if !itemData.Artifact then return end
			
			GAMEMODE:CreateArtifact(ply, item)
			
			GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. itemData.Name .. ").", ply)
		else
			netstream.Start( ply, "nAListArtifacts", item );
		end
	end,
})