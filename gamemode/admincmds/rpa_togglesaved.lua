local function ToggleSaved( ply, args )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "prop_physics" ) then
		
		tr.Entity:SetPropSaved( !tr.Entity:PropSaved() );
		
		if( tr.Entity:GetPhysicsObject() and tr.Entity:GetPhysicsObject():IsValid() ) then
			
			tr.Entity:GetPhysicsObject():EnableMotion( false );
			
		end
		
		GAMEMODE:SaveSavedProps();
		
	end
	
end
concommand.AddAdmin( "rpa_togglesaved", ToggleSaved );