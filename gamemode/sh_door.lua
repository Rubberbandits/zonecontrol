local meta = FindMetaTable( "Entity" );
local pmeta = FindMetaTable( "Player" );

GM.DoorAccessors = {
	{ "Type", 			"UInt",		DOOR_UNBUYABLE, 3 },
	{ "OriginalName",	"String",	"" },
	{ "Name",			"String",	"" },
	{ "Price", 			"UInt",		0, 16 },
	{ "Building", 		"String",	"" },
	{ "Owners",			"Table",	{ } },
	{ "AssignedOwners",	"Table",	{ } },
};

for k, v in pairs( GM.DoorAccessors ) do
	
	meta["SetDoor" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		if( self["Door" .. v[1] .. "Val"] == val ) then return end
		
		self["Door" .. v[1] .. "Val"] = val;
		
		netstream.Start( nil, "nSetDoor"..v[1], self, val );
		
	end
	
	meta["Door" .. v[1]] = function( self )
		
		if( self["Door" .. v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self["Door" .. v[1] .. "Val"] or v[3];
		
	end
	
	if( CLIENT ) then
		
		local function nRecvData( door, val )
			
			if( door and door:IsValid() ) then
				
				door["Door" .. v[1] .. "Val"] = val;
				
			end
			
		end
		netstream.Hook( "nSetDoor" .. v[1], nRecvData );
		
	end
	
end

function meta:InitializeDoorAccessors()
	
	for _, v in pairs( GAMEMODE.DoorAccessors ) do
		
		self[v[1] .. "Val"] = v[3];
		
	end
	
end

function meta:SyncDoorData( ply )
	
	for _, n in pairs( GAMEMODE.DoorAccessors ) do
		
		netstream.Start( ply, "nSetDoor"..n[1], self, self["Door" .. n[1]]( self ) );
		
	end
	
end

local function nRequestDoorData( ply, ent )
	
	if( CLIENT ) then return end
	
	ent:SyncDoorData( ply );
	
end
netstream.Hook( "nRequestDoorData", nRequestDoorData );

/*
function GM:NetworkEntityCreated( ent )
	
	if( ent:IsNPC() ) then
		
		netstream.Start( "nRequestNPCData", ent );
		
	end
	
	if( ent:GetClass() == "prop_physics" ) then

		--netstream.Start( "nRequestPropData", ent );
		
	end
	
end
*/

function pmeta:OwnedBuildings()
	
	local tab = { };
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( table.HasValue( v:DoorOwners(), self:CharID() ) and !table.HasValue( tab, v:DoorBuilding() ) ) then
			
			table.insert( tab, v:DoorBuilding() );
			
		end
		
	end
	
	return tab;
	
end

function pmeta:AssignedBuildings()
	
	local tab = { };
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( table.HasValue( v:DoorAssignedOwners(), self:CharID() ) and !table.HasValue( tab, v:DoorBuilding() ) ) then
			
			table.insert( tab, v:DoorBuilding() );
			
		end
		
	end
	
	return tab;
	
end

function pmeta:BuyDoor( ent )
	
	if( CLIENT ) then return end
	
	self:AddMoney( -ent:DoorPrice() );
	self:UpdateCharacterField( "Money", tostring( self:Money() ) );
	
	ent:SetDoorOwners( { self:CharID() } );
	
	if( ent:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( ent:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorOwners( { self:CharID() } );
				
			end
			
		end
		
	end
	
end

function pmeta:SellDoor( ent )
	
	if( CLIENT ) then return end
	
	self:AddMoney( math.floor( ent:DoorPrice() * 0.8 ) );
	self:UpdateCharacterField( "Money", tostring( self:Money() ) );
	
	ent:ResetDoor();
	
end

function meta:ResetDoor()
	
	if( CLIENT ) then return end
	
	self:SetDoorOwners( { } );
	self:SetDoorAssignedOwners( { } );
	self:SetDoorName( self:DoorOriginalName() );
	
	if( self:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( self:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorOwners( { } );
				v:SetDoorAssignedOwners( { } );
				v:SetDoorName( v:DoorOriginalName() );
				
			end
			
		end
		
		for _, v in pairs( ents.FindByClass( "cc_stove" ) ) do
			
			if( v:GetStoveOn() ) then
				
				v:SetStoveOn( false );
				v.SteamEnt:Fire( "TurnOff" );
				
			end
			
		end
		
	end
	
end

function pmeta:AddDoorOwner( ent )
	
	local tab = ent:DoorOwners();
	local ntab = { };
	
	for k, v in pairs( tab ) do
		
		ntab[k] = v;
		
	end
	
	table.insert( ntab, self:CharID() );
	
	ent:SetDoorOwners( ntab );
	
	if( ent:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( ent:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorOwners( ntab );
				
			end
			
		end
		
	end
	
end

function pmeta:RemoveDoorOwner( ent )
	
	local ntab = ent:DoorOwners();
	local tab = { };
	
	for _, v in pairs( ntab ) do
		
		if( v != self:CharID() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	ent:SetDoorOwners( tab );
	
	if( ent:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( ent:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorOwners( tab );
				
			end
			
		end
		
	end
	
end

function pmeta:AddDoorAssignedOwner( ent )
	
	local tab = ent:DoorAssignedOwners();
	local ntab = { };
	
	for k, v in pairs( tab ) do
		
		ntab[k] = v;
		
	end
	
	table.insert( ntab, self:CharID() );
	
	ent:SetDoorAssignedOwners( ntab );
	
	if( ent:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( ent:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorAssignedOwners( ntab );
				
			end
			
		end
		
	end
	
end

function pmeta:RemoveDoorAssignedOwner( ent )
	
	local ntab = ent:DoorAssignedOwners();
	local tab = { };
	
	for _, v in pairs( ntab ) do
		
		if( v != self:CharID() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	ent:SetDoorAssignedOwners( tab );
	
	if( ent:DoorBuilding() != "" ) then
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( ent:DoorBuilding() == v:DoorBuilding() ) then
				
				v:SetDoorAssignedOwners( tab );
				
			end
			
		end
		
	end
	
end

function pmeta:CanLock( ent )
	
	if( self:IsAdmin() ) then return true end
	
	if( table.HasValue( ent:DoorOwners(), self:CharID() ) or table.HasValue( ent:DoorAssignedOwners(), self:CharID() ) ) then return true; end
	
	return false;
	
end

function GM:ExplodeDoor( door, force )
	
	if( CLIENT ) then return end
	
	if( door:GetNoDraw() ) then return end
	
	door:EmitSound( "physics/wood/wood_crate_break" .. math.random( 1, 5 ) .. ".wav" );
	
	door:SetNotSolid( true );
	door:SetNoDraw( true );
	
	local newdoor = ents.Create( "prop_physics" );
	newdoor:SetPos( door:GetPos() );
	newdoor:SetAngles( door:GetAngles() );
	newdoor:SetModel( door:GetModel() );
	newdoor:SetSkin( door:GetSkin() );
	newdoor:Spawn();
	newdoor:GetPhysicsObject():SetVelocity( force * 300 );
	
	timer.Simple( 300, function()
		
		if( door and door:IsValid() ) then
			
			door:Fire( "Unlock" );
			door:SetNotSolid( false );
			door:SetNoDraw( false );
			
		end
		
		if( newdoor and newdoor:IsValid() ) then
			
			newdoor:Remove();
			
		end
		
	end );
	
end