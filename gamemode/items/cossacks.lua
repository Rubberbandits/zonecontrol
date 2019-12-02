-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Cossacks Vodka";
ITEM.Desc =  "A clear liquor distilled by the Katkov company. 65% alcohol, by volume.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/cossacks vodka.mdl";
ITEM.Weight =  1;
ITEM.FOV =  7;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Swig",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the vodka. It feels right.", { CB_ALL, CB_IC } );
			GAMEMODE:DrugEffectVodka();		
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
