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

hook.Add("InitPostEntity", "STALKER.OverrideStormFox2", function()
	if StormFox2 then
		StormFox2.Setting.Set("use_2dskybox", true)
	end
end)