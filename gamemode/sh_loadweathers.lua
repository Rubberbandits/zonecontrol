AddCSLuaFile()

local files = file.Find( GM.FolderName.."/gamemode/weathers/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in next, files do

		if( SERVER ) then
		
			AddCSLuaFile( "weathers/"..v );
		
		end
		
		include( "weathers/"..v );
		
	end

end