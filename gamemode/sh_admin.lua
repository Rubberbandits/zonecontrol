function GM:PlayerNoClip( ply )
	
	if( ply:PassedOut() ) then return false; end
	if( ply:Bottify() ) then return false; end
	
	if( !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		if( CLIENT and IsFirstTimePredicted() ) then
			
			LocalPlayer():Notify(nil, Color( 200, 0, 0, 255 ), "You need to be an admin to do this.")
			
		end
		
		return false;
		
	end
	
	if( SERVER ) then
		
		if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then
			
			ply:GodDisable();
			ply:SetNoTarget( false );
			ply:SetNoDraw( false );
			ply:SetNotSolid( false );
			
			if( ply:GetActiveWeapon() != NULL ) then
				
				ply:GetActiveWeapon():SetNoDraw( false );
				ply:GetActiveWeapon():SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			if( ply.NoclipPos ) then
				
				ply:SetPos( ply.NoclipPos );
				ply.NoclipPos = nil;
				
			end
			
		else
			
			ply:GodEnable();
			ply:SetNoTarget( true );
			ply:SetNoDraw( true );
			ply:SetNotSolid( true );
			
			if( ply:GetActiveWeapon() != NULL ) then
				
				ply:GetActiveWeapon():SetNoDraw( true );
				ply:GetActiveWeapon():SetColor( Color( 255, 255, 255, 0 ) );
				
			end
			
			if( ply:IsEventCoordinator() ) then
				
				ply.NoclipPos = ply:GetPos();
				
			end
			
		end
		
	end
	
	return true;
	
end

local meta = FindMetaTable("Player")
function meta:IsSuperAdmin()
	if self:IsUserGroup("superadmin") and !self:HasCharFlag("Q") then return true end

	return false
end

function meta:IsAdmin()
	if self:IsSuperAdmin() then return true end
	if self:IsUserGroup("admin") and !self:HasCharFlag("Q") then return true end

	return false
end

function meta:IsEventCoordinator()
	
	return (self:GetUserGroup() == "gamemaster" or self:HasCharFlag( "G" )) and !self:HasCharFlag("Q")
	
end