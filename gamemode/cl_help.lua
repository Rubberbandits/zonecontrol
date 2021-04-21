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

            /y - Yell
            /w - Whisper
            /me - Action
			/lme - Loud action
            /it - World action
			/lit - Loud world action
            /ev - Emotes world actions globally, for GM's and Admins
            /lev - Emotes world actions locally, for GM's and Admins

            /mask - Remove your mask or helmet, if you have a suit that also has a mask or helmet.
			/anorak (gray, white, black, brown, green) - Changes the color of your anorak if you are wearing one.

            /pda all - Send a public message to all PDA users
            /pda username - Send a private message to a specific PDA username

            /roll 1d20 - Roll one, twenty sided die.
            /roll nds - Without changing variable d, replace n for number of dice and s for number of sides.

            // - Global OOC
            [[, .// - Local OOC
            /a - Talk to admins
            /pm [name] [text] - PM another player
            /r - Talk on your radio if you have one

            /eng - Speak English.
            /pol - Speak Polish.
            /chi - Speak Chinese.
            /jap - Speak Japanese.
            /spa - Speak Spanish.
            /fre - Speak French.
            /ger - Speak German.
            /ita - Speak Italian.]] },
		{ "Binds", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open player menu.
		F4 - Open admin menu.
		C - Open context menu.]] },
		{ "Using a PDA",
		[[PDA's are an item you must acquire in order to use the Stalker.net service.
		Register your username if you want to be able to message people privately. If your PDA is annoying you, turn it off.

		/pda all - Send a public message to all PDA users
		/pda username - Send a private message to a specific PDA username. Use the Contacts tab to find active users.

		When viewing the contents of your PDA, you should find the Journal, Contacts, and Messages tab, as well as a clock.

		The Journal allows you to take personal notes. Tap the green "New entry" button to create a new entry.
		Select a title for your entry, then fill out the contents. Handy for writing poems during your roadside picnic.

		The Contacts tab allows you to view all other active PDA users connected to your network.

		The Messages tab will log and date messages you send and receive.

		Extra functions and updates to your PDA system may come overtime! Check back here to learn new functions.]] 
		},
		{ "Tooltrust", [[By default, you don't have tooltrust. You have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
		
		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.
		
		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided. To get this, ask an admin.
		
		Admins can take away phys and proptrust if you abuse the privillege - you can get it back through Discord.]] 
		},
		{ "Flags", 
			[[ZoneControl uses a flag system. Most flags are automatic - you don't need to run a command to access them.
			The trader flag will soon be divided into other flags.

			Character Flags
			T - Technician
			X - Black Market Dealer (Trader)
			G - Gamemaster, per-character
		
			Trader Flags (You must have X flags to have these.)
			A - Ammunition
			B - Firearms
			D - Medical
			S - Suits
			]] 
		},
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
		rpa_wake [player] - Wake up a player.
		rpa_explode [player] - Explode a player.
		rpa_kick [player] (reason) - Kick a player.
		rpa_ban [player] [time] (reason) - Ban a player. A time of 0 is a permaban.
		rpa_unban [SteamID] - Unban a player.
		rpa_changebanlength [SteamID] [duration] - Change a ban's length for a player.
		rpa_goto [player] - Teleport to a player.
		rpa_bring [player] - Teleport a player to you.
		rpa_send [target] [destination] - Teleport targeted player to destination player.
		rpa_namewarn [player] - Give a player a name warning.
		rpa_setname [player] [new name] - Change a player's name.
		rpa_setcharmodel [player] [model] - Change a player's model. You can use citizen IDs ("male_01", for example) instead of the full path.
		rpa_givestockpile [player] - Gives a player the ability to create a stockpile.
		rpa_setrank [player] [rank] - Sets a player's rank. Possible arguments: "user" "eventcoordinator" "admin"
		rpa_togglewatched [player] - Makes it so a player's every action will be logged in all admins' consoles.
		
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
		
		rpa_blowout_enabled [number] - Enable the occurance of blowouts.
		rpa_blowout_auto_schedule [duration] - Whether or not blowouts should occur randomly.
		rpa_blowout_interval [duration] - the minimum time in between blowouts.
		rpa_announcing_duration [duration] - the duration or the pre-blowout period, before the first announcement.
		rpa_triggerblowoutinstant - Instantly trigger a blowout, only about 30 seconds before it actually starts.
		rpa_triggerblowout - Trigger a blowout, which will start at the designated announcing duration after this command has ran.
		rpa_cancelblowout - Cancel ongoing blowout.
		
		rpa_oocdelay [duration] - Minimum time between OOC chat messages.
		
		rpa_hideadmin - Hide your admin badge from the scoreboard.
		rpa_hidden - Hides you from the scoreboard completely.
		
		rpa_panic - Remove all props that could possibly be in motion.
		
		rpa_setdmgmult [number] - Change how much damage all weapons do, via a multiplier.
		
		/ev - Broadcast an IC event.]] } );
		
	end
	
	if LocalPlayer():IsEventCoordinator() then
			table.insert( self.HelpContent, { "Gamemaster", [[
		Note: In CombineControl, there is no rpa_observe - observe mode is just noclip.
		
		If the command needs a player, you can specify "^" to target yourself and "-" to target the player you're looking at.
		
		rpg_goto [player] - Teleport to a player.
		rpg_bring [player] - Teleport a player to you.
		rpg_send [target] [destination] - Teleport targeted player to destination player.
		rpg_seeall - Toggle admin ESP mode.
		rpg_seeallprops - Toggle saved props being visible in admin ESP.
		rpg_setmodelself [model] - Set your own model.
		rpg_togglesaved - Toggle a prop being saved.
		rpg_hidden - Hide yourself from the scoreboard.
		rpg_createitem - Open the item request menu.
		
		/ev - Broadcast an IC event.]] } );
	end
	
end

function GM:CreateHelpMenu()
	
	self:RefreshHelpMenuContent();
	
	CCP.HelpMenu = vgui.Create( "DFrame" );
	CCP.HelpMenu:SetSize( 800, 600 );
	CCP.HelpMenu:Center();
	CCP.HelpMenu:SetTitle( "Help" );
	CCP.HelpMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.HelpMenu:MakePopup();
	CCP.HelpMenu.PerformLayout = CCFramePerformLayout;
	CCP.HelpMenu:PerformLayout();
	function CCP.HelpMenu:Think()
	
		if( input.IsKeyDown( KEY_F1 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F1 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
		
	end
	
	CCP.HelpMenu.ContentPane = vgui.Create( "DScrollPanel", CCP.HelpMenu );
	CCP.HelpMenu.ContentPane:SetSize( 650, 556 );
	CCP.HelpMenu.ContentPane:SetPos( 140, 34 );
	function CCP.HelpMenu.ContentPane:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.HelpMenu.Content = vgui.Create( "CCLabel" );
	CCP.HelpMenu.Content:SetPos( 10, 10 );
	CCP.HelpMenu.Content:SetSize( 630, 14 );
	CCP.HelpMenu.Content:SetFont( "CombineControl.LabelMedium" );
	CCP.HelpMenu.Content:SetText( "Welcome to the help menu! Press a button on the left to select a topic." );
	CCP.HelpMenu.Content:PerformLayout();
	CCP.HelpMenu.ContentPane:AddItem( CCP.HelpMenu.Content );
	
	local y = 34;
	
	for _, v in pairs( self.HelpContent ) do
		
		local but = vgui.Create( "DButton", CCP.HelpMenu );
		but:SetPos( 10, y );
		but:SetSize( 120, 20 );
		but:SetText( v[1] );
		but:PerformLayout();
		function but:DoClick()
			
			CCP.HelpMenu.Content:SetText( string.gsub( v[2], "\t", "" ) );
			
			CCP.HelpMenu.Content:InvalidateLayout( true );
			CCP.HelpMenu.ContentPane:PerformLayout();
			
		end
		
		y = y + 30;
		
	end
	
end