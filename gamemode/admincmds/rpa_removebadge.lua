

kingston.admin.registerCommand("removebadge", {
	syntax = "<string target> <number badge>",
	description = "Remove a player's scoreboard badge",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, badge)
		if !target:HasBadge(badge) then
			return false, "Error: target doesn't has this badge."
		end
			
		target:SetScoreboardBadges( target:ScoreboardBadges() - badge );
		target:UpdatePlayerField( "ScoreboardBadges", target:ScoreboardBadges() );
	end,
})