local function PanicCleanup( ply )

	for k,v in next, ents.FindByClass( "prop_physics" ) do
	
		if( IsValid( v ) and IsValid( v:GetPhysicsObject() ) ) then
		
			if( v:GetPhysicsObject():IsMotionEnabled() ) then
			
				v:Remove();
			
			end
		
		end
	
	end
	
end	
concommand.AddAdmin( "rpa_panic", PanicCleanup );