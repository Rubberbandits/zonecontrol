
ITEM.Name =  "Radio";
ITEM.Desc =  "A handheld communication device. In the Zone, interference is common, and you never know who - or what - listening in.";
ITEM.Model =  "models/kali/miscstuff/stalker/radio.mdl";
ITEM.Weight =  1;
ITEM.FOV 			= 4;
ITEM.CamPos 		= Vector( 0, 0, 90 );
ITEM.LookAt 		= Vector( 1.5, 0, 0 );
ITEM.BulkPrice =  1300;
ITEM.License =  "X";
ITEM.W = 1
ITEM.H = 2
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Channel",
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			CCP.RadioSelector = vgui.Create( "DFrame" );
			CCP.RadioSelector:SetSize( 250, 114 );
			CCP.RadioSelector:Center();
			CCP.RadioSelector:SetTitle( "Change Channel (0-999)" );
			CCP.RadioSelector.lblTitle:SetFont( "CombineControl.Window" );
			CCP.RadioSelector:MakePopup();
			CCP.RadioSelector.PerformLayout = CCFramePerformLayout;
			CCP.RadioSelector:PerformLayout();
			
			CCP.RadioSelector.Entry = vgui.Create( "DTextEntry", CCP.RadioSelector );
			CCP.RadioSelector.Entry:SetFont( "CombineControl.LabelBig" );
			CCP.RadioSelector.Entry:SetPos( 10, 34 );
			CCP.RadioSelector.Entry:SetSize( 100, 30 );
			CCP.RadioSelector.Entry:PerformLayout();
			CCP.RadioSelector.Entry:RequestFocus();
			CCP.RadioSelector.Entry:SetNumeric( true );
			CCP.RadioSelector.Entry:SetValue( math.Round( ply:RadioFreq(), 2 ) );
			CCP.RadioSelector.Entry:SetCaretPos( string.len( CCP.RadioSelector.Entry:GetValue() ) );
			
			CCP.RadioSelector.OK = vgui.Create( "DButton", CCP.RadioSelector );
			CCP.RadioSelector.OK:SetFont( "CombineControl.LabelSmall" );
			CCP.RadioSelector.OK:SetText( "OK" );
			CCP.RadioSelector.OK:SetPos( 190, 74 );
			CCP.RadioSelector.OK:SetSize( 50, 30 );
			function CCP.RadioSelector.OK:DoClick()
				
				local val = tonumber( CCP.RadioSelector.Entry:GetValue() );
				
				if( val >= 0 ) then
					
					if( val <= 999 ) then
						
						CCP.RadioSelector:Remove();
						
						GAMEMODE:AddChat( {[CB_ALL] = true, [CB_IC] = true}, "CombineControl.ChatNormal", Color( 200, 200, 200, 255 ), "Your radio channel is now " .. tostring( math.Round( val , 2 ) ) .. "." );
						
						netstream.Start( "nChangeRadio", val );
						
					else
						
						GAMEMODE:AddChat( {[CB_ALL] = true, [CB_IC] = true}, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "Highest channel is 999." );
						
					end
					
				else

					GAMEMODE:AddChat( {[CB_ALL] = true, [CB_IC] = true}, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "Lowest channel is 0." );
					
				end
				
			end
			CCP.RadioSelector.OK:PerformLayout();
			
			CCP.RadioSelector.Entry.OnEnter = CCP.RadioSelector.OK.DoClick;
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
