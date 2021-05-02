ITEM.Name =  "64gb Flash drive";
ITEM.Desc =  "A convenient way to store and transfer data. 64 gigs of storage, whatever that means.";
ITEM.Model =  "models/kali/miscstuff/stalker/usb_b.mdl";
ITEM.Weight =  0.1
ITEM.FOV =  2;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0.25 );
ITEM.BulkPrice =  3000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 600
end