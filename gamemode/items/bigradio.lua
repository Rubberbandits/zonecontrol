
ITEM.Name =  "Radio";
ITEM.Desc =  "A large radio.";
ITEM.Model =  "models/props_lab/citizenradio.mdl";
ITEM.Weight =  10;
ITEM.FOV =  42;
ITEM.W = 4
ITEM.H = 4
ITEM.CamPos =  Vector( 50, 0.66, 11.39 );
ITEM.LookAt =  Vector( 0, 0, 7.63 );
ITEM.BulkPrice =  400;
ITEM.License =  "X";
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Place",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( SERVER ) then
			
			local trace = { };
			trace.start = ply:GetShootPos();
			trace.endpos = trace.start + ply:GetAimVector() * 50;
			trace.filter = ply;
			
			local tr = util.TraceLine( trace );
			
			local e = ents.Create( "cc_radio" );
			e:SetPos( tr.HitPos + tr.HitNormal * 10 );
			e:SetAngles( Angle() );
			e:Spawn();
			e:Activate();
			e:SetDeployer( ply:CharID() );
			
			e:SetPropSteamID( ply:SteamID() );
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
