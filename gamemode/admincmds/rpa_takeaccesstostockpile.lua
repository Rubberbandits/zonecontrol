kingston.admin.registerCommand("stockpiletakeaccess", {
	syntax = "<string target> <number stockpileID>",
	description = "Take a character's access to a stockpile",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, stockpileID)
		local szJSON;
		local stockpile = GAMEMODE.LoadedStockpiles[stockpileID]
	
		if( stockpile ) then
			if( table.HasValue( stockpile.Accessors, math.floor( target:CharID() ) ) ) then
				for k,v in next, stockpile.Accessors do
					if( v == math.floor( target:CharID() ) ) then
						table.remove( stockpile.Accessors, k );
						break;
					end
				end

				szJSON = util.TableToJSON( stockpile.Accessors );
				
				local function onSuccess()
					GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " took access from " .. target:RPName() .. " for stockpile \"" .. stockpileID .. "\".", ply );
				end
				mysqloo.Query( Format( "UPDATE cc_stockpiles SET Accessors = '%s' WHERE id = '%s'", szJSON, stockpileID ), onSuccess );
			end
		else
			return false, "stockpile not found"
		end
	end
})