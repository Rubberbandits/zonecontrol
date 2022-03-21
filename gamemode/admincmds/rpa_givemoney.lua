

kingston.admin.registerCommand("givemoney", {
	syntax = "<string target> <number amount>",
	description = "Increase a character's money",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, amount)
		target:AddMoney( amount );
		target:UpdateCharacterField( "Money", tostring( target:Money() ) );
		target:Notify(nil, COLOR_NOTIF, "%s gave you %d rubles.", ply:Nick(), amount)
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " gave " .. target:RPName() .. " " .. tostring( amount ) .. " rubles.", ply );
	end,
})