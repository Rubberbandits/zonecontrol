function GM:RefreshHelpMenuContent()

	self.HelpContent = {
		{ "Credits",
			[[CombineControl created by Disseminate.
			ZoneControl created by rusty.
			
			Casadis - for all the support and ideas.
			Kamern - ideas and support.
			Cultist - important model work]] 
		},
		{ "Chat",
			[[Just entering something in the chatbox will make you say it in character.
			
			/help - Show this menu

			/y - Yell
			/w - Whisper
			/me - Action
			/it - World action
			// - Global OOC
			[[, .// - Local OOC
			/a - Talk to admins
			/pm [name] [text] - PM another player
			/r - Talk on your radio if you have one
			/help - Open this menu
			
			/rus - Speak Russian.
			/chi - Speak Chinese.
			/jap - Speak Japanese.
			/spa - Speak Spanish.
			/fre - Speak French.
			/ger - Speak German.
			/ita - Speak Italian. ]] },
		{ "Binds", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open player menu.
		F4 - Open admin menu.
		C - Open context menu.]] },
		{ "Story", [[ TBD ]] },
		{ "Tooltrust", [[By default, you don't have tooltrust, you have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
		
		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.
		
		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided. To get this, check the forums.
		
		Admins can take away phys and proptrust if you abuse the privillege - you can get it back on the forums.]] },
	};

	if( LocalPlayer():IsAdmin() ) then
		
		table.insert( self.HelpContent, { "Admin", [[Press F4 to open the admin menu.
		
		If you want to enter commands manually, below is a list of all admin commands in CombineControl.
		
		Note: In CombineControl, there is no rpa_observe - observe mode is just noclip.
		
		If the command needs a player, you can specify "^" to target yourself and "-" to target the player you're looking at.
		
		rpa_restart - Restart the server.
		rpa_kill [player] - Kill a player.
		rpa_slap [player] - Slap a player.
		rpa_ko [player] - Knock out a player.
		rpa_kick [player] (reason) - Kick a player.
		rpa_ban [player] [time] (reason) - Ban a player. A time of 0 is a permaban.
		rpa_unban [SteamID] - Unban a player.
		rpa_changebanlength [SteamID] [duration] - Change a ban's length for a player.
		rpa_goto [player] - Teleport to a player.
		rpa_bring [player] - Teleport a player to you.
		rpa_namewarn [player] - Give a player a name warning.
		rpa_setname [player] [new name] - Change a player's name.
		rpa_setcharmodel [player] [model] - Change a player's model. You can use citizen IDs ("male_01", for example) instead of the full path.
		rpa_seeall - Toggle admin ESP mode.
		
		rpa_editinventory [player] - Open a character's inventory for editing.

		rpa_setcharflag [player] [flag(s)] - Set a player's character flags.
		rpa_flagsroster - See all characters with player flags.
		
		rpa_settooltrust [tt] - Set a player's tooltrust. 0 is none, 1 is basic, 2 is advanced.
		rpa_setphystrust [0/1] - Set a player's phystrust. Default is 1, set to 0 to take away the physgun.
		rpa_setproptrust [0/1] - Set a player's proptrust. Default is 1, set to 0 to take away the ability to spawn props.
		
		rpa_togglesaved - Toggle the prop you're looking at's static property. If static, it will glow pink in SeeAll and will save across restarts.
		
		rpa_playmusic [music/0/1/2] - Play music. 0 is calm, 1 is alert, 2 is action. Alternatively you can specify a song by filename.
		rpa_stopmusic - Stop any playing music.
		
		rpa_createitem [item] - Spawn an item.
		rpa_createartifact [item] - Spawn an artifact. You can still use rpa_createitem for non-hidden artifacts.
		rpa_givemoney [player] [amount] - Give a player rubles.
		
		rpa_createexplosion - Create an explosion where you're looking at.
		rpa_createfire [duration] - Create a fire where you're looking at.
		
		rpa_stopsound - Stop all playing sounds for everyone.
		
		/ev - Broadcast an IC event.]] } );
		
	end
	
end

function GM:CreateHelpMenu()
	
	self:RefreshHelpMenuContent();
	
	CCP.HelpMenu = vgui.Create( "DFrame" );
	CCP.HelpMenu:SetSize( 800, 600 );
	CCP.HelpMenu:Center();
	CCP.HelpMenu:SetSkin( "PDA" );
	CCP.HelpMenu.m_bPDA = true;
	CCP.HelpMenu:SetTitle( "" );
	CCP.HelpMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.HelpMenu:MakePopup();
	function CCP.HelpMenu:Think()
	
		if( input.IsKeyDown( KEY_F1 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F1 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
	
	end
	CCP.HelpMenu.PerformLayout = CCFramePerformLayout;
	CCP.HelpMenu:PerformLayout();
	
	CCP.HelpMenu.CloseButton = vgui.Create( "DButton", CCP.HelpMenu );
	CCP.HelpMenu.CloseButton:SetPos( CCP.HelpMenu:GetWide() - 48, 20 );
	CCP.HelpMenu.CloseButton:SetSize( 34, 34 );
	CCP.HelpMenu.CloseButton:SetText( "" );
	CCP.HelpMenu.CloseButton.m_bCloseButton = true;
	CCP.HelpMenu.CloseButton:SetSkin( "PDA" );
	function CCP.HelpMenu.CloseButton:DoClick()
	
		CCP.HelpMenu:Close();
	
	end
	CCP.HelpMenu.CloseButton:PerformLayout();
	
	CCP.HelpMenu.ContentPane = vgui.Create( "DScrollPanel", CCP.HelpMenu );
	CCP.HelpMenu.ContentPane:SetSize( 762, 490 );
	CCP.HelpMenu.ContentPane:SetPos( 20, 70 );
	CCP.HelpMenu.ContentPane:SetSkin( "PDA" );
	
	CCP.HelpMenu.Content = vgui.Create( "CCLabel" );
	CCP.HelpMenu.Content:SetPos( 10, 20 );
	CCP.HelpMenu.Content:SetSize( 630, 14 );
	CCP.HelpMenu.Content:SetFont( "CombineControl.LabelMedium" );
	CCP.HelpMenu.Content:SetText( "Welcome to the help menu! Press a button on the left to select a topic." );
	CCP.HelpMenu.Content:PerformLayout();
	CCP.HelpMenu.ContentPane:AddItem( CCP.HelpMenu.Content );
	
	local x = 24;
	
	CCP.HelpMenu.Buttons = {};
	
	for _, v in pairs( self.HelpContent ) do
		
		local but = vgui.Create( "DButton", CCP.HelpMenu );
		but:SetSkin( "PDA" );
		but:SetPos( x, 44 );
		but:SetSize( 120, 30 );
		but:SetText( v[1] );
		but:SetFont( "STALKER.LabelMenu" );
		but:PerformLayout();
		function but:DoClick()
			
			for k,v in next, CCP.HelpMenu.Buttons do
			
				v.m_bIsDown = false;
			
			end
			self.m_bIsDown = true;
			
			CCP.HelpMenu.Content:SetText( string.gsub( v[2], "\t", "" ) );
			
			CCP.HelpMenu.Content:InvalidateLayout( true );
			CCP.HelpMenu.ContentPane:PerformLayout();
			
		end
		
		table.insert( CCP.HelpMenu.Buttons, but );
		x = x + 120;
		
	end
	
end