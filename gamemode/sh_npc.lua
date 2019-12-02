local meta = FindMetaTable( "Entity" );
local pmeta = FindMetaTable( "Player" );

GM.NPCAccessors = {
	{ "Static", 			"Bool",		false },
	{ "Driver", 			"Entity",	NULL },
	{ "GunOn",				"Bool",		false },
	{ "MastermindColor",	"Vector",	Vector( 255, 255, 255 ) },
	{ "TargetPos",			"Vector",	Vector() },
	{ "HatesUnflaggedCPs",	"Bool",		false },
	{ "HatesFlaggedCPs",	"Bool",		false },
	{ "HatesCitizens",		"Bool",		false },
	{ "HatesRebels",		"Bool",		false },
	{ "HatesWeapons",		"Bool",		false },
};

for k, v in pairs( GM.NPCAccessors ) do
	
	meta["SetNPC" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		if( self["NPC" .. v[1] .. "Val"] == val ) then return end
		
		self["NPC" .. v[1] .. "Val"] = val;
		
		netstream.Start( nil, "nSetNPC"..v[1], self, val );
		
	end
	
	meta["NPC" .. v[1]] = function( self )
		
		if( self["NPC" .. v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self["NPC" .. v[1] .. "Val"] or v[3];
		
	end
	
	if( CLIENT ) then
		
		local function nRecvData( npc, val )
			
			if( npc and npc:IsValid() ) then
				
				npc["NPC" .. v[1] .. "Val"] = val;
				
			end
			
		end
		netstream.Hook( "nSetNPC" .. v[1], nRecvData );
		
	end
	
end

function meta:InitializeNPCAccessors()
	
	for _, v in pairs( GAMEMODE.NPCAccessors ) do
		
		self[v[1] .. "Val"] = v[3];
		
	end
	
end

function meta:SyncNPCData( ply )
	
	for _, n in pairs( GAMEMODE.NPCAccessors ) do
		
		netstream.Start( ply, "nSetNPC"..n[1], self, self["NPC" .. n[1]]( self ) ); 
		
	end
	
end

function nRequestNPCData( ply, ent )
	
	if( CLIENT ) then return end
	
	ent:SyncNPCData( ply );
	
end
netstream.Hook( "nRequestNPCData", nRequestNPCData );

function ents.GetNPCs()
	
	local tab = { };
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:GetClass() == "bullseye_strider_focus" ) then continue; end
		if( v:GetClass() == "npc_bullseye" ) then continue; end
		if( v:GetClass() == "monster_generic" ) then continue; end
		
		if( !v:NPCStatic() ) then
			
			if( v:IsNPC() and v:Health() > 0 ) then
				
				table.insert( tab, v );
				
			end
			
			if( v:GetClass() == "prop_vehicle_apc" ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
	end
	
	return tab;
	
end
