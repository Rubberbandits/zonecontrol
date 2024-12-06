local PANEL = { };

AccessorFunc( PANEL, "m_fAnimSpeed", 	"AnimSpeed" )
AccessorFunc( PANEL, "Entity", 			"Entity" )
AccessorFunc( PANEL, "vCamPos", 		"CamPos" )
AccessorFunc( PANEL, "fFOV", 			"FOV" )
AccessorFunc( PANEL, "vLookatPos", 		"LookAt" )
AccessorFunc( PANEL, "colAmbientLight", "AmbientLight" )
AccessorFunc( PANEL, "colColor", 		"Color" )
AccessorFunc( PANEL, "bAnimated", 		"Animated" )

function PANEL:Init()
	
	self.LastPaint = 0;
	
	self:SetText( "" );
	self:SetAnimSpeed( 0.5 );
	self:SetAnimated( true );
	
	self:SetAmbientLight( Color( 50, 50, 50 ) );
	
	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) );
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) );
	
	self:SetColor( Color( 255, 255, 255, 255 ) );
	
	self.Entity = ClientsideModel( "models/humans/group01/male_01.mdl", RENDER_GROUP_OPAQUE_ENTITY );
	self.Entity:SetNoDraw( true );
	
	self:SetCamPos( Vector( 50, 15, 5 ) );
	self:SetLookAt( Vector( 0, 2, 5 ) );
	self:SetFOV( 40 );
	
	self.HasModel = false;
	
end

function PANEL:SetModel( strModelName )
	
	self.Entity:SetModel( strModelName );
	self.Entity:SetNoDraw( true );
	
	if( string.len( strModelName ) == 0 ) then
		
		self.HasModel = false;
		
	else
		
		self.HasModel = true;
		
	end
	
end

function PANEL:GetModel()
	
	return self.Entity:GetModel();
	
end

function PANEL:SetSubMaterial( i, j )
	
	self.Entity:SetSubMaterial( i, j );
	
end

function PANEL:OnMouseWheeled( dlta )
	
	if( !self.NoMouseWheel and string.len( self:GetModel() ) > 0 ) then
		
		self:SetFOV( math.Clamp( self:GetFOV() + dlta * -2, 20, 60 ) );
		
	end
	
end

function PANEL:Paint( w, h )
	
	if( !self or !IsValid( self ) ) then return end
	if( !IsValid( self.Entity ) ) then return end
	if( !self.HasModel ) then return end
	if( !self:GetModel() ) then return end
	if( self:GetModel() == "" ) then return end
	if( self:GetModel() == "models/error.mdl" ) then return end
	
	local x, y = self:LocalToScreen( 0, 0 )
	
	self:LayoutEntity( self.Entity )
	
	cam.Start3D( self.vCamPos, (self.vLookatPos-self.vCamPos):Angle(), self.fFOV, x, y, self:GetSize() )
		cam.IgnoreZ( true )
		
		render.SuppressEngineLighting( true )
		render.SetLightingOrigin( self.Entity:GetPos() )
		render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
		render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
		render.SetBlend( self.colColor.a / 255 )
		
		for i=0, 6 do
			local col = self.DirectionalLight[ i ]
			if ( col ) then
				render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
			end
		end
		
		local curparent = self
		local rightx = self:GetWide()
		local leftx = 0
		local topy = 0
		local bottomy = self:GetTall()
		local previous = curparent
		while(curparent:GetParent() != nil) do
			curparent = curparent:GetParent()
			local x,y = previous:GetPos()
			topy = math.Max(y, topy+y)
			leftx = math.Max(x, leftx+x)
			bottomy = math.Min(y+previous:GetTall(), bottomy + y)
			rightx = math.Min(x+previous:GetWide(), rightx + x)
			previous = curparent
		end
		render.SetScissorRect(leftx,topy,rightx, bottomy, true)
		self.Entity:DrawModel()
		render.SetScissorRect(0,0,0,0, false)
		
		hook.Run("PostDrawWeaponPanel", self, self.Entity)
		
		render.SuppressEngineLighting( false )
		cam.IgnoreZ( false )
	cam.End3D()
	
	if( self.Dark ) then
		
		surface.SetDrawColor( Color( 0, 0, 0, 200 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
 	/*surface.SetDrawColor( Color( 255, 0, 0, 255 ) );
	surface.DrawOutlinedRect( 0, 0, w, h );*/
	
	self.LastPaint = RealTime()
	
end

hook.Add( "PostDrawWeaponPanel", "charpanel", function( panel, entity )
	
	if ( panel.modelList ) then
		
		for k,v in next, panel.modelList do
		
			if ( v.drawModel == true and IsValid( v ) ) then

				v:SetupBones();
				v:DrawModel();
				
			end
			
		end
		
	end
	
end )

function PANEL:InitializeModel( mdl, parent )

	if( !self.modelList ) then self.modelList = {} end;

	local b = ClientsideModel( mdl, RENDERGROUP_TRANSLUCENT );
	if( !b ) then return end;
	b:SetParent( parent );
	b:SetNoDraw( true );
	b:AddEffects( EF_BONEMERGE );
	b:SetupBones();
	if( string.len( mdl ) == 0 ) then
		
		b.drawModel = false;
		
	else
		
		b.drawModel = true;
		
	end
		
	self.modelList[#self.modelList + 1] = b;
	
	return b;
	
end

function PANEL:OnRemove()

	if( self.modelList ) then
	
		for k,v in next, self.modelList do
		
			v:Remove();
		
		end
		
		self.modelList = nil;
		
	end

	if( IsValid( self.Entity ) ) then
	
		self.Entity:Remove();
		
	end

end

function PANEL:OnMousePressed( code )
	
	if( self.DoClick ) then
		
		self:DoClick();
		
	end
	
	if( self.HasModel ) then
		
		self:MouseCapture( true );
		self.MouseDetect = true;
		
		local centerx, centery = self:LocalToScreen( self:GetWide() * 0.5, self:GetTall() * 0.5 )
		input.SetCursorPos( centerx, centery );
		
		self.MX = centerx;
		self.MY = centery;
		
	end
	
end

function PANEL:OnMouseReleased( code )
	
	if( self.HasModel ) then
		
		self:MouseCapture( false );
		self.MouseDetect = false;
		
	end
	
end

function PANEL:LayoutEntity( Entity )

	if( !Entity ) then return end
	if( !IsValid( Entity ) ) then return end
	
	if( self.MouseDetect ) then
		
		local xpos = gui.MouseX();
		local ypos = gui.MouseY();
		
		local dx = xpos - self.MX;
		local dy = ypos - self.MY;
		
		input.SetCursorPos( self.MX, self.MY );
		
		Entity:SetAngles( Entity:GetAngles() + Angle( 0, dx, 0 ) );
		
	end
	
end

vgui.Register( "CWeaponDisplay", PANEL, "DModelPanel" );