

kingston.admin.registerCommand("stockpileaccessgive", {
	syntax = "<string target> <number stockpileID>",
	description = "Give a character access to a stockpile",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, stockpileID)
		local stockpile = GAMEMODE.LoadedStockpiles[stockpileID]
		
		if !stockpile then
			return false, "stockpile not found"
		end

		if !table.HasValue(stockpile.Accessors, math.floor(target:CharID())) then
			stockpile.Accessors[#stockpile.Accessors + 1] = target:CharID()
			szJSON = util.TableToJSON(stockpile.Accessors)
			
			local function onSuccess()
				GAMEMODE:LogAdmin("[F] " .. ply:Nick() .. " gave access to " .. target:RPName() .. " for stockpile \"" .. stockpileID .. "\".", ply)
			end

			mysqloo.Query(Format("UPDATE cc_stockpiles SET Accessors = '%s' WHERE id = '%s'", szJSON, stockpileID), onSuccess)
		end
	end,
})