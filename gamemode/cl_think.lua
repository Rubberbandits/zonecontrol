GM.ChangedSubmaterials = {};

function GM:Think()
	
	self.BaseClass:Think();
	
	self:MusicThink();
	self:CreateParticleEmitters();
	self:ToggleHolsterThink();
	
	self:CharCreateThink();
	
	if( GetConVarNumber( "physgun_wheelspeed" ) > 20 ) then
		
		RunConsoleCommand( "physgun_wheelspeed", "20" );
		
	end
	
	if( Vector( GetConVar( "cl_weaponcolor" ) ) != Vector( 0.15, 0.81, 0.91 ) ) then
		
		RunConsoleCommand( "cl_weaponcolor", "0.15 0.81 0.91" );
		
	end
	
	for k,v in next, player.GetAll() do
	
		if( !IsValid( v ) ) then return end
		if( !v.CharID ) then return end
		
		if( !self.ChangedSubmaterials[v:CharID()] ) then
		
			self.ChangedSubmaterials[v:CharID()] = {}
			for i = 0, #v:GetMaterials() - 1 do
			
				local submat = v:GetSubMaterial( i );
				
				if( submat != "" ) then

					self.ChangedSubmaterials[v:CharID()][#self.ChangedSubmaterials[v:CharID()] + 1] = { i, submat };
					
				end
			
			end
			
		end
			
		if( !v.LastAlive and v:Alive() ) then

			for i = 0, #v:GetMaterials() - 1 do
			
				local submat = v:GetSubMaterial( i );
				
				if( submat != "" ) then

					self.ChangedSubmaterials[v:CharID()][#self.ChangedSubmaterials[v:CharID()] + 1] = { i, submat };
					
				end
			
			end
			
		end
			
		if( v.LastAlive and !v:Alive() ) then

			if( self.ChangedSubmaterials[v:CharID()] and #self.ChangedSubmaterials[v:CharID()] > 0 ) then

				local ragdoll = v:GetRagdollEntity();
				
				if( !IsValid( ragdoll ) ) then return end

				for m,n in next, self.ChangedSubmaterials[v:CharID()] do

					ragdoll:SetSubMaterial( n[1], n[2] )
					
				end
			
			end
		
		end

		v.LastAlive = v:Alive();
	
	end
	
end
