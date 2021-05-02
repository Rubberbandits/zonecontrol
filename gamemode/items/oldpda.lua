ITEM.Name =  "Broken PDA";
ITEM.Desc =  "An abused Multimedia PDA with a cracked screen. If the SIM card inside is in-tact, the thing very well may contain some lucrative information. Someone out there's probably got the tools to crack into it if that's the case.";
ITEM.Model =  "models/kali/miscstuff/stalker/pda.mdl";
ITEM.Weight =  1;
ITEM.FOV =  10;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 200
end