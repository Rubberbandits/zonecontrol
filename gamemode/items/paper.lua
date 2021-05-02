ITEM.Name =  "Paper";
ITEM.Desc =  "A blank piece of paper.";
ITEM.Model =  "models/props_c17/paper01.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  17;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( -0.66, -3.87, -2.29 );
ITEM.BulkPrice =  100
ITEM.License =  "X";
ITEM.W = 2
ITEM.H = 2
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Write",
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			local paper = vgui.Create( "DFrame" );
			paper:SetSize( 400, 600 );
			paper:Center();
			paper:SetTitle( "" );
			paper:MakePopup();
			paper.PerformLayout = CCFramePerformLayout;
			paper:PerformLayout();
			paper.Paint = function( panel, w, h )
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.DrawRect( 0, 0, w, h );
				
			end
			
			local entry = vgui.Create( "DTextEntry", paper );
			entry:SetFont( "CombineControl.Written" );
			entry:SetPos( 10, 34 );
			entry:SetSize( 380, 526 );
			entry:SetMultiline( true );
			entry:PerformLayout();
			entry:SetTextColor( Color( 0, 0, 0, 255 ) )
			entry:SetDrawBackground( false );
			
			local warning = vgui.Create( "DLabel", paper );
			warning:SetText( "" );
			warning:SetPos( 10, 572 );
			warning:SetSize( 380, 16 );
			warning:SetFont( "CombineControl.Written" );
			warning:PerformLayout();
			warning:SetWrap( true );
			warning:SetAutoStretchVertical( true );
			
			local done = vgui.Create( "DButton", paper );
			done:SetFont( "CombineControl.LabelSmall" );
			done:SetText( "Done" );
			done:SetPos( 340, 570 );
			done:SetSize( 50, 20 );
			done.DoClick = function( self )
				
				if( string.len( entry:GetValue() ) > 2000 ) then
					
					warning:SetText( "Must be less than 2000 characters." );
					return;
					
				end
				
				netstream.Start( "nWritePaper", entry:GetValue() );
				
				paper:Remove();
				
			end
			done:PerformLayout();
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 20
end
