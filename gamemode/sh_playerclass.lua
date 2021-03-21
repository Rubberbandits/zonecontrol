local PLAYER = { };

PLAYER.DisplayName			= "CombineControl";
PLAYER.TeammateNoCollide	= false;
PLAYER.AvoidPlayers			= false;

function PLAYER:GetHandsModel()
	if self.Player.Inventory then
		for k,v in next, self.Player.Inventory do
			if v.Base == "clothes" and v:GetVar("Equipped", false) and v.HandsModel then
				--return v:GetHands()
				return "models/weapons/c_arms_refugee.mdl"
			end
		end
	end
	
	local cl_playermodel = GAMEMODE:TranslateModelToPlayer( self.Player:GetModel() );
	return player_manager.TranslatePlayerHands( cl_playermodel )
end

function PLAYER:StartMove( move )
end

function PLAYER:FinishMove( move )
end

player_manager.RegisterClass( "player_cc", PLAYER, "player_sandbox" );