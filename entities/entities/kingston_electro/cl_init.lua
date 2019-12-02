include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	local mypos = self:GetPos();
	local dist = LocalPlayer():GetPos():Distance(mypos);
	
	if(dist < 5000) then
	
		--self.Entity:DrawModel();
		
		if( IsValid( LocalPlayer() ) and LocalPlayer():Alive() and LocalPlayer():IsAdmin() and IsValid( LocalPlayer():GetActiveWeapon() ) and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" ) then
		
			render.SetColorMaterial();
			render.DrawSphere( mypos, 200, 50, 50, Color( 255, 0, 0, 100 ) );
		
		end
		
	end
end

function ENT:Initialize()

end

/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end

function ENT:Think()

	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 5000) then

		if !self.ElectroParticleSystem then

			CreateParticleSystem( self.Entity, "electrical_arc_01_system", PATTACH_ABSORIGIN_FOLLOW );
			self.ElectroParticleSystem = true;
			self.ElectroParticleSystemEndTime = CurTime() + 1;

		elseif( self.ElectroParticleSystem and self.ElectroParticleSystemEndTime < CurTime() ) then

			self.ElectroParticleSystem = nil;
			self.ElectroParticleSystemEndTime = nil;
			
		end
		
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 200 ) ) do	
	
			if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 200 and !v:GetNoDraw() ) then
			
				if( !self.NextSoundPlay ) then self.NextSoundPlay = CurTime() end
				if( self.NextSoundPlay > CurTime() ) then return end
				
				local pelvisPos;
				local entity;
				
				if( v:Alive() and IsValid( v ) ) then
				
					entity = v;
					if( !v:LookupBone( "ValveBiped.Bip01_Pelvis" ) ) then return end
					pelvisPos = v:GetBonePosition( v:LookupBone( "ValveBiped.Bip01_Pelvis" ) );
					
					
				else
				
					if( !IsValid( v:GetRagdollEntity() ) ) then return end
				
					entity = v:GetRagdollEntity();
					if( !v:LookupBone( "ValveBiped.Bip01_Pelvis" ) ) then return end
					pelvisPos = v:GetRagdollEntity():GetBonePosition( v:LookupBone( "ValveBiped.Bip01_Pelvis" ) );
					
				end

				self.BeamParticleSystem = CreateParticleSystem( self.Entity, "st_elmos_fire", PATTACH_ABSORIGIN_FOLLOW );
				
				if( !self.BeamParticleSystem ) then return end
				self.BeamParticleSystem:AddControlPoint( 1, entity, PATTACH_ABSORIGIN_FOLLOW, 0, ( pelvisPos or entity:GetPos() ) - entity:GetPos() );
				
				self.NextSoundPlay = CurTime() + 0.5;
			
			elseif v:GetClass() == "cc_bolt" and v:IsValid() and v:GetPos():Distance(self:GetPos()) <= 200 and !v.HasBeenHit then
				if( !self.NextSoundPlay ) then self.NextSoundPlay = CurTime() end
				if( self.NextSoundPlay > CurTime() ) then return end
				
				local pelvisPos = v:GetPos();
				local entity = v;

				self.BeamParticleSystem = CreateParticleSystem( self.Entity, "st_elmos_fire", PATTACH_ABSORIGIN_FOLLOW );
				
				if( !self.BeamParticleSystem ) then return end
				self.BeamParticleSystem:AddControlPoint( 1, entity, PATTACH_ABSORIGIN_FOLLOW, 0, ( pelvisPos or entity:GetPos() ) - entity:GetPos() );
				
				self.NextSoundPlay = CurTime() + 0.5;
				
				v.HasBeenHit = true
			end
			
		end
		
	end

end