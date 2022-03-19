local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

kingston.admin.registerCommand("playergivebadge", {
	syntax = "<string target> <number badge>",
	description = "Give a player a scoreboard badge",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, badge)
		if target:HasBadge(badge) then
			return false, "Error: target already has this badge."
		end
			
		target:SetScoreboardBadges( target:ScoreboardBadges() + badge );
		target:UpdatePlayerField( "ScoreboardBadges", target:ScoreboardBadges() );
	end,
})