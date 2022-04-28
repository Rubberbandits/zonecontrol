ITEM.Name =  "8gb Flash drive";
ITEM.Desc =  "A convenient way to store and transfer data. 8 gigs of storage, whatever that means.";
ITEM.Model =  "models/kali/miscstuff/stalker/usb_a.mdl";
ITEM.Weight =  0.05
ITEM.FOV =  2;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0.25 );
ITEM.BulkPrice =  2000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 200
function ITEM:GetSellPrice()
	return 400
end