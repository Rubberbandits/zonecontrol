local meta = FindMetaTable( "Player" );

GM.GlobalVariables = {
	{ "OOCDelay", 			"Float", 	0 },
	{ "Flashlight",			"Float",	1 },
	{ "BlowoutEnabled",		"Int",		1 },
	{ "BlowoutAutoShedule", "Int",		1 },
	{ "BlowoutInterval",	"Int",		7200 },
	{ "BlowoutAnnounceDuration", "Int", 300 },
};

for k, v in pairs( GM.GlobalVariables ) do
	
	GM["Set" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		_G["SetGlobal" .. v[2]]( v[1], val );
		
	end
	
	GM[v[1]] = function( self )
		
		local v = _G["GetGlobal" .. v[2]]( v[1], v[3] );
		
		if( v == false ) then
			
			return false;
			
		end
		
		return v;
		
	end
	
end

function meta:SyncAllGlobalData()
	
	
	
end

function GM:GetMaps()
	
	local maps = file.Find( "maps/*.bsp", "GAME", "namedesc" );
	
	local tab = { };
	
	for _, v in pairs( maps ) do
		
		local mapname, _ = string.gsub( v, ".bsp", "" );
		
		local files = file.Find( self.FolderName .. "/gamemode/maps/" .. mapname .. ".lua", "LUA", "namedesc" );
		
		if( #files > 0 ) then
			
			table.insert( tab, mapname );
			
		end
		
	end
	
	return tab;
	
end
