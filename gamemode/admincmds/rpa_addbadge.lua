

kingston.admin.registerCommand("addbadge", {
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