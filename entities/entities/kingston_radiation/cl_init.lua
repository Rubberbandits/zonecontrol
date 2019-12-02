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
		
		if( IsValid( LocalPlayer() ) and LocalPlayer():Alive() and LocalPlayer():IsAdmin() and IsValid( LocalPlayer():GetActiveWeapon() ) and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" ) then
		
			render.SetColorMaterial();
			render.DrawSphere( mypos, self:GetZoneSize(), 50, 50, Color( 255, 0, 0, 100 ) );
			render.DrawSphere( mypos, self:GetSourceSize(), 50, 50, Color( 0, 255, 0, 100 ) );
		
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
	

end

function ENT:OnRemove()

end