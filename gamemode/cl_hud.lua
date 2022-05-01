GM.FontFace = "Myriad Pro 100 Rads";

GM.FontHeight = { };

function surface.CreateFontCC( name, tab )
	
	surface.CreateFont( name, tab );
	GM.FontHeight[name] = tab.size;
	
end

surface.CreateFontCC( "PDA.LabelBody", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );
	
surface.CreateFontCC( "PDA.LabelHeader", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );

surface.CreateFontCC( "STALKER.LabelMenu", {
	font = "Arial",
	size = 16,
	weight = 900 } );

surface.CreateFontCC( "CombineControl.Window", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.GUIClose", {
	font = GM.FontFace,
	size = 16,
	weight = 900 } );

surface.CreateFontCC( "CombineControl.LabelTiny", {
	font = GM.FontFace,
	size = 12,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmall", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmallItalic", {
	font = GM.FontFace,
	size = 14,
	weight = 500,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.LabelMedium", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelBig", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelGiant", {
	font = GM.FontFace,
	size = 22,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelMassive", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelStupid", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatSmall", {
	font = GM.FontFace,
	size = ScreenScale(5),
	weight = 150 } );
	
surface.CreateFontCC( "CombineControl.ChatSmallItalic", {
	font = GM.FontFace,
	size = ScreenScale(5),
	weight = 500,
	italic = true } );

surface.CreateFontCC( "CombineControl.ChatSmallBold", {
	font = GM.FontFace,
	size = ScreenScale(5),
	weight = 700 } );

surface.CreateFontCC( "CombineControl.ChatNormal", {
	font = GM.FontFace,
	size = ScreenScale(7),
	weight = 500,
	antialias = true } );
	
surface.CreateFontCC( "CombineControl.ChatNormalItalic", {
	font = GM.FontFace,
	size = ScreenScale(7),
	weight = 500,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatNormalBold", {
	font = GM.FontFace,
	size = ScreenScale(7),
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.ChatRadio", {
	font = "Lucida Console",
	size = ScreenScale(5),
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatRadioItalic", {
	font = "Lucida Console",
	size = ScreenScale(5),
	weight = 500,
	italic = true } );

surface.CreateFontCC( "CombineControl.ChatRadioBold", {
	font = "Lucida Console",
	size = ScreenScale(5),
	weight = 600 } );

surface.CreateFontCC( "CombineControl.CombineCamera", {
	font = "Courier New",
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.CombineCameraSmall", {
	font = "Courier New",
	size = 15,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatBig", {
	font = GM.FontFace,
	size = ScreenScale(8),
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.ChatBigItalic", {
	font = GM.FontFace,
	size = ScreenScale(8),
	weight = 700,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatBigBold", {
	font = GM.FontFace,
	size = ScreenScale(8),
	weight = 800 } );
	
surface.CreateFontCC( "CombineControl.ChatHuge", {
	font = GM.FontFace,
	size = ScreenScale(10),
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.ChatHugeItalic", {
	font = GM.FontFace,
	size = ScreenScale(10),
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.ChatHugeBold", {
	font = GM.FontFace,
	size = ScreenScale(10),
	weight = 800 } );

surface.CreateFontCC( "CombineControl.HL2CreditText", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900 } );
	
surface.CreateFontCC( "CombineControl.PlayerFont", {
	font = GM.FontFace,
	size = 17,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.HUDAmmo", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.HUDAmmoSmall", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectHeader", {
	font = GM.FontFace,
	size = 20,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.WepSelectWep", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectInfo", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.Written", {
	font = "Comic Sans MS",
	size = 20,
	weight = 700 } );
	
	surface.CreateFont( "InventoryWeight", {
	font = "Arial",
	size = ScreenScale( 8 ),
	weight = 560,
	antialias = true,
} );

surface.CreateFont( "InventoryDisplay", {
	font = "Arial",
	size = ScreenScale( 6 ),
	weight = 500,
	antialias = true,
} );

surface.CreateFont( "InventoryNameDisplay", {
	font = "Arial",
	size = ScreenScale( 8 ),
	weight = 560,
	antialias = true,
} );

surface.CreateFont( "InventoryFactionDisplay", {
	font = "Arial",
	size = ScreenScale( 6 ),
	weight = 560,
	antialias = true,
} );
	
language.Add( "npc_clawscanner", "Claw Scanner" );
language.Add( "npc_combine_camera", "Combine Camera" );
language.Add( "npc_helicopter", "Helicopter" );
language.Add( "npc_barnacle_tongue_tip", "Barnacle Tongue Tip" );
language.Add( "prop_vehicle_apc", "APC" );
language.Add( "npc_fisherman", "Fisherman" );
	
function draw.DrawTextShadow( text, font, x, y, col1, col2, align )
	
	if( align != 0 ) then
		
		draw.DrawText( text, font, x + 1, y + 1, col2, align ); -- Less efficient than surface, so we only use this if we need special alignment stuff.
		draw.DrawText( text, font, x, y, col1, align );
		
	else
		
		surface.SetFont( font );
		
		surface.SetTextColor( col2 );
		surface.SetTextPos( x + 1, y + 1 );
		surface.DrawText( text );
		surface.SetTextColor( col1 );
		surface.SetTextPos( x, y );
		surface.DrawText( text );
		
	end
	
end

local matBlurScreen = Material( "pp/blurscreen" );

function draw.DrawBackgroundBlur( frac )
	
	DisableClipping( true );
	
	surface.SetMaterial( matBlurScreen );
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	for i = 1, 3 do
		
		matBlurScreen:SetFloat( "$blur", frac * 5 * ( i / 3 ) )
		matBlurScreen:Recompute();
		render.UpdateScreenEffectTexture();
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	DisableClipping( false );

end

GM.ThirdCurPos = Vector();
GM.ThirdCurAng = Angle();
GM.ThirdDestPos = Vector();
GM.ThirdDestAng = Angle();

function GM:ShouldDoThirdPerson( ply )
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() and wep != NULL ) then
		
		if( wep.InScope and wep:InScope() ) then
			
			return false;
			
		end
		
	end
	
	if( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
		
		return false;
		
	end
	
	if( ply:GetViewEntity() != ply ) then
		
		return false;
		
	end
	
	return true;
	
end

GM.IntroCamDelay = 15;

function GM:StartIntroCam()
	
	if( !self.IntroCamData ) then return end
	
	self.IntroCamStart = CurTime();
	self:PlayMusic( self.IntroCinematicMusic or "music/hl2_song26_trainstation1.mp3", 0 );
	
end

function nIntroStart( force )
	
	GAMEMODE.QueueCharCreate = false;
	cookie.Set( "zc_doneintro", 2 );
	
	GAMEMODE:CreateCharEditor();
	
end
netstream.Hook( "nIntroStart", nIntroStart );

function GM:InIntroCam()
	
	if( !self.IntroCamData ) then return false end
	
	if( self.IntroCamStart and CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
		
		return true;
		
	end
	
	return false;
	
end

function GM:CalcView( ply, pos, ang, fov, znear, zfar )
	
	local view = self.BaseClass:CalcView( ply, pos, ang, fov, znear, zfar );
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		local n = self.CombineCameraView;
		local attach = n:GetAttachment( 2 );
		
		if( n:GetClass() == "npc_combine_camera" ) then
			
			attach.Ang:RotateAroundAxis( attach.Ang:Forward(), -90 );
			attach.Ang:RotateAroundAxis( attach.Ang:Up(), -90 );
			
		end
		
		attach.Pos = attach.Pos + attach.Ang:Forward() * 5;
		
		view.origin = attach.Pos;
		view.angles = attach.Ang;
		
		return view;
		
	end
	
	if( LocalPlayer():APC() and LocalPlayer():APC():IsValid() ) then
		
		local mn, mx = LocalPlayer():APC():GetRenderBounds();
		local radius = ( mn - mx ):Length();
		
		local target = LocalPlayer():APC():GetPos() + ( mn + mx ) / 2 + view.angles:Forward() * -radius;
		
		local trace = { };
		trace.start = view.origin;
		trace.endpos = target;
		trace.filter = { LocalPlayer():APC(), LocalPlayer() }
		trace.mins = Vector( -4, -4, -4 );
		trace.maxs = Vector( 4, 4, 4 );
		local tr = util.TraceHull( trace );
		
		view.origin = tr.HitPos;
		view.drawviewer = true;
		
		if( tr.Hit and !tr.StartSolid ) then
			
			view.origin = view.origin + tr.HitNormal * 4;
			
		end
		
		return view;
		
	end
	
	if( self.IntroCamStart and self.IntroCamData ) then
		
		if( CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
			
			local stage = math.Clamp( math.ceil( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ), 1, #self.IntroCamText );
			
			if( self.IntroCamData ) then
				
				local p1, p2, a1, a2;
				
				if( self.IntroCamData[stage] ) then
					
					p1 = self.IntroCamData[stage][1][1];
					p2 = self.IntroCamData[stage][1][2];
					a1 = self.IntroCamData[stage][2][1];
					a2 = self.IntroCamData[stage][2][2];
					
				else
					
					p1 = self.IntroCamData[#self.IntroCamData][1][1];
					p2 = self.IntroCamData[#self.IntroCamData][1][2];
					a1 = self.IntroCamData[#self.IntroCamData][2][1];
					a2 = self.IntroCamData[#self.IntroCamData][2][2];
					
				end
				
				local mul = ( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ) - ( stage - 1 );
				
				view.origin = LerpVector( mul, p1, p2 );
				view.angles = LerpAngle( mul, a1, a2 );
				
				return view;
				
			end
			
		end
		
	end
	
	if( self.CharCreate or CCP.Quiz ) then
		
		if( self.GetHL2CamPos ) then
			
			tab = self:GetHL2CamPos();
			
			self.ThirdCurPos = view.origin;
			self.ThirdCurAng = view.angles;
			
			view.origin = tab[1];
			view.angles = tab[2];
			
			return view;
			
		end
		
	end
	
	if( cookie.GetNumber( "zc_headbob", 0 ) == 1 ) then
		
		local hmul = 0;
		local len2d = ply:GetVelocity():Length2D();
		
		if( len2d > 5 and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:OnGround() ) then
			
			hmul = math.Clamp( len2d / 200, 0, 1 );
			
		end
		
		if( hmul > 0 ) then
			
			view.angles.p = view.angles.p + math.sin( CurTime() * 5 ) * hmul;
			view.angles.y = view.angles.y + math.cos( CurTime() * 4 ) * 0.5 * hmul;
			
		end
		
	end
	
	if( !view ) then return end
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() ) then
		
		if( wep.TranslateFOV ) then
			
			view.fov = wep:TranslateFOV( view.fov );
			
		end
		
	end
	
	return view;
	
end

function GM:ShouldDrawLocalPlayer( ply )
	
	if( self:InIntroCam() ) then
		
		return true;
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		return true;
		
	end
	
	return false;
	
end

function GM:DrawCharCreate()
	
	if( self.CharCreate ) then
		
		if( !self.GetHL2CamPos ) then
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		else
			
			draw.DrawBackgroundBlur( 1 );
			
		end
		
	end
	
end

function GM:DrawFancyIntro()
	
	if( self.IntroCamStart and self.IntroCamData ) then
		
		if( CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
			
			local stage = math.Clamp( math.ceil( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ), 1, #self.IntroCamText );
			
			if( self.IntroCamText[stage] ) then
				
				local timesince = ( CurTime() - self.IntroCamStart ) - ( ( stage - 1 ) * self.IntroCamDelay );
				local a = 1;
				
				if( timesince < 2.5 ) then
					
					a = timesince / 2.5;
					
				end
				
				if( timesince > self.IntroCamDelay - 1 ) then
					
					a = 1 - ( timesince - ( self.IntroCamDelay - 1 ) );
					
				end
				
				local _, h = surface.GetTextSize( self.IntroCamText[stage] );
				
				h = h + 20;
				
				draw.RoundedBox( 0, 0, ScrH() * ( 360 / 480 ) - 10, ScrW(), h, Color( 30, 30, 30, a * 200 ) );
				
				draw.DrawText( self.IntroCamText[stage], "CombineControl.HL2CreditText", ScrW() * ( 96 / 640 ), ScrH() * ( 360 / 480 ), Color( 255, 255, 255, a * 128 ), 0 );
				
			end
			
		end
		
	end
	
end

function GM:DrawConsciousness()
	
	if( !LocalPlayer():PassedOut() and LocalPlayer():Consciousness() < 60 ) then
		
		draw.DrawBackgroundBlur( 1 - LocalPlayer():Consciousness() / 60 );
		
		surface.SetDrawColor( Color( 0, 0, 0, 150 * ( 1 - LocalPlayer():Consciousness() / 60 ) ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	if( LocalPlayer().DrawWakeUp and CurTime() - LocalPlayer().DrawWakeUp <= 3 ) then
		
		local frac = ( CurTime() - LocalPlayer().DrawWakeUp ) / 3;
		
		draw.DrawBackgroundBlur( 1 - frac );
		
		surface.SetDrawColor( Color( 0, 0, 0, 255 * ( 1 - frac ) ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
end

function GM:DrawTimedProgress()
	
	local yc = 0;
	
	if( !self.TimedProgressBars ) then self.TimedProgressBars = { } end
	
	for k, v in pairs( self.TimedProgressBars ) do
		
		if( v.Start and CurTime() < v.End ) then
			
			if !v.no_cancel then
				if( !v.Player or !v.Player:IsValid() or v.Player:GetPos():Distance( LocalPlayer():GetPos() ) > 100 or v.Player:GetVelocity():Length() > 5 or LocalPlayer():GetVelocity():Length() > 5 ) then
					
					table.remove( self.TimedProgressBars, k );
					continue;
					
				end
			end
			
			surface.SetDrawColor( 30, 30, 30, 200 );
			surface.DrawRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40 + yc, 400, 40 );
			
			surface.SetDrawColor( 150, 20, 20, 255 );
			surface.DrawRect( ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1 + yc, ( 400 - 2 ) * math.min( ( CurTime() - v.Start ) / ( v.End - v.Start ), 1 ), 40 - 2 );
			
			local y = self.FontHeight["CombineControl.LabelBig"];
			
			draw.DrawText( v.Text, "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2 + yc, Color( 200, 200, 200, 255 ), 1 );
			
		end
		
		if( v.End and CurTime() >= v.End ) then
			
			v.CB( self );
			
			table.remove( self.TimedProgressBars, k );
			
		end
		
		yc = yc + 60;
		
	end
	
end

function GM:DrawPassedOut()
	
	if( LocalPlayer():PassedOut() ) then
		
		if( !LocalPlayer():Alive() ) then
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
			draw.DrawText( "You have died.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
			
			return;
			
		end
		
		surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		draw.DrawText( "You are unconscious.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40 );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40 );
		
		surface.SetDrawColor( 150, 20, 20, 255 );
		surface.DrawRect( ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1, ( 400 - 2 ) * math.min( LocalPlayer():Consciousness() / 100, 1 ), 40 - 2 );
		
		local y = self.FontHeight["CombineControl.LabelBig"];
		
		if( LocalPlayer():Ragdoll() and LocalPlayer():Ragdoll():IsValid() ) then
			
			if( LocalPlayer():Ragdoll():GetVelocity():Length() > 15 ) then
				
				draw.DrawText( "You're being moved.", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color( 200, 200, 200, 255 ), 1 );
				return;
				
			end
			
		end
		
		draw.DrawText( tostring( LocalPlayer():Consciousness() ) .. "%", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color( 200, 200, 200, 255 ), 1 );
		
	end
	
end

local function setup_ammo_display(mdl)
	if GAMEMODE.ammo_display and IsValid(GAMEMODE.ammo_display) then return end
	
	GAMEMODE.ammo_display = ClientsideModel(mdl, RENDERGROUP_OTHER)
	if !IsValid(GAMEMODE.ammo_display) then return end
	
	GAMEMODE.ammo_display:SetNoDraw(true)
end

function GM:DrawPlayerInfo()
	
	local w = 220;
	
	surface.SetFont( "CombineControl.LabelGiant" );
	local x, y = surface.GetTextSize( LocalPlayer():VisibleRPName() );
	
	if( x + 8 > w ) then
		
		w = x + 8;
		
	end
	
	surface.SetMaterial( matHints );
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.DrawTexturedRectUV( ScrW() - ( ScrW() / 7 ), ScrH() - ( ScrH() / 7 ), ScrW() / 8, ScrH() / 8, 0.843, 0.04, 0.98, 0.137 );
	
	local weapon = LocalPlayer():GetActiveWeapon()
	if weapon and weapon:IsValid() then
		local metaitem = GAMEMODE:GetItemByID(weapon:GetPrimaryAmmoType())
		if metaitem then
			local ent = GAMEMODE.ammo_display
			if !ent or !IsValid(ent) then
				setup_ammo_display(metaitem.Model)
			else
				if metaitem.Model != ent:GetModel() then
					ent:SetModel(metaitem.Model)
				end
				local fov
				local cam_pos
				local lookat
				if metaitem.LookAt then
					fov = metaitem.FOV
					cam_pos = metaitem.CamPos
					lookat = metaitem.LookAt
				else
					local a, b = ent:GetModelBounds();
					fov = 15
					cam_pos = Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5
					lookat = ( a + b ) / 2
				end
				local ang = (lookat - cam_pos):Angle()
				
				local width = ScreenScaleH(48)
				local height = ScreenScaleH(24)
				local pos_x = (ScrW() - (ScrW() / 17)) - (width / 2)
				local pos_y = (ScrH() - (ScrH() / 19)) - (height / 2)
				local endpos_x = pos_x + width
				local endpos_y = pos_y + height
			
				cam.Start3D(cam_pos, ang, fov, pos_x, pos_y, width, height, 5, 4096)
					render.SuppressEngineLighting(true)
					render.SetLightingOrigin(ent:GetPos())
					render.ResetModelLighting(1, 1, 1)
					render.SetColorModulation(1, 1, 1)
					render.SetBlend(1)

					render.SetScissorRect( pos_x, pos_y, endpos_x, endpos_y, true )
						ent:DrawModel()
					render.SetScissorRect( 0, 0, 0, 0, false )

					render.SuppressEngineLighting( false )
				cam.End3D()
			end
		end
		
		if weapon.IsTFAWeapon then
			local mode = weapon:GetFireModeName()[1]
			surface.SetTextColor(220, 220, 220)
			surface.SetFont("CombineControl.ChatBig")
			surface.SetTextPos(ScrW() - (ScrW() / 8.63), ScrH() - (ScrH() / 13.5))
			surface.DrawText(mode)
			
			local mag = weapon:Clip1()
			surface.SetTextColor(193, 170, 140)
			surface.SetFont("CombineControl.ChatBig")
			surface.SetTextPos(ScrW() - (ScrW() / 11.5), ScrH() - (ScrH() / 10))
			surface.DrawText(mag)
			
			local total = weapon:GetOwner():GetAmmoCount(weapon:GetPrimaryAmmoType())
			surface.SetTextColor(198, 160, 99)
			surface.SetFont("CombineControl.ChatBig")
			surface.SetTextPos(ScrW() - (ScrW() / 24), ScrH() - (ScrH() / 10))
			surface.DrawText(total)
		end
		
	end

end

local function GetMetaMethod(tbl, func)
	return FindMetaTable(tbl)[func]
end

local gmod_GetGamemode = gmod.GetGamemode
local math_Clamp = math.Clamp
local math_abs = math.abs
local draw_DrawTextShadow = draw.DrawTextShadow
local wrapText = wrapText
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local FrameTime = FrameTime
local Color = Color
local tostring = tostring
local IsValid = IsValid
local ScrW = ScrW
local ScrH = ScrH
local CurTime = CurTime
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
local surface_SetDrawColor = surface.SetDrawColor
local draw_RoundedBox = draw.RoundedBox
local render_SetScissorRect = render.SetScissorRect

local Entity_Health = GetMetaMethod("Entity", "Health")
local Entity_GetMaxHealth = GetMetaMethod("Entity", "GetMaxHealth")

local Player_Hunger = GetMetaMethod("Player", "Hunger")
local Player_VisibleRPName = GetMetaMethod("Player", "VisibleRPName")
local Player_Toughness = GetMetaMethod("Player", "Toughness")
local Player_LastLegShot = GetMetaMethod("Player", "LastLegShot")

local COLOR_BACKBAR = Color(30,30,30,200)
local COLOR_LEGSHOT = Color(150, 150, 100, 255)
local COLOR_HUNGER = Color(37, 150, 37, 255)

local statusMatData = {
	{
		u0 = 0.535,
		v0 = 0.9626,
		u1 = 0.565,
		v1 = 0.994
	},	
	{
		u0 = 0.012,
		v0 = 0.867,
		u1 = 0.042,
		v1 = 0.899
	},
	{
		u0 = 0.012,
		v0 = 0.907,
		u1 = 0.042,
		v1 = 0.939
	},
	{
		u0 = 0.012,
		v0 = 0.948,
		u1 = 0.042,
		v1 = 0.98
	},
}

function GM:DrawHealthBars()

	if !self.LocalPlayer then
		self.LocalPlayer = LocalPlayer()
	end
	
	if( !self.HPDraw ) then self.HPDraw = 100 end
	if( !self.HGDraw ) then self.HGDraw = 0 end
	
	local hp = Entity_Health(self.LocalPlayer);
	local hg = Player_Hunger(self.LocalPlayer);
	
	if( self.HPDraw > hp ) then
		
		self.HPDraw = self.HPDraw - 0.5;
		
	elseif( self.HPDraw < hp ) then
		
		self.HPDraw = self.HPDraw + 0.5;
		
	end
	
	if( math_abs( self.HPDraw - hp ) < 1 ) then
		
		self.HPDraw = hp;
		
	end

	local maxHealth = Entity_GetMaxHealth(self.LocalPlayer)
	local scrW, scrH = ScrW(), ScrH()
	
	self.HPDraw = math_Clamp( self.HPDraw, 0, maxHealth );
	self.HGDraw = math_Clamp( self.HGDraw, 0, 100 );
	
	local w = scrW * 0.12;
	local y = scrH - 24;
	
	if( self.HPDraw > 0 ) then
	
		local u0 = scrW - ( scrW / 7.38 );
		local v0 = scrH - ( scrH / 7.5 );
		local u1 = scrW - ( scrW / 7.38 ) + ( scrW / 9.3 ) * ( self.HPDraw / maxHealth );
		local v1 = scrH - ( scrH / 7.5 ) + 8;
	
		surface_SetMaterial( matHints );
		surface_SetDrawColor( 255, 255, 255, 255 );
		render_SetScissorRect( u0, v0, u1, v1, true );
			surface_DrawTexturedRectUV( u0, v0, scrW / 9.3, 8, 0.764, 0.151, 0.857, 0.156 );
		render_SetScissorRect( 0, 0, 0, 0, false );
		
	end
	
	local b = 15 - ( Player_Toughness(self.LocalPlayer) / 100 * 15 );
	b = b + ( hg / 100 ) * 10;

	local lastLegShot = Player_LastLegShot(self.LocalPlayer)
	
	if( CurTime() - lastLegShot < b + 5 ) then
		
		local mul = 1 - ( CurTime() - lastLegShot ) / ( b + 5 );
		
		draw_RoundedBox( 0, 20, y, w, 14, COLOR_BACKBAR );
		draw_RoundedBox( 0, 22, y + 2, ( w - 4 ) * mul, 10, COLOR_LEGSHOT );
		
		y = y - 16;
		
	end

	if( self.UseHunger ) then

		local hungerStage = math.ceil(hg / 20)

		local x, y, w, h = ScrW() * 0.95, ScrH() * 0.8, 32, 32
	
		if hungerStage > 1 then
			local uvData = statusMatData[hungerStage - 1]
			surface_SetMaterial( matHints );
			surface_SetDrawColor( 255, 255, 255, 255 );
			surface_DrawTexturedRectUV( x, y, w, h, uvData.u0, uvData.v0, uvData.u1, uvData.v1 );
		end
	end
	
end

function GM:GetPlayerSight()
	
	/*local range = 256;
	range = range + ( LocalPlayer():Perception() ) * 20.48;
	range = range - ( LocalPlayer():Hunger() / 100 ) * 200;*/
	
	return 512;
	
end

GM.NPCDrawBlacklist = {
	"npc_antlion_grub",
	"npc_barnacle_tongue_tip",
	"npc_bullseye",
	"monster_generic"
}

local PositionOffset = Vector(0,0,10)

local Entity_GetPos = GetMetaMethod("Entity", "GetPos")
local Entity_IsValid = GetMetaMethod("Entity", "IsValid")
local Entity_GetClass = GetMetaMethod("Entity", "GetClass")
local Entity_PropCreator = GetMetaMethod("Entity", "PropCreator")
local Entity_PropSteamID = GetMetaMethod("Entity", "PropSteamID")
local Entity_GetNoDraw = GetMetaMethod("Entity", "GetNoDraw")
local Entity_PropDesc = GetMetaMethod("Entity", "PropDesc")
local Entity_GetRotatedAABB = GetMetaMethod("Entity", "GetRotatedAABB")
local Entity_OBBMins = GetMetaMethod("Entity", "OBBMins")
local Entity_OBBMaxs = GetMetaMethod("Entity", "OBBMaxs")
local Entity_EyePos = GetMetaMethod("Entity", "EyePos")

local Player_CanSee = GetMetaMethod("Player", "CanSee")
local Player_GetActiveWeapon = GetMetaMethod("Player", "GetActiveWeapon")
local Player_GetViewEntity = GetMetaMethod("Player", "GetViewEntity")
local Player_Ragdoll = GetMetaMethod("Player", "Ragdoll")
local Player_Alive = GetMetaMethod("Player", "Alive")
local Player_GetEyeTraceNoCursor = GetMetaMethod("Player", "GetEyeTraceNoCursor")

local Vector_DistToSqr = GetMetaMethod("Vector", "DistToSqr")
local Vector_ToScreen = GetMetaMethod("Vector", "ToScreen")

local function WithinRadius(pos1, pos2, d)
	return Vector_DistToSqr(pos1, pos2) < d * d
end

local SeeAllEntityRequirements = {
	prop_physics = function(v)
		return #v:PropDesc() > 0
	end
}

local EntityRenderingFuncs = {
	prop_physics = function(v)
		local self = gmod_GetGamemode()

		if !self.LocalPlayer then
			self.LocalPlayer = LocalPlayer()
		end

		local propDesc = Entity_PropDesc(v)
		local physgunOut = IsValid(ActiveWeapon) and Entity_GetClass(ActiveWeapon) == "weapon_physgun"

		if #propDesc == 0 and !physgunOut then return end

		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local entPos = Entity_GetPos(v)
		local pos = Vector_ToScreen(entPos + PositionOffset)
		local localply = self.LocalPlayer
		local selfPos = Entity_GetPos(self.LocalPlayer)
		
		if pos.visible and Player_CanSee(localply, v) and WithinRadius(selfPos, entPos, 256) then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif v.HUDAlpha > 0 then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		local ActiveWeapon = Player_GetActiveWeapon(localply)
		
		if( v.HUDAlpha > 0 and physgunOut ) then
			
			draw_DrawTextShadow( Entity_PropCreator(v), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 24;
			draw_DrawTextShadow( Entity_PropSteamID(v), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 14;
			
		end
		
		if( v.HUDAlpha > 0 and #propDesc > 0) then
		
			local lines, maxW = wrapText( propDesc, 512, "CombineControl.LabelSmall" );
			
			for m,n in ipairs(lines) do
			
				surface_SetFont( "CombineControl.LabelSmall" );
				local w,h = surface_GetTextSize( n );
				draw_DrawTextShadow( n, "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + h + 2;
			
			end
			
		end
	end,
	prop_ragdoll = function(v)
		local self = gmod_GetGamemode()

		if !self.LocalPlayer then
			self.LocalPlayer = LocalPlayer()
		end

		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local entPos = Entity_GetPos(v)
		local pos = Vector_ToScreen(entPos + PositionOffset)
		local localply = self.LocalPlayer
		local selfPos = Entity_GetPos(self.LocalPlayer)
		
		if pos.visible and Player_CanSee(localply, v) and WithinRadius(selfPos, entPos, 256) then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif v.HUDAlpha > 0 then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		local ActiveWeapon = Player_GetActiveWeapon(localply)
		
		if( v.HUDAlpha > 0 and IsValid(ActiveWeapon) and Entity_GetClass(ActiveWeapon) == "weapon_physgun" ) then
			
			draw_DrawTextShadow( Entity_PropCreator(v), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 24;
			draw_DrawTextShadow( Entity_PropSteamID(v), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 14;
			
		end
		
		if( v.HUDAlpha > 0 ) then
		
			local lines, maxW = wrapText( Entity_PropDesc(v), 512, "CombineControl.LabelMedium" );
			
			for m,n in ipairs(lines) do
			
				surface_SetFont( "CombineControl.LabelMedium" );
				local w,h = surface_GetTextSize( n );
				draw_DrawTextShadow( n, "CombineControl.LabelMedium", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + h + 2;
			
			end
			
		end
	end,
	cc_item = function(v)
		local self = gmod_GetGamemode()

		if !self.LocalPlayer then
			self.LocalPlayer = LocalPlayer()
		end

		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local entPos = Entity_GetPos(v)
		local pos = Vector_ToScreen(entPos + PositionOffset)
		local localply = self.LocalPlayer
		local selfPos = Entity_GetPos(self.LocalPlayer)
		local eyeEnt = Player_GetEyeTraceNoCursor(localply).Entity
		
		if self.SeeAll or (pos.visible and WithinRadius(selfPos, entPos, 256) and eyeEnt == v) then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif v.HUDAlpha > 0 then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
		
			if( !self.SeeAll and (Entity_GetNoDraw(v) or eyeEnt != v) ) then
			
				return;
				
			end
			
			local metaitem = GAMEMODE:GetItemByID(v:GetItemClass())
			local name = v:GetItemName() or metaitem.Name
			local weight = v:GetItemWeight() or metaitem.Weight
			
			draw_DrawTextShadow( name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			draw_DrawTextShadow( "Weight - " .. tostring( weight ), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 16;
			
		end
	end,
	cc_paper = function(v)
		local self = gmod_GetGamemode()

		if !self.LocalPlayer then
			self.LocalPlayer = LocalPlayer()
		end

		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end

		local localply = self.LocalPlayer
		local selfPos = Entity_GetPos(self.LocalPlayer)
		local entPos = Entity_GetPos(v)

		local a, b = Entity_GetRotatedAABB(v, Entity_OBBMins(v), Entity_OBBMaxs(v))
		local wpos = entPos + (a + b) / 2
		local pos = Vector_ToScreen(wpos)
		
		if pos.visible and Player_CanSee(localply, v) and WithinRadius(selfPos, entPos, 256) then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif v.HUDAlpha > 0 then
			
			v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw_DrawTextShadow( "Paper", "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			draw_DrawTextShadow( "Press C to read.", "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 16;
			
		end
	end,
	player = function(v)
		local self = gmod_GetGamemode()

		if !self.LocalPlayer then
			self.LocalPlayer = LocalPlayer()
		end

		local localply = self.LocalPlayer
		local selfPos = Entity_GetPos(localply)
		local entPos = Entity_EyePos(v)

		if v != localply or Player_GetViewEntity(localply) != localply then
			if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
			if( !v.TitleAlpha ) then v.TitleAlpha = 0; end
			
			local pos = Vector_ToScreen(entPos + PositionOffset)
			local ragdoll = Player_Ragdoll(v)

			if IsValid(ragdoll) then
				pos = Vector_ToScreen(Entity_EyePos(ragdoll) + PositionOffset)
				
				if( ( self.SeeAll or ( pos.visible and Player_CanSee(localply, ragdoll) and WithinRadius(selfPos, Entity_GetPos(ragdoll), 512) ) ) and Player_Alive(v) ) then
					
					v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
					
				elseif( v.HUDAlpha > 0 ) then
					
					v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
					
				end
			else
				if( ( self.SeeAll or ( pos.visible and Player_CanSee(localply, v) and WithinRadius(selfPos, entPos, 512) and !Entity_GetNoDraw(v) ) ) and Player_Alive(v) ) then
					
					v.HUDAlpha = math_Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
					
				elseif( v.HUDAlpha > 0 ) then
					
					v.HUDAlpha = math_Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
					
				end
				
				if( ( pos.visible and Player_CanSee(localply, v) and WithinRadius(selfPos, entPos, 512) and !Entity_GetNoDraw(v) ) and Player_Alive(v) and Player_GetEyeTraceNoCursor(localply).Entity == v ) then
				
					v.TitleAlpha = math_Clamp( v.TitleAlpha + FrameTime(), 0, 1 );
				
				elseif( v.TitleAlpha > 0 ) then
				
					v.TitleAlpha = math_Clamp( v.TitleAlpha - FrameTime(), 0, 1 );
				
				end
				
			end
			
			if( v.HUDAlpha > 0 ) then
				
				local c = team.GetColor( v:Team() );
				draw_DrawTextShadow( v:VisibleRPName(), "CombineControl.PlayerFont", pos.x, pos.y, Color( c.r, c.g, c.b, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + 20;
				
				if v:TiedUp() then
					if v:IsWounded() then
						draw_DrawTextShadow( "They're wounded.", "CombineControl.LabelSmall", pos.x, pos.y, Color( 255, 80, 80, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
						pos.y = pos.y + 20;
					else
						draw_DrawTextShadow( "They're tied up.", "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
						pos.y = pos.y + 20;
					end
				end
				
				if( v:Typing() ) then
					
					draw_DrawTextShadow( "Typing...", "CombineControl.LabelSmallItalic", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
				if( self.SeeAll ) then
					
					draw_DrawTextShadow( tostring( v:Health() ) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 0, 0, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
			end
			
			if( v.TitleAlpha > 0 ) then
			
				if( #v:TitleOne() > 0 ) then
			
					draw_DrawTextShadow( v:TitleOne(), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.TitleAlpha * 255 ), Color( 0, 0, 0, v.TitleAlpha * 255 ), 1 );
					pos.y = pos.y + 12;
					
				end
				
				if( #v:TitleTwo() > 0 ) then
				
					draw_DrawTextShadow( v:TitleTwo(), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.TitleAlpha * 255 ), Color( 0, 0, 0, v.TitleAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
			
			end
			
		end
	end,
}

local function AddNumericalTables(dest, source)
	-- At least one of them needs to be a table or this whole thing will fall on its ass
	if ( !istable( source ) ) then return dest end
	if ( !istable( dest ) ) then dest = {} end

	for k, v in ipairs( source ) do
		table.insert( dest, v )
	end

	return dest
end

hook.Add("Think", "MaintainHUDEntList", function()
	if GAMEMODE.SeeAll then
		if !GAMEMODE.NextHUDEntUpdate then
			GAMEMODE.NextHUDEntUpdate = CurTime()
		end

		if GAMEMODE.NextHUDEntUpdate <= CurTime() then
			GAMEMODE.HUDEntList = {}

			for class,func in next, EntityRenderingFuncs do
				local entReqs = SeeAllEntityRequirements[class]
				if entReqs then
					for _,v in ipairs(ents.FindByClass(class)) do
						if entReqs(v) then table.insert(GAMEMODE.HUDEntList, v) end
					end
				else
					AddNumericalTables(GAMEMODE.HUDEntList, ents.FindByClass(class))
				end
			end

			GAMEMODE.NextHUDEntUpdate = CurTime() + 5
		end
	end
end)

function GM:DrawEntities()
	if self.SeeAll and LocalPlayer():HasPermission("seeall") and LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP then
		self.SeeAll = false

		return
	end

	local entsToLoop = self.SeeAll and self.HUDEntList or ents.FindInSphere(LocalPlayer():GetPos(), 700)

	for _,v in ipairs(entsToLoop) do
		if !IsValid(v) then continue end

		local func = EntityRenderingFuncs[v:GetClass()]
		if func then func(v) end
	end
	
	/*
	for _, v in ipairs( ents.FindByClass( "npc_*" ) ) do
		
		if( table.HasValue( self.NPCDrawBlacklist, v:GetClass() ) ) then continue; end
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = ( v:EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
		
		if( self.SeeAll and v:Health() > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( "#" .. v:GetClass(), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 100, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
		end
		
	end
	*/
	
end

function GM:DrawDoors()
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local a, b = v:GetRotatedAABB( v:OBBMins(), v:OBBMaxs() );
		local wpos = ( v:GetPos() + ( a + b ) / 2 );
		
		local pos = wpos:ToScreen();
		
		if( pos.visible and v:GetPos():Distance( LocalPlayer():GetPos() ) <= self:GetPlayerSight() ) then
			
			local trace = { };
			trace.start = LocalPlayer():EyePos();
			trace.endpos = trace.start + LocalPlayer():GetAimVector() * self:GetPlayerSight();
			trace.filter = LocalPlayer();
			trace.mask = MASK_SOLID;
			local tr = util.TraceLine( trace );
			
			if( tr.Entity == v ) then
				
				v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
				
			elseif( v.HUDAlpha > 0 ) then
				
				v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
				
			end
			
		else
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			local name = v:DoorOriginalName();
			
			if( v:DoorName() != "" ) then
				
				name = v:DoorName();
				
			end
			
			draw.DrawTextShadow( name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			if( ( v:DoorType() == DOOR_BUYABLE or v:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #v:DoorOwners() == 0 and #v:DoorAssignedOwners() == 0 ) then
				
				draw.DrawTextShadow( v:DoorPrice() .. " rubles", "CombineControl.PlayerFont", pos.x, pos.y, Color( 226, 205, 95, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + 20;
				
			end
			
			if( self.SeeAll ) then
				
				local tab = v:DoorOwners();
				table.Merge( tab, v:DoorAssignedOwners() );
				
				for _, owner in pairs( tab ) do
					
					local ply = nil;
					
					for _, l in pairs( player.GetAll() ) do
						
						if( l:CharID() == owner ) then
							
							ply = l;
							
						end
						
					end
					
					local text = "Owner: CharID #" .. owner;
					
					if( ply and ply:IsValid() ) then
						
						text = "Owner: " .. ply:VisibleRPName();
						
					end
					
					draw.DrawTextShadow( text, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
			end
			
		end
		
	end
	
end

GM.WeaponOutText = { };
GM.WeaponOutText["weapon_physgun"] = "Your physgun is out! Switch to your hands when you're done building.";
GM.WeaponOutText["weapon_physcannon"] = "Your gravgun is out! Switch to your hands when you're done moving things.";
GM.WeaponOutText["gmod_tool"] = "Your toolgun is out! Switch to your hands when you're done building.";

function GM:DrawAmmo()
	
	if( LocalPlayer():InVehicle() ) then
		
		return;
		
	end
	
	local w = LocalPlayer():GetActiveWeapon();
	
	if( w != NULL ) then
		
		if( LocalPlayer():TiedUp() ) then
	
			local text = "You're tied up."
			if LocalPlayer():IsWounded() then
				text = "You're wounded."
			end
			
			surface.SetFont( "CombineControl.LabelGiant" );
			local x1, y1 = surface.GetTextSize( text );
			
			draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color( 30, 30, 30, 200 ) );
			draw.DrawTextShadow( text, "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
			
			return;
			
		end
		
		if( w.Firearm ) then
			
			if( w.Primary.ClipSize > -1 ) then
				
				local clip = w:Clip1();
				
				surface.SetFont( "CombineControl.HUDAmmo" );
				local x1, y1 = surface.GetTextSize( clip );
				local y2 = self.FontHeight["CombineControl.HUDAmmo"];
				
				local x = x1;
				local y = math.max( y1, y2 );

				draw.DrawTextShadow( clip, "CombineControl.HUDAmmo", ScrW() - ( ScrW() / 8 ) / 2.1 - ( x / 2 ), ( ScrH() - ( ScrH() / 8 ) / 3.3 ) - y, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
				
			end
			
		end
		
	end
	
end

local chamsmat = CreateMaterial("aa", "VertexLitGeneric", {
        ["$ignorez"] = 1,
        ["$model"] = 1,
        ["$basetexture"] = "models/debug/debugwhite",
});

hook.Add("PrePlayerDraw", "aaa", function(entity)
	if (GAMEMODE.SeeAllChams) then
		render.SetColorModulation(255, 0, 0);
		render.MaterialOverride(chamsmat);
	end
end)

hook.Add("PostPlayerDraw", "aaa", function(entity)
	render.MaterialOverride(nil);
end)

local BoneWhitelist = {
	["ValveBiped.Bip01_L_Toe0"] = true,
	["ValveBiped.Bip01_L_Foot"] = true,
	["ValveBiped.Bip01_R_Toe0"] = true,
	["ValveBiped.Bip01_R_Foot"] = true,
	["ValveBiped.Bip01_L_Calf"] = true,
	["ValveBiped.Bip01_R_Calf"] = true,
	["ValveBiped.Bip01_L_Thigh"] = true,
	["ValveBiped.Bip01_R_Thigh"] = true,
	["ValveBiped.Bip01_Spine"] = true,
	["ValveBiped.Bip01_Spine1"] = true,
	["ValveBiped.Bip01_Spine2"] = true,
	["ValveBiped.Bip01_Spine4"] = true,
	["ValveBiped.Bip01_L_Hand"] = true,
	["ValveBiped.Bip01_R_Hand"] = true,
	["ValveBiped.Bip01_L_Forearm"] = true,
	["ValveBiped.Bip01_R_Forearm"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_Neck1"] = true,
	["ValveBiped.Bip01_Head1"] = true,
}

hook.Add( "HUDPaint", "test", function()

	if( GAMEMODE.SeeAllBones ) then

		for _,ply in ipairs(player.GetAll()) do
		
			if( ply == LocalPlayer() ) then continue end

			local nBoneCount = ply:GetBoneCount();
			for i = 1, nBoneCount - 1 do
			
				if( !BoneWhitelist[ply:GetBoneName( i )] ) then continue end
			
				local vBonePos,vBoneAngles = ply:GetBonePosition( i );
				local vChildBonePos,vLastBoneAngles = ply:GetBonePosition( ply:GetBoneParent( i ) );
				local scrBonePos = vBonePos:ToScreen();
				local scrChildBonePos = vChildBonePos:ToScreen();

				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.DrawLine( scrBonePos.x, scrBonePos.y, scrChildBonePos.x, scrChildBonePos.y );
			
			end
		
		end
		
	end

end)

function nWarnName()
	
	GAMEMODE.NameWarning = true;
	GAMEMODE.NameWarningStart = CurTime();
	
end
netstream.Hook( "nWarnName", nWarnName );

function GM:DrawWarnings()
	
	if( self.NameWarning and CurTime() - self.NameWarningStart < 15 ) then
		
		local t = CurTime() - self.NameWarningStart;
		local a = 1;
		
		if( t < 1 ) then
			
			a = t;
			
		elseif( t > 14 ) then
			
			a = 1 - ( t - 14 );
			
		end
		
		local h = 250;
		local dh = ( ScrH() - h ) / 2;
		
		draw.RoundedBox( 0, 0, dh, ScrW(), h, Color( 30, 30, 30, 200 * a ) );
		
		draw.DrawText( "WARNING", "CombineControl.LabelStupid", ScrW() / 2, dh + 20, Color( 150, 20, 20, 255 * a ), 1 );
		
		draw.DrawText( "The name you have selected for your character is not appropriate for S.T.A.L.K.E.R. roleplay.\n\nPlease use the F3 menu to select a fitting name.\n\nIf you ignore this warning, you may be subject to a kick or ban.", "CombineControl.LabelGiant", ScrW() / 2, dh + 100, Color( 200, 200, 200, 255 * a ), 1 );
		
	end
	
end

function GM:DrawUnconnected()
	
	if( !self.CharCreateOpened ) then
		
		surface.SetDrawColor( Color( 0, 0, 0, 150 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		draw.DrawBackgroundBlur( 1 );
		
		draw.DrawText( "Please wait...", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
		
	end
	
end

function nFlashRed()
	
	GAMEMODE.FlashRedStart = CurTime();
	
end
netstream.Hook( "nFlashRed", nFlashRed );

function GM:DrawDamage()
	
	if( self.FlashRedStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashRedStart;
		local a = 0;
		
		if( t < 0.1 ) then
			
			a = 0.5;
			
		elseif( t < 0.6 ) then
			
			a = 0.5 - ( t - 0.1 );
			
		end
		
		if( a > 0 ) then
			
			surface.SetDrawColor( 128, 0, 0, 255 * a );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		end
		
	end
	
end

GM.Notifications = { };

function nAddNotification( str )
	GAMEMODE:AddNotification(str)
end
netstream.Hook( "nAddNotification", nAddNotification );

function GM:AddNotification( text, col )
	
	local n = 0;
	
	for _, m in pairs( self.Notifications ) do
		
		for _, v in pairs( self.Notifications ) do
			
			if( v[3] == n ) then
				
				n = v[3] + 1;
				
			end
			
		end
		
	end
	
	table.insert( self.Notifications, { text, CurTime(), n, col } );
	
end

function GM:DrawNotifications()
	
	for k, v in pairs( self.Notifications ) do
		
		local t = v[2];
		local n = v[3];
		local col = v[4];
		
		if( CurTime() - t > 10 ) then
			
			table.remove( self.Notifications, k );
			continue;
			
		end
		
		local a = 1;
		
		if( CurTime() - t < 0.5 ) then
			
			a = ( CurTime() - t ) / 0.5;
			
		elseif( CurTime() - t > 6 ) then
			
			a = 1 - ( CurTime() - t - 6 ) / 4;
			
		end
		
		if( !col ) then
			
			col = Color( 200, 200, 200, 255 * a )
			
		else
			
			col = Color( col.r, col.g, col.b, 255 * a )
			
		end
		
		surface.SetFont( "CombineControl.LabelGiant" );
		local x1, y1 = surface.GetTextSize( v[1] );
		
		draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ), x1 + 4, y1 + 4, Color( 30, 30, 30, 200 * a ) );
		draw.DrawTextShadow( v[1], "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ) + 2, Color( 200, 200, 200, 255 * a ), Color( 0, 0, 0, 255 * a ), 0 );
		
	end
	
end

GM.PDANotifications = GM.PDANotifications or { };

function GM:DrawPDANotifications()
	local y_pos = ScrH() - ScrH() / 14
	local y = 0
	for i=#self.PDANotifications, 1, -1 do
		local v = self.PDANotifications[i]
		local a = v.paint_alpha
		if v.start + 10 <= CurTime() then
			v.paint_alpha = math.Clamp( v.paint_alpha - FrameTime(), 0, 1 );
		end
	
		local skin = kingston.gui.classes["STALKER"];
		local n = skin.PDANotification[1];
		local u0 = ( ( n.u1 * v.notif_x ) - ( ( n.u1 * v.notif_x ) / v.notif_x ) );
		local v0 = ( ( n.v1 * v.notif_y ) - ( ( n.v1 * v.notif_y ) / v.notif_y ) );
		local u1 = n.u1 * v.notif_x;
		local v1 = n.v1 * v.notif_y;

		surface.SetDrawColor( 255, 255, 255, 255 * a );
		surface.SetMaterial( n.mat );
		
		surface.DrawTexturedRectUV( ScrW() / 100, y_pos + y, ScrW() / 16, ScrH() / 18, u0, v0, u1, v1 );
		
		surface.SetFont( "PDA.LabelHeader" )
		local header_w,header_h = surface.GetTextSize( v.header )
		local x = ScrW() / 100 + ScrW() / 16 + 8
		
		draw.DrawTextShadow( v.header, "PDA.LabelHeader", x, y_pos + y, Color( 128, 128, 128, 255 * a ), Color( 0, 0, 0, 255 * a ), 0 );
		
		local lbl_y = y + header_h
		local lines_body = string.Explode( "\n", GAMEMODE:FormatLine( v.body or "", "PDA.LabelHeader", ScrW() / 3 ) );

		for _,line in next, lines_body do
			surface.SetFont( "PDA.LabelHeader" )
			local w,h = surface.GetTextSize( line )
			
			draw.DrawTextShadow( line, "PDA.LabelHeader", x, y_pos + lbl_y, Color( 229, 201, 98, 255 * a ), Color( 0, 0, 0, 255 * a ), 0 );
			
			lbl_y = lbl_y + h
		end
		
		y = y - math.Clamp((lbl_y + header_h), ScrH() / 16, ScrH())
		
		if a == 0 then
			table.remove(self.PDANotifications, i)
		end
	end
end

function GM:HUDPaint()
	
	if( !CCP ) then return end
	
	if( self:InIntroCam() ) then
		
		self:DrawFancyIntro();
		return;
		
	end
	
	self:DrawCharCreate();
	
	if( !self.CharCreate ) then
		
		if( cookie.GetNumber( "zc_hud", 1 ) == 1 and !self.Mastermind ) then
			
			self:DrawDamage();
			self:DrawConsciousness();
			--self:DrawDoors();
			self:DrawEntities();
			self:DrawPlayerInfo();
			self:DrawHealthBars();
			self:DrawAmmo();
			self:DrawWeaponSelect();
			self:DrawTimedProgress();
			self:DrawPassedOut();
			self:DrawNotifications();
			self:DrawPDANotifications();
			
		end
		
		if( self.Mastermind ) then
			
			self:DrawEntities();
			
		end
		
		if( cookie.GetNumber( "zc_chat", 1 ) == 1 ) then
			
			self:DrawChat();
			self:DrawRadioChat();
			
		end
		
		if( cookie.GetNumber( "zc_hud", 1 ) != 1 ) then
			
			self:DrawConsciousness();
			self:DrawWeaponSelect();
			self:DrawPassedOut();
			
		end
		
		self:DrawWarnings();
		self:DrawUnconnected();
		
	end
	
end

function GM:HUDShouldDraw( str )
	
	if( str == "CHudWeaponSelection" ) then return false end
	if( str == "CHudAmmo" ) then return false end
	if( str == "CHudAmmoSecondary" ) then return false end
	if( str == "CHudHealth" ) then return false end
	if( str == "CHudBattery" ) then return false end
	if( str == "CHudChat" ) then return false end
	if( str == "CHudDamageIndicator" ) then return false end
	
	if( str == "CHudCrosshair" ) then
		
		local wep = LocalPlayer():GetActiveWeapon();
		
		if( wep and wep:IsValid() and wep != NULL ) then
			
			if( wep:GetClass() == "gmod_tool" or wep:GetClass() == "weapon_physgun" or wep:GetClass() == "weapon_physcannon" ) then
				
				return true
				
			end
			
		end
		
		return false;
		
	end
	
	return true
	
end

GM.MastermindMat = Material( "vgui/white" );

function GM:RenderNPCTargets()
	
	if( self.Mastermind ) then
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v:NPCTargetPos() != Vector() ) then
				
				local col = v:NPCMastermindColor();
				
				cam.Start3D2D( v:NPCTargetPos() + Vector( 0, 0, 1 ), Angle(), 1 );
					
					surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
					surface.SetDrawColor( col.x, col.y, col.z, 255 );
					surface.DrawTexturedRect( -10, -10, 20, 20 );
					
				cam.End3D2D();
				
				render.DrawLine( v:GetPos(), v:NPCTargetPos(), Color( col.x, col.y, col.z, 255 ), false );
				
			end
			
		end
		
		if( self.MastermindSelected and self.MastermindSelected:IsValid() ) then
			
			local trace = { };
			trace.start = LocalPlayer():GetShootPos();
			trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
			trace.filter = LocalPlayer();
			
			if( self.MastermindMouse and self.MastermindMouse == 109 ) then
				
				trace.endpos = LocalPlayer():GetPos();
				
			end
			
			local tr = util.TraceLine( trace );
			
			cam.Start3D2D( tr.HitPos + Vector( 0, 0, 1 ), Angle(), 1 );
				
				surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
				surface.SetDrawColor( 200, 200, 200, 255 );
				surface.DrawTexturedRect( -10, -10, 20, 20 );
				
			cam.End3D2D();
			
			render.DrawLine( self.MastermindSelected:GetPos(), tr.HitPos, Color( 200, 200, 200, 255 ), false );
			
		end
		
	end
	
end

function GM:PostDrawOpaqueRenderables()
	
	if self.Mastermind then
		self:RenderNPCTargets();
	end
	
	if( self.MapPostDrawOpaqueRenderables ) then
		
		self:MapPostDrawOpaqueRenderables();
		
	end
	
end

function GM:GetCursorNPC( max )
	
	local dist = max;
	local ent = nil;
	
	for _, v in pairs( ents.GetNPCs() ) do
		
		local pos = v:GetPos():ToScreen();
		local x, y = gui.MousePos();
		
		local d = math.sqrt( ( pos.x - x ) ^ 2 + ( pos.y - y ) ^ 2 );
		
		if( d < dist ) then
			
			ent = v;
			dist = d;
			
		end
		
	end
	
	return ent;
	
end

function GM:GetCursorEnt()
	
	local trace = { };
	trace.start = LocalPlayer():GetShootPos();
	trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
	trace.filter = LocalPlayer();
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() ) then
		
		return tr.Entity;
		
	end
	
end

function GM:PreDrawHalos()
	
	if( self.Mastermind ) then
		
		local hEnt = nil;
		
		if( vgui.IsHoveringWorld() and !self.MastermindSelected ) then
			
			hEnt = self:GetCursorNPC( 200 );
			
		end
		
		local tab = { };
		
		if( hEnt ) then
			
			if( hEnt.GetActiveWeapon and hEnt:GetActiveWeapon() and hEnt:GetActiveWeapon():IsValid() ) then
				
				halo.Add( { hEnt, hEnt:GetActiveWeapon() }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			else
				
				halo.Add( { hEnt }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			end
			
		end
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
				if( v.GetActiveWeapon and v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() ) then
					
					table.insert( tab[v:NPCMastermindColor()], v:GetActiveWeapon() );
					
				end
				
			end
			
		end
		
		for _, v in pairs( ents.FindByClass( "prop_vehicle_apc" ) ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
			end
			
		end
		
		for k, v in pairs( tab ) do
			
			halo.Add( { v }, Color( k.x, k.y, k.z, 255 ), 2, 2, 1, true, true );
			
		end
		
	end
	
	if( GAMEMODE.SeeAll and GAMEMODE.SeeAllSavedProps ) then
		
		local tab = { };
		
		for _, v in pairs( ents.GetAll() ) do
			
			if( v:PropSaved() ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		halo.Add( tab, Color( 255, 0, 255, 255 ), 1, 1, 1, true, false );
		
	end
	
end

function GM:RenderScreenspaceEffects()
	
	self.BaseClass:RenderScreenspaceEffects();
	
	if( self:InIntroCam() ) then return end
	
	if( LocalPlayer():PassedOut() ) then
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= -1;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
	if( self.FlashbangStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashbangStart;
		local a = 0;
		
		if( t < 5 ) then
			
			a = 1;
			
		elseif( t < 7 ) then
			
			a = 1 - ( t - 5 ) / 2;
			
		end
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= a;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		DrawMaterialOverlay( "effects/combine_binocoverlay", 0 )
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= 0;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 0;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
end

function GM:PlayerStartVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerStartVoice( ply );
		
	end
	
end

function GM:PlayerEndVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerEndVoice( ply );
		
	end
	
end

hook.Add("PostRenderVGUI", "STALKER.RenderUpgradeTooltip", function()
	local panel = GAMEMODE.TooltipPanel
	if panel then
		local x,y = gui.MouseX() + 15, gui.MouseY() + 15
		
		if (gui.MouseY() + 15) + (ScrH() / 2.67) > ScrH() then -- panel is out of bounds
			x,y = gui.MouseX() + 15, (gui.MouseY() + 15) - ((( gui.MouseY() + 15 ) + (ScrH() / 2.67)) - ScrH())
		end
		
		hook.Run("PaintUpgradeToolTip", panel, x, y)
	end
end)

hook.Add("PostRenderVGUI", "STALKER.RenderItemTooltip", function()
	local panel = GAMEMODE.ItemTooltipPanel
	if panel then
		local x,y = gui.MouseX() + 15, gui.MouseY() + 15
		
		if (gui.MouseY() + 15) + (ScrH() / 2.67) > ScrH() then -- panel is out of bounds
			x,y = gui.MouseX() + 15, (gui.MouseY() + 15) - ((( gui.MouseY() + 15 ) + (ScrH() / 2.67)) - ScrH())
		end
		
		hook.Run("PaintItemTip", panel, panel.Item)
	end
end)

local tooltip_material = Material("kingston/hint_panels")

function GM:PaintUpgradeToolTip(panel, x, y)
	local upgrade = GAMEMODE.Upgrades[panel.UpgradeID]
	if !upgrade then return end

	surface.DisableClipping(true)
	
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial(tooltip_material)
	surface.DrawTexturedRectUV(x, y, ScrW() / 6, ScrH() / 2.67, 0, 0, 0.2695, 0.395)
	
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial(tooltip_material)
	surface.DrawTexturedRectUV(x + ScrH() / 45, y + ScrH() / 40, ScrW() / 7, ScrH() / 80, 0.271, 0.0065, 0.54, 0.016)
	
	surface.SetTextColor(Color(240, 240, 240, 196))
	surface.SetFont("CombineControl.LabelBig")
	local tW,tH = surface.GetTextSize(upgrade.Name)
	surface.SetTextPos(x + ((ScrW() / 6) / 2) - (tW / 2) - 4, y + ScrH() / 25)
	surface.DrawText(upgrade.Name)
	
	surface.SetTextColor( Color( 220, 220, 220, 172 ) )
	surface.SetFont( "CombineControl.LabelMedium" )
	
	local stats_y = y + ScrH() / 24
	
	surface.SetTextColor(Color(180, 180, 180, 148))
	surface.SetFont("CombineControl.LabelSmall")
	local lines, maxW = wrapText(upgrade.Desc, ScrW() / 11, "CombineControl.LabelMedium")
	for k,v in next, lines do
	
		local tW,tH = surface.GetTextSize(v)
		surface.SetTextPos(x + ScrW() / 50, stats_y + tH)
		surface.DrawText(v)
		stats_y = stats_y + tH

	end
	
	stats_y = stats_y + 24
	
	for k,v in next, upgrade.RequiredItems do
		local proper_name = GAMEMODE:GetItemByID(v[1]).Name
		local str = Format("%dx %s", v[2], proper_name)
		
		if panel.RequiredItems[v[1]] then
			surface.SetTextColor(Color(20,200,20))
		else
			surface.SetTextColor(Color(200,20,20))
		end
	
		local tW,tH = surface.GetTextSize(str)
		surface.SetTextPos(x + ScrW() / 50, stats_y + tH)
		surface.DrawText(str)
		stats_y = stats_y + tH
	end
	
	stats_y = stats_y + 24
	
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial(tooltip_material)
	surface.DrawTexturedRectUV(x + ScrH() / 45, stats_y, ScrW() / 7, ScrH() / 80, 0.271, 0.02, 0.54, 0.03)
	
	hook.Run("PaintUpgradeStats", upgrade, x, stats_y)
	
	surface.DisableClipping(false)
end

local icon_material = Material("kingston/properties_icons")

function GM:FindUpgradeStatIcon(x, y)
	local u0 = ((0.125 * x) - ((0.125 * x) / x))
	local v0 = ((0.125 * y) - ((0.125 * y) / y))
	local u1 = 0.125 * x
	local v1 = 0.125 * y
	
	return u0, v0, u1, v1
end

function GM:PaintUpgradeStats(upgrade, x, y)
	local icon_y = y
	for _,property in next, upgrade.PropertiesTooltip do
		local u0, v0, u1, v1 = hook.Run("FindUpgradeStatIcon", property.IconX or 0, property.IconY or 0)

		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(icon_material)
		surface.DrawTexturedRectUV(x + ScrH() / 45, icon_y + ScrH() / 60, ScrW() / 80, ScrH() / 45, u0, v0, u1, v1)

		surface.SetTextColor(Color(180, 180, 180, 148))
		surface.SetFont("CombineControl.LabelSmall")
		local tW,tH = surface.GetTextSize(upgrade.Name)
		surface.SetTextPos((x + ScrH() / 45) + (ScrW() / 80) + 2, icon_y + ScrH() / 60 + 4)
		surface.DrawText(property.Text)
		
		icon_y = icon_y + ScrH() / 45 + 4
	end
end

function GM:UpdateItemTooltipPanel(item)
	local pnl = GAMEMODE.ItemTooltip
	pnl:Clear()
	
	pnl.ItemName = vgui.Create("DLabel", pnl)
	pnl.ItemName:Dock(TOP)
	pnl.ItemName:SetContentAlignment(5)
	pnl.ItemName:SetFont("CombineControl.LabelMedium")
	pnl.ItemName:SetTextColor(Color(240, 240, 240, 196))
	pnl.ItemName:SetText(item:GetName())
	pnl.ItemName:DockMargin(0,ScreenScaleH(12),0,0)
	
	pnl.ItemWeight = vgui.Create("DLabel", pnl)
	pnl.ItemWeight:Dock(TOP)
	pnl.ItemWeight:SetContentAlignment(4)
	pnl.ItemWeight:SetFont("CombineControl.LabelMedium")
	pnl.ItemWeight:SetTextColor(Color(220, 220, 220, 172))
	pnl.ItemWeight:SetText(item:GetWeight().." kg")
	pnl.ItemWeight:DockMargin(ScreenScaleH(16),ScreenScaleH(2),0,0)
	
	pnl.ItemDesc = vgui.Create("DLabel", pnl)
	pnl.ItemDesc:Dock(TOP)
	pnl.ItemDesc:SetContentAlignment(8)
	pnl.ItemDesc:SetFont("CombineControl.LabelMedium")
	pnl.ItemDesc:SetTextColor(Color(180, 180, 180, 148))
	pnl.ItemDesc:SetWrap(true)
	pnl.ItemDesc:SetText(item:GetDesc())
	pnl.ItemDesc:DockMargin(ScreenScaleH(16),ScreenScaleH(2),ScreenScaleH(12),0)
	
	if item.TooltipCreation then
		item:TooltipCreation(pnl)
	end
	
	self.ItemTooltipUpdated = true
end

function GM:CreateItemTooltipPanel()
	GAMEMODE.ItemTooltip = vgui.Create("EditablePanel")
	GAMEMODE.ItemTooltip:SetSize(ScrW() / 6, ScrH() / 2.67)
	GAMEMODE.ItemTooltip:SetPaintedManually(true)
	function GAMEMODE.ItemTooltip:Paint(w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(tooltip_material)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, 0.2695, 0.395)
	end
end

function GM:PaintItemTip( panel, item )

	if( panel:IsHovered() ) then
	
		if( !panel.NoHover ) then

			if( RealTime() >= panel.HoverStart + 1 ) then
				-- this func might get really big and messy
				local x,y = gui.MouseX() + 15, gui.MouseY() + 15
				
				if (gui.MouseY() + 15) + (ScrH() / 2.67) > ScrH() then -- panel is out of bounds
					y = (gui.MouseY() + 15) - ((( gui.MouseY() + 15 ) + (ScrH() / 2.67)) - ScrH())
				end
				
				if (gui.MouseX() + 15) + (ScrW() / 6) > ScrW() then
					x = (gui.MouseX() + 15) - ((( gui.MouseX() + 15 ) + (ScrW() / 6)) - ScrW())
				end
				
				GAMEMODE.ItemTooltip:PaintAt(x,y)
				
			end
			
		end
		
	end

end
