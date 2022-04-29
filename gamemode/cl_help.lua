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
			/r - Talk on your radio if you have one
			/me - Action
			/lme - Loud action
			/it - World action
			/lit - Loud world action

			/mask - Remove your mask or helmet, if you have a suit that also has a mask or helmet.
			/anorak (gray, white, black, brown, green) - Changes the color of your anorak if you are wearing one.

			/pda all - Send a public message to all PDA users
			/pda username - Send a private message to a specific PDA username (must be lowercase)

			/roll 1d20 - Roll one, twenty sided die.
			/roll nds - Without changing variable d, replace n for number of dice and s for number of sides.

			// - Global OOC
			[[, .// - Local OOC
			/a - Talk to admins
			/pm [name] [text] - PM another player

			/eng - Speak English.
			/pol - Speak Polish.
			/chi - Speak Chinese.
			/jap - Speak Japanese.
			/spa - Speak Spanish.
			/fre - Speak French.
			/ger - Speak German.
			/ita - Speak Italian.

			Adding variables w and y behind language or radio commands will react accordingly, i.e. /engy to yell in English and /rw to whisper over radio.
			
			/cmdhelp - Prints a list of available commands that only staff may use. To use these commands in the console, simply type rpa_ before the command.
			Typing a keyword related to the command you are searching for will list related commands. For example, typing /char will show you every available /char command.]] },
		{ "Binds", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open inventory menu.
		F4 - Open admin menu.
		C - Open context menu.]] },
		{ "Using a PDA",
		[[PDA's are an item you must acquire in order to use the Stalker.net service.
		Register your username if you want to be able to message people privately by right-clicking your PDA in the F3 inventory menu and selecting "register".
		If your PDA is annoying you, you can turn it off by selecting "turn off".
		Selecting "make primary" on a PDA will make that the PDA you send messages with. 

		/pda all - Send a public message to all PDA users
		/pda username - Send a private message to a specific PDA username. Use the Contacts tab to find active users. (This feature is currently bugged with usernames that have uppercase letters!)

		When viewing the contents of your PDA, you should find the Map, Journal, Contacts, and Messages tab, as well as a clock.

		The Map feature is currently under development, and does nothing for now.

		The Journal allows you to take personal notes. Tap the green "New entry" button to create a new entry.
		Select a title for your entry, then fill out the contents. Handy for writing poems, documenting important information about your enemies, and saving the location of your stash.
		Keep in mind that you cannot edit journals once you have saved them, so changes will have to made as a new entry. Also, you are not given a prompt when selecting "Delete", so make sure you don't lose all your work by pressing it on accident.

		The Contacts tab allows you to view all other active PDA users connected to your network.

		The Messages tab will log and date messages you send and receive.

		Extra functions and updates to your PDA system may come overtime! Check back here to learn about new functions.]] 
		},
		{ "Tooltrust", [[By default, you don't have tooltrust. You have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
		
		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask a staff member.
		
		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided. To get this, ask a staff member.
		
		Staff can take away phys and proptrust if you abuse the privillege - you can get it back through the forums.]] 
		},
		{ "Stockpiles", [[Stockpiles are an extended inventory system outside of your regular F3 inventory menu. Stockpiles are mandatory for Technicians and Traders to conduct business and use their features. Stockpiles are also recommended for factions and PBGs to store extra gear.  Not all players may be granted a Stockpile; you must have a need and a right to have one. 
		
		Regular players cannot spawn the Stockpile entity themselves, they must ask a staff member to spawn one for them. Stockpiles will already be naturally dispersed throughout the map.
		
		You can ask a moderator to give you access to someone else's Stockpile, and vice versa. Stockpile names are global.
			
		Pressing E on a Stockpile lets you see the contents. Right-clicking items in your inventory and selecting "stockpile" will send them to the Stockpile you choose from the menu. You can only send items to your Stockpile if you are standing near it.
		
		Traders use Stockpiles to get money back from items they buy from players by selecting "sell to stockpile for Xru". Furthermore, Traders and Technicians cannot access their business menu if they are not standing near a stockpile. Technicians cannot upgrade gear without standing near a Stockpile.]]
		},
		{ "Flags", 
			[[ZoneControl uses a flag system. Most flags are automatic - you don't need to run a command to access them.

			Character Flags
			T - Technician
			X - Trader
		
			Trader Flags
			A - Ammunition
			B - Firearms
			D - Medical
			H - PDA Encryption/Decryption
			S - Suits
			U - BDUs (Suit Colors) [This system is being reworked and will be removed shortly.]

			Player Flags
			Q - Removes admin powers, per-character]] 
		},
	};
	
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