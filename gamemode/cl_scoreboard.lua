kingston = kingston or {}
kingston.scoreboard = kingston.scoreboard or {}

function GM:ScoreboardHide()
	
	if( CCP.Scoreboard ) then
		
		CCP.Scoreboard:Remove();
		CloseDermaMenus()
		
	end
	
	CCP.Scoreboard = nil;
	
end

function GM:ScoreboardShow()
	
	CCP.Scoreboard = vgui.Create( "DPanel" );
	CCP.Scoreboard:SetSize( 500, 600 );
	CCP.Scoreboard:Center();
	CCP.Scoreboard:MakePopup();
	
	function CCP.Scoreboard:Paint( w, h )
		
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 230 ) );
		draw.RoundedBox( 0, 0, 0, w, 50, Color( 20, 20, 20, 255 ) );
		
		surface.SetFont( "CombineControl.LabelMassive" );
		surface.SetTextColor( 200, 200, 200, 255 );
		surface.SetTextPos( 10, 10 );
		surface.DrawText( GetHostName() );
		
		return true

	end
	
	CCP.Scoreboard.Players = vgui.Create( "DScrollPanel", CCP.Scoreboard );
	CCP.Scoreboard.Players:SetPos( 0, 50 );
	CCP.Scoreboard.Players:SetSize( 500, CCP.Scoreboard:GetTall() - 50 );
	function CCP.Scoreboard.Players:Paint( w, h ) end
	
	local y = 10;
	
	for _, v in pairs( table.GetKeys( team.GetAllTeams() ) ) do
		
		if( team.NumPlayers( v ) > 0 ) then
		
			if( team.GetName( v ) == "Unassigned" ) then continue end;
			if( team.NumPlayers( v ) == 1 and team.GetPlayers( v )[1]:Hidden() ) then continue end;
			
			local name = vgui.Create( "DLabel", CCP.Scoreboard.Players );
			name:SetText( team.GetName( v ) );
			name:SetPos( 10, y );
			name:SetFont( "CombineControl.LabelGiant" );
			name:SizeToContents();
			name:PerformLayout();
			CCP.Scoreboard.Players:AddItem( name );
			
			y = y + 32;
			
			local n = true;
			
			for _, v in pairs( team.GetPlayers( v ) ) do
				
				if( v:CharID() < 0 ) then continue end
				if( v:Hidden() ) then continue end
				
				self:ScoreboardAdd( v, y, n );
				y = y + 48;
				n = !n;
				
			end
			
			y = y + 2;
			
		end
		
	end
	
	CCP.Scoreboard.Players:PerformLayout();
	
end

GM.BronzeMat = Material( "icon16/medal_bronze_1.png" );
GM.SilverMat = Material( "icon16/medal_silver_1.png" );
GM.GoldMat = Material( "icon16/medal_gold_1.png" );
GM.AdminMat = Material( "icon16/shield.png" );
GM.SuperAdminMat = Material( "icon16/star.png" );

GM.ScoreboardBadges = { };
GM.ScoreboardBadges[BADGE_BETATEST] = { Material( "icon16/controller_error.png" ), "Beta Tester" };
GM.ScoreboardBadges[BADGE_BETASCR] = { Material( "icon16/picture_edit.png" ), "Screenshot Contest Winner" };
GM.ScoreboardBadges[BADGE_BIRTHDAY] = { Material( "icon16/cake.png" ), "Disseminate's Birthday" };
GM.ScoreboardBadges[BADGE_WOKE] = { Material( "icon16/pill.png" ), "WOKE" };
GM.ScoreboardBadges[BADGE_DEV] = { Material( "icon16/bug_add.png" ), "Developer" };
GM.ScoreboardBadges[BADGE_DONATOR] = { Material( "icon16/medal_gold_1.png" ), "Donator" }

function GM:ScoreboardAdd( ply, y, n )
	
	local entry = vgui.Create( "DPanel", CCP.Scoreboard.Players );
	entry:SetSize( 500, 48 );
	function entry:Paint( w, h )
		
		if( !ply or !ply:IsValid() ) then
			
			self:Remove();
			return;
			
		end
		
		if( n ) then
			
			draw.RoundedBox( 0, 0, 0, w, h, Color( 20, 20, 20, 130 ) );
			
		end
		
		surface.SetTextColor( 200, 200, 200, 255 );
		surface.SetFont( "CombineControl.LabelSmall" );
		surface.SetTextPos( 58, 10 );
		surface.DrawText( ply:VisibleRPName() );
		
		local x, _ = surface.GetTextSize( ply:Ping() );
		
		surface.SetTextPos( w - 30 - x, 10 );
		surface.DrawText( ply:Ping() );
		
		if( !ply:HideAdmin() ) then
			
			local titlec = ply:ScoreboardTitleC();
			
			surface.SetTextColor( titlec.x, titlec.y, titlec.z, 255 );
			surface.SetFont( "CombineControl.LabelTiny" );
			surface.SetTextPos( 58, 28 );
			surface.DrawText( ply:ScoreboardTitle() );
			
		end
		
		local badgepos = w - 39;
		
		if( ply:IsAdmin() and !ply:HideAdmin() ) then
			
			local mat = GAMEMODE.AdminMat;
			
			if( ply:IsSuperAdmin() ) then
				
				mat = GAMEMODE.SuperAdminMat;
				
			end
			
			surface.SetMaterial( mat );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.DrawTexturedRect( badgepos, 28, 12, 12 );
			
			badgepos = badgepos - 16;
			
		end
		
		if( ply:DonationAmount() > GAMEMODE.BronzeDonorAmount and !ply:HideAdmin() ) then
			
			local mat = GAMEMODE.BronzeMat;
			
			if( ply:DonationAmount() > GAMEMODE.GoldDonorAmount ) then
				
				mat = GAMEMODE.GoldMat;
				
			elseif( ply:DonationAmount() > GAMEMODE.SilverDonorAmount ) then
				
				mat = GAMEMODE.SilverMat;
				
			end
			
			surface.SetMaterial( mat );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.DrawTexturedRect( badgepos, 28, 12, 12 );
			
			badgepos = badgepos - 16;
			
		end
		
		for k, v in pairs( GAMEMODE.ScoreboardBadges ) do
			
			if( ply:HasBadge( k ) ) then
				
				surface.SetMaterial( v[1] );
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.DrawTexturedRect( badgepos, 28, 12, 12 );
				
				badgepos = badgepos - 16;
				
			end
			
		end
		
	end
	
	entry:SetPos( 0, y );
	
	local icon = vgui.Create( "CCharPanel", entry );
	icon:SetPos( 0, 0 );
	icon:SetModel( ply:GetModel() );
	icon:SetSize( 48, 48 );
	
	local a, b = icon.Entity:GetModelBounds();
	
	icon:SetFOV( 20 );
	icon:SetCamPos( Vector( 60, -20, math.max( a.z, b.z ) - 8 ) );
	icon:SetLookAt( Vector( 0, 0, math.max( a.z, b.z ) - 8 ) );
	
	function icon:LayoutEntity() end
	
	local p = icon.Paint;
	
	function icon:Paint( w, h )
		
		local pnl = CCP.Scoreboard.Players;
		local x2, y2 = pnl:LocalToScreen( 0, 0 );
		local w2, h2 = pnl:GetSize();
		render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
		
		p( self, w, h );
		
		render.SetScissorRect( 0, 0, 0, 0, false );
		
	end
	
	function icon.Entity:GetPlayerColor()
		
		if( !ply or !ply:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ply:GetPlayerColor();
		
	end
	
	icon.Entity:SetSkin( ply:GetSkin() );
	for i = 0, 20 do
		icon.Entity:SetBodygroup( i, ply:GetBodygroup( i ) );
		icon.Entity:SetSubMaterial( i, ply:GetSubMaterial( i ) );
	end

	function icon:DoClick()
	
		ply:ShowUserOptions();
		
	end
	
	local charId = ply:CharID()
	local charData = kingston.bonemerge.data[charId]
	if charData then
		local charParts = charData.parts
		if charParts then
			for partType,partData in next, charParts do
				icon:InitializeModel(partData.model, icon.Entity)
			end
		end

		local charItems = charData.items
		if charItems then
			for itemId,itemData in next, charItems do
				if !itemData.vars["Equipped"] then continue end
				local metaitem = GAMEMODE:GetItemByID(itemData.class)
				local mdl_str = metaitem.Bonemerge
				local scale
				
				if metaitem.AllowGender then
					if ply:Gender() == GENDER_FEMALE then
						mdl_str = string.StripExtension(mdl_str).."_f.mdl"
					end
				elseif metaitem.ScaleForGender and ply:Gender() == GENDER_FEMALE then
					scale = metaitem.ScaleForGender
				end
				
				local mdl = icon:InitializeModel(mdl_str, icon.Entity, scale)
				if metaitem.Bodygroups then
					for k,v in next, metaitem.Bodygroups do
						mdl:SetBodygroup(v[1], v[2])
					end
				end
				
				if metaitem.Submaterials then
					for _,submaterial in next, metaitem.Submaterials do
						mdl:SetSubMaterial( submaterial[1], submaterial[2] );
					end
				end
				
				if itemData.vars["SuitClass"] and GAMEMODE.SuitVariants[itemData.vars["SuitClass"]] then
					local suit = GAMEMODE.SuitVariants[itemData.vars["SuitClass"]]
					if suit.Submaterial then
						for _,submaterial in next, suit.Submaterial do
							mdl:SetSubMaterial(submaterial[1], submaterial[2])
						end
					end
				end
				
				if metaitem.HelmetBodygroup then
					if itemData.vars["HelmetEquipped"] then
						mdl:SetBodygroup(metaitem.HelmetBodygroup[1], metaitem.HelmetBodygroup[2])
					else
						if metaitem.Bodygroups then
							for _,bodygroup in next, metaitem.Bodygroups do
								mdl:SetBodygroup(bodygroup[1], bodygroup[2])
							end
						else
							mdl:SetBodygroup(0, 0)
						end
					end
				end
			end
		end
	end
	
	icon:SetTooltip("Click to open menu for "..ply:Name())
	
	local but = vgui.Create( "DButton", entry );
	but:SetText( "" );
	but:SetPos( 48, 0 );
	but:SetSize( 352, 48 );
	function but:DoClick()
		
		GAMEMODE:CCCreatePlayerViewer( ply );
		
	end
	function but:Paint()
		
		
		
	end
	but:PerformLayout();
	
	local but = vgui.Create( "DButton", entry );
	but:SetText( "" );
	but:SetPos( 400, 0 );
	but:SetSize( 100, 48 );
	function but:DoClick()
		
		GAMEMODE:CCCreatePlayerData( ply );
		
	end
	function but:Paint()
		
		
		
	end
	but:PerformLayout();
	
	CCP.Scoreboard.Players:AddItem( entry );
	
end

local function CreateBadge( parent, mat, text, y )
	
	local icon = vgui.Create( "DImage", parent );
	icon:SetMaterial( mat );
	icon:SetPos( 10, y );
	icon:SetSize( 14, 14 );
	
	local badge = vgui.Create( "DLabel", parent );
	badge:SetText( text );
	badge:SetPos( 10 + 18, y );
	badge:SetSize( 170, 14 );
	badge:SetFont( "CombineControl.LabelSmall" );
	badge:PerformLayout();
	
	return y + 20;
	
end

function GM:CCCreatePlayerData( ply )
	
	if( !ply or !ply:IsValid() ) then return end
	
	CCP.PlayerData = vgui.Create( "DFrame" );
	CCP.PlayerData:SetSize( 200, 200 );
	CCP.PlayerData:Center();
	CCP.PlayerData:SetTitle( "Badges" );
	CCP.PlayerData.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerData:MakePopup();
	CCP.PlayerData.PerformLayout = CCFramePerformLayout;
	CCP.PlayerData:PerformLayout();
	
	local y = 34;
	
	if( ply:IsSuperAdmin() and !ply:HideAdmin() ) then
		
		y = CreateBadge( CCP.PlayerData, self.SuperAdminMat, "Owner", y );
		
	elseif( ply:IsAdmin() and !ply:HideAdmin() ) then
		
		y = CreateBadge( CCP.PlayerData, self.AdminMat, "Admin", y );
		
	end
	
	if( !ply:HideAdmin() ) then
		
		if( ply:DonationAmount() > GAMEMODE.GoldDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.GoldMat, "Gold Donor", y );
			
		elseif( ply:DonationAmount() > GAMEMODE.SilverDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.SilverMat, "Silver Donor", y );
			
		elseif( ply:DonationAmount() > GAMEMODE.BronzeDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.BronzeMat, "Bronze Donor", y );
			
		end
		
	end
	
	
	for k, v in pairs( self.ScoreboardBadges ) do
		
		if( ply:HasBadge( k ) ) then
			
			y = CreateBadge( CCP.PlayerData, v[1], v[2], y );
			
		end
		
	end
	
end

-- thanks to whoever wrote those piece of shit DMenus, DMenu:AddPanel is broke as shit.
-- no child panel can have focus when a DMenu is running, so only use it to display information if you really need to have a panel there.


GM.AdminOptions = {
	{
		txt = "Kick",
		icon = "icon16/delete.png",
		func = function(targ)
			RunConsoleCommand("rpa_plykick", targ:RPName())
		end,
	},
	{
		txt = "Bring",
		icon = "icon16/door_in.png",
		func = function(targ)
			RunConsoleCommand("rpa_plybring", targ:RPName())
		end,
	},
	{
		txt = "Goto",
		icon = "icon16/door_out.png",
		func = function(targ)
			RunConsoleCommand("rpa_plygoto", targ:RPName())
		end,
	},
	{
		txt = "Send To",
		icon = "icon16/door_out.png",
		func = function(targ) end,
		sub_menu = {
			gen_func = function(ply, menu)
				local tbl = {}
				
				for _,targ in next, player.GetAllLoaded() do
					tbl[#tbl + 1] = {
						txt = targ:RPName(),
						icon = "icon16/user.png",
						func = function()
							RunConsoleCommand("rpa_plysend", ply:RPName(), targ:RPName())
						end,
					}
				end
				
				return tbl
			end,
		},
	},
	{
		txt = "Give rubles",
		icon = "icon16/money_add.png",
		func = function(targ)
			Derma_StringRequest(
				"Give Rubles", 
				"Enter amount to give to player.",
				"",
				function(text) RunConsoleCommand("rpa_chargivemoney", targ:RPName(), text) end
			)
		end,
	},
	{
		txt = "Tie up",
		icon = "icon16/link.png",
		can_run = function(targ)
			return !targ:TiedUp()
		end,
		func = function(targ) 
			RunConsoleCommand("rpa_plysettied", targ:RPName(), 1)
		end,
	},
	{
		txt = "Untie",
		icon = "icon16/link_break.png",
		can_run = function(targ)
			return targ:TiedUp()
		end,
		func = function(targ) 
			RunConsoleCommand("rpa_plysettied", targ:RPName(), 0)
		end,
	},
}

GM.PlayerOptions = {
	{
		txt = "Show Profile",
		icon = "icon16/user.png",
		func = function(targ)
			targ:ShowProfile()
		end,
	},
}

-- n-n-n-nestiiiiing
local meta = FindMetaTable("Player")
function meta:ShowUserOptions(menu, will_open)
	menu = menu or DermaMenu()
	kingston.scoreboard.player_menu = menu
	menu.TargetPlayer = self
	
	if LocalPlayer():IsAdmin() then
		for _,option in next, GAMEMODE.AdminOptions do
			if option.can_run and !option.can_run(self) then
				continue
			end
		
			local menu_opt = menu:AddOption(option.txt, function() option.func(self) end)
			
			if option.icon then
				menu_opt:SetIcon(option.icon)
			end
			
			if option.sub_menu then
				local sub_menu = menu_opt:AddSubMenu()
				
				if option.sub_menu.gen_func then
					local ret = option.sub_menu.gen_func(self, sub_menu)
					kingston.scoreboard.handle_menu_generation(sub_menu, ret)
					
					continue
				end
				
				if option.sub_menu.panel then
					local pnl = option.sub_menu.panel(self, sub_menu)
					sub_menu:AddPanel(pnl)
				
					continue
				end
				
				for _,sub_opt in next, option.sub_menu do
					if sub_opt.can_run and !sub_opt.can_run(self) then
						continue
					end
					
					local sub_menu_opt = sub_menu:AddOption(sub_opt.txt, function() sub_opt.func(self) end)
					
					if sub_opt.icon then
						sub_menu_opt:SetIcon(sub_opt.icon)
					end
				end
			end	
		end
		
		menu:AddSpacer()
	end
	
	for _,option in next, GAMEMODE.PlayerOptions do
		if option.can_run and !option.can_run(self) then
			continue
		end
	
		local menu_opt = menu:AddOption(option.txt, function() option.func(self) end)
		
		if option.icon then
			menu_opt:SetIcon(option.icon)
		end
	end
	
	if !will_open then
		menu:Open()
	end
end

function kingston.scoreboard.handle_menu_generation(menu, info)
	if !istable(info) then return end
	
	for _,option in next, info do
		if option.can_run and !option.can_run(self) then
			continue
		end
		
		local opt = menu:AddOption(option.txt, function() option.func() end)
		
		if option.icon then
			opt:SetIcon(option.icon)
		end
	end
end