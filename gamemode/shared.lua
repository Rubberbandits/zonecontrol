-- 4/28/2020
-- honestly this gamemode has been recoded so massively im hesistant to call it combinecontrol

DeriveGamemode( "sandbox" );

util.IncludeDir("gui", false, true, "client")

GM.Name = "ZoneControl";
GM.Author = "rusty";
GM.Website = "";
GM.Email = "";

function GM:GetGameDescription()
	
	return self.Name;
	
end

math.randomseed( os.time() );

local meta = FindMetaTable( "Player" );
local emeta = FindMetaTable( "Entity" );

function GM:CreateTeams()

	team.SetUp( TEAM_CITIZEN, "Stalkers", Color( 0, 120, 0, 255 ), false );
	team.SetUp( TEAM_COMBINE, "Combine", Color( 33, 106, 196, 255 ), false );
	team.SetUp( TEAM_OFFCOMBINE, "Off-Duty Combine", Color( 0, 120, 0, 255 ), false );
	team.SetUp( TEAM_STALKER, "Also Stalkers", Color( 86, 86, 86, 255 ), false );
	team.SetUp( TEAM_VORTIGAUNT, "Vortigaunts", Color( 65, 204, 118, 255 ), false );
	team.SetUp( TEAM_OVERWATCH, "Overwatch", Color( 200, 200, 200, 255 ), false );
	
end

if( SERVER ) then

	hook.Add( "PrePACConfigApply", "FlagRestrictPAC", function( ply )
	
		if( !ply:HasCharFlag( "P" ) and !ply:IsAdmin() ) then
		
			return false, "You're not an admin or don't have the flag!";
			
		end
	
	end );
	
else

	hook.Add( "PrePACEditorOpen", "FlagRestrictPAC", function( ply )
	
		if( !ply:HasCharFlag( "P" ) and !ply:IsAdmin() ) then
		
			return false, "You're not an admin or don't have the flag!";
			
		end
	
	end );
	
end

hook.Add("pac_CanWearParts", "FlagRestrictPAC", function(ply)
	if !ply:HasCharFlag("P") and !ply:IsAdmin() then
		return false, "You're not an admin or don't have the flag!"
	end
end)

GM.ModelColors = { };

for _, v in pairs( GM.CitizenModels ) do
	GM.ModelColors[v] = Vector( 15, 71, 93 ) / 255;
end

GM.ModelColors["models/player/combine_soldier.mdl"] = Vector( 0, 0.8, 1 );
GM.ModelColors["models/player/combine_super_soldier.mdl"] = Vector( 0.4, 0, 0 );

GM.ModelFuncs = { };
GM.ModelFuncs["models/zombie/classic.mdl"] = function( ply )
	
	ply:SetBodygroup( 1, 1 );
	
end
GM.ModelFuncs["models/zombie/fast.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];
GM.ModelFuncs["models/zombie/poison.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];
GM.ModelFuncs["models/zombie/classic_torso.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];

GM.TranslateNPCModelTable = { };
GM.TranslateNPCModelTable["models/humans/group01/female_01.mdl"] = "models/player/group01/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_02.mdl"] = "models/player/group01/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_03.mdl"] = "models/player/group01/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_04.mdl"] = "models/player/group01/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_06.mdl"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_07.mdl"] = "models/player/group01/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_01.mdl"] = "models/player/group01/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_02.mdl"] = "models/player/group01/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_03.mdl"] = "models/player/group01/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_04.mdl"] = "models/player/group01/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_05.mdl"] = "models/player/group01/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_06.mdl"] = "models/player/group01/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_07.mdl"] = "models/player/group01/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_08.mdl"] = "models/player/group01/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_09.mdl"] = "models/player/group01/male_09.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_01.mdl"] = "models/player/group03/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_02.mdl"] = "models/player/group03/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_03.mdl"] = "models/player/group03/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_04.mdl"] = "models/player/group03/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_06.mdl"] = "models/player/group03/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_07.mdl"] = "models/player/group03/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_01.mdl"] = "models/player/group03/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_02.mdl"] = "models/player/group03/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_03.mdl"] = "models/player/group03/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_04.mdl"] = "models/player/group03/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_05.mdl"] = "models/player/group03/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_06.mdl"] = "models/player/group03/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_07.mdl"] = "models/player/group03/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_08.mdl"] = "models/player/group03/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_09.mdl"] = "models/player/group03/male_09.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_01.mdl"] = "models/player/group03m/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_02.mdl"] = "models/player/group03m/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_03.mdl"] = "models/player/group03m/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_04.mdl"] = "models/player/group03m/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_06.mdl"] = "models/player/group03m/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_07.mdl"] = "models/player/group03m/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_01.mdl"] = "models/player/group03m/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_02.mdl"] = "models/player/group03m/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_03.mdl"] = "models/player/group03m/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_04.mdl"] = "models/player/group03m/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_05.mdl"] = "models/player/group03m/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_06.mdl"] = "models/player/group03m/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_07.mdl"] = "models/player/group03m/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_08.mdl"] = "models/player/group03m/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_09.mdl"] = "models/player/group03m/male_09.mdl";
GM.TranslateNPCModelTable["female_01"] = "models/player/group01/female_01.mdl";
GM.TranslateNPCModelTable["female_02"] = "models/player/group01/female_02.mdl";
GM.TranslateNPCModelTable["female_03"] = "models/player/group01/female_03.mdl";
GM.TranslateNPCModelTable["female_04"] = "models/player/group01/female_04.mdl";
GM.TranslateNPCModelTable["female_05"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["female_06"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["female_07"] = "models/player/group01/female_06.mdl";
GM.TranslateNPCModelTable["male_01"] = "models/player/group01/male_01.mdl";
GM.TranslateNPCModelTable["male_02"] = "models/player/group01/male_02.mdl";
GM.TranslateNPCModelTable["male_03"] = "models/player/group01/male_03.mdl";
GM.TranslateNPCModelTable["male_04"] = "models/player/group01/male_04.mdl";
GM.TranslateNPCModelTable["male_05"] = "models/player/group01/male_05.mdl";
GM.TranslateNPCModelTable["male_06"] = "models/player/group01/male_06.mdl";
GM.TranslateNPCModelTable["male_07"] = "models/player/group01/male_07.mdl";
GM.TranslateNPCModelTable["male_08"] = "models/player/group01/male_08.mdl";
GM.TranslateNPCModelTable["male_09"] = "models/player/group01/male_09.mdl";
GM.TranslateNPCModelTable["breen"] = "models/breen.mdl";
GM.TranslateNPCModelTable["gman"] = "models/gman.mdl";
GM.TranslateNPCModelTable["models/combine_soldier.mdl"] = "models/player/combine_soldier.mdl";
GM.TranslateNPCModelTable["models/combine_super_soldier.mdl"] = "models/player/combine_super_soldier.mdl";

GM.TranslatePlayerModelTable = { };
GM.TranslatePlayerModelTable["models/player/group01/female_01.mdl"] = "models/humans/group01/female_01.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_02.mdl"] = "models/humans/group01/female_02.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_03.mdl"] = "models/humans/group01/female_03.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_04.mdl"] = "models/humans/group01/female_04.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_05.mdl"] = "models/humans/group01/female_06.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_06.mdl"] = "models/humans/group01/female_07.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_01.mdl"] = "models/humans/group01/male_01.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_02.mdl"] = "models/humans/group01/male_02.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_03.mdl"] = "models/humans/group01/male_03.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_04.mdl"] = "models/humans/group01/male_04.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_05.mdl"] = "models/humans/group01/male_05.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_06.mdl"] = "models/humans/group01/male_06.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_07.mdl"] = "models/humans/group01/male_07.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_08.mdl"] = "models/humans/group01/male_08.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_09.mdl"] = "models/humans/group01/male_09.mdl";

function IsValidModel( szModelPath )

	return file.Exists( szModelPath, "GAME" );

end

function meta:SetModelCC( mdl )
	if !mdl then return end
	
	self:SetModel( mdl );
	self:SetSkin( 0 );
	for i = 0,  20 do -- this is retarded, #self:GetMaterials()????
		self:SetBodygroup( i, 0 );
		self:SetSubMaterial( i, "" );
	end
	
	if( GAMEMODE.ModelFuncs[mdl] ) then
		
		GAMEMODE.ModelFuncs[mdl]( self );
		
	end
	
	if( GAMEMODE.ModelColors[mdl] ) then
		
		self:SetPlayerColor( GAMEMODE.ModelColors[mdl] );
		
	end
	
	if( self:GetViewModel( 0 ) and self:GetViewModel( 0 ):IsValid() ) then
		
		self:SetupHands();
		
	end
	
	if( string.find( mdl, "group03m" ) ) then
		
		self:SetArmor( 75 );
		
	elseif( string.find( mdl, "group03" ) ) then
		
		self:SetArmor( 100 );
		
	elseif( string.find( mdl, "police" ) ) then
		
		self:SetArmor( 100 );
		
	elseif( string.find( mdl, "combine_soldier" ) or string.find( mdl, "combine_super_soldier" ) ) then
		
		self:SetArmor( 100 );
		
	else
		
		self:SetArmor( 0 );
		
	end
	
end

GM.ModelHands = {}
for k,v in next, GM.CitizenModels do
	GM.ModelHands[v] = {"models/weapons/c_arms_refugee.mdl", 0, "10000000"}
end
for k,v in next, GM.ModelHands do
	player_manager.AddValidModel(k, k)
	player_manager.AddValidHands(k, v[1], v[2], v[3])
end

function GM:TranslateModelToPlayer( mdl )
	
	for k, v in pairs( player_manager.AllValidModels() ) do
		
		if( string.lower( v ) == string.lower( mdl ) ) then
			
			return k;
			
		end
		
	end
	
	return "kleiner";
	
end

function meta:TranslatePlayerModel()
	
	if( string.find( self:GetModel(), "group01" ) ) then return "group01" end
	if( string.find( self:GetModel(), "group03m" ) ) then return "group03m" end
	if( string.find( self:GetModel(), "group03" ) ) then return "group03" end
	
end

function XRES( x )
	
	return x * ( ScrW() / 640 );
	
end

function YRES( y )
	
	return y * ( ScrH() / 480 );
	
end

function meta:Gender()
	
	local mdl = string.lower( self:GetModel() );
	
	if(mdl == "models/cultist/stalker/female_02.mdl" ) then return GENDER_NIGGER end
	
	if( string.find( mdl, "female" ) ) then return GENDER_FEMALE end
	if( mdl == "models/player/alyx.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman_arctic.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/p2_chell.mdl" ) then return GENDER_FEMALE end
	
	if( mdl == "models/player/police_fem.mdl" ) then return GENDER_CP end
	if( mdl == "models/player/police.mdl" ) then return GENDER_CP end
	
	if( mdl == "models/vortigaunt.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_slave.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_doctor.mdl" ) then return GENDER_VORT end
	
	return GENDER_MALE;
	
end

function GM:FindPlayer( name, caller, pda )
	
	name = string.lower( name );
	
	if( name == "^" ) then
		
		return caller;
		
	end
	
	if( name == "-" ) then
		
		local tr = caller:GetEyeTrace();
		
		if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
			
			return tr.Entity;
			
		end
		
	end
	
	for k, v in pairs( player.GetAll() ) do
	
		if( pda and v and v:IsValid() and v.Inventory ) then
			for m,n in next, v.Inventory do
				if n:GetClass() == "pda" then
					if string.find( string.lower( n:GetVar("Name","") ), name, nil, true ) and n:GetVar("Power",false) then
						return v
					end
				end
			end
			continue;
		end
		
		if( string.find( string.lower( v:VisibleRPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:RPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:Nick() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.lower( v:SteamID() ) == name ) then
			return v;
		end
		
	end

end

local allowedChars = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -|+=.,\/;:]];

function GM:CheckCharacterValidity( name, desc, titleone, titletwo, model, trait, skin, gear )
	
	if( string.len( name ) < self.MinNameLength ) then
		return false, "Name must be longer than " .. self.MinNameLength .. " characters.";
	end
	
	if( string.len( name ) > self.MaxNameLength ) then
		return false, "Name must be shorter than " .. self.MaxNameLength .. " characters.";
	end
	
	if( string.len( desc ) > self.MaxDescLength ) then
		return false, "Description must be shorter than " .. self.MaxDescLength .. " characters.";
	end
	
	if( string.len( titleone ) > 128 ) then
		return false, "Title one must be shorter than 128 characters.";
	end
	
	if( string.len( titletwo ) > 128 ) then
		return false, "Title two must be shorter than 128 characters.";
	end
	
	if( !table.HasValue( self.CitizenModels, string.lower( model ) ) ) then
		return false, "Invalid model.";
	end
	
	if( string.find( name, "#", nil, true ) or string.find( name, "~", nil, true ) or string.find( name, "%", nil, true ) ) then
		return false, "Invalid name.";
	end
	
	if( !self.Traits[trait] ) then
		return false, "Invalid trait.";
	end
	
	if( string.find( allowedChars, name, 1, true ) ) then
		return false, "Invalid characters in name.";
	end
	
	if( !skin or !isnumber( skin ) ) then
	
		return false, "No skin selected!";
		
	end
	
	if( skin > 3 ) then
	
		return false, "Invalid skin!";
		
	end
	
	local totalrubles = 0;
	
	for k,v in next, gear do
		
		if( !self.GearSelection[k] ) then
		
			return false, "Invalid item selected!";
			
		end
		
		totalrubles = totalrubles + ( v * self.GearSelection[k] );
		
	end
	
	if( totalrubles > self.RubleBudget ) then
	
		return false, "You've gone over your budget!";
		
	end
	
	return true;
	
end

function GM:FormatLine( str, font, size )
	
	if( string.len( str ) == 1 ) then return str, 0 end
	
	local start = 1;
	local c = 1;
	
	surface.SetFont( font );
	
	local endstr = "";
	local n = 0;
	local lastspace = 0;
	local lastspacemade = 0;
	
	while( string.len( str or "" ) > c ) do
	
		local sub = string.sub( str, start, c );
	
		if( string.sub( str, c, c ) == " " ) then
			lastspace = c;
		end
		
		if( surface.GetTextSize( sub ) >= size and lastspace ~= lastspacemade ) then
			
			local sub2;
			
			if( lastspace == 0 ) then
				lastspace = c;
				lastspacemade = c;
			end
			
			if( lastspace > 1 ) then
				sub2 = string.sub( str, start, lastspace - 1 );
				c = lastspace;
			else
				sub2 = string.sub( str, start, c );
			end
			
			endstr = endstr .. sub2 .. "\n";
			
			lastspace = c + 1;
			lastspacemade = lastspace;
			
			start = c + 1;
			n = n + 1;
		
		end
	
		c = c + 1;
	
	end
	
	if( start < string.len( str or "" ) ) then
	
		endstr = endstr .. string.sub( str or "", start );
	
	end
	
	return endstr, n;

end

function GM:CanSeePos( pos1, pos2, filter )
	
	local trace = { };
	trace.start = pos1;
	trace.endpos = pos2;
	trace.filter = filter;
	trace.mask = MASK_SOLID + CONTENTS_WINDOW + CONTENTS_GRATE;
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction == 1.0 ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:CanSee( ent )
	
	return GAMEMODE:CanSeePos( self:EyePos(), ent:EyePos(), { self, ent } );
	
end

function meta:CanHear( ent )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = ent:EyePos();
	trace.filter = self;
	trace.mask = MASK_SOLID;
	local tr = util.TraceLine( trace );
	
	if( IsValid( tr.Entity ) and tr.Entity:EntIndex() == ent:EntIndex() ) then
		
		return true;
		
	end
	
	return true;
	
end

function emeta:IsDoor()
	
	if( self:GetClass() == "prop_door_rotating" ) then return true; end
	if( self:GetClass() == "func_door_rotating" ) then return true; end
	if( self:GetClass() == "func_door" ) then return true; end
	
	return false;
	
end

function GM:ShouldCollide( e1, e2 )
	
	return true;
	
end

function GM:GetHandTrace( ply, len )
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * ( len or 50 );
	trace.filter = ply;
	
	return util.TraceLine( trace );
	
end

function util.TimeSinceDate( d )
	
	if( !d or d == "" ) then return 0 end
	
	local c = os.date( "!*t" );
	
	local sides = string.Explode( " ", d );
	local d2 = string.Explode( "/", sides[1] );
	local t2 = string.Explode( ":", sides[2] );
	
	local cmonth = tonumber( d2[1] );
	local cday = tonumber( d2[2] );
	local cyear = tonumber( d2[3] );
	local chour = tonumber( t2[1] );
	local cmin = tonumber( t2[2] );
	local csec = tonumber( t2[3] );
	
	c.year = c.year - 2000;
	
	local count = ( c.year - cyear ) * 525600;
	count = count + ( c.month - cmonth ) * 43200;
	count = count + ( c.day - cday ) * 1440;
	count = count + ( c.hour - chour ) * 60;
	count = count + ( c.min - cmin );
	count = count + math.ceil( ( c.sec - csec ) / 60 );
	
	return count;
	
end

GM.Stats = {
	"Speed",
	"Strength",
	"Toughness",
	"Perception",
	"Agility",
	"Aim"
};

function GM:ScaledStatIncrease( ply, lvl )
	
	local rawmul = ( 15 - 1.025 ^ lvl ) / 25;
	
	rawmul = rawmul * ( 1 - math.Clamp( ply:Hunger() / 60, 0, 1 ) );
	
	return ( 15 - 1.025 ^ lvl ) / 25;
	
end

-- SONG_STINGER, SONG_ALERT, SONG_IDLE, SONG_ACTION
GM.Music = {
	{ "100rads/music/chernobyl/the_door.ogg", 163, SONG_ALERT, "The Door" },
	{ "100rads/music/chernobyl/bridge_of_death.ogg", 284, SONG_IDLE, "Bridge of Death" },
	{ "100rads/music/chernobyl/vechnaya_pamyat.ogg", 247, SONG_IDLE, "Вечная Память (Vechnaya Pamyat)" },
	{ "100rads/music/chernobyl/turbine_hall.ogg", 157, SONG_IDLE, "Turbine Hall" },
	{ "100rads/music/chernobyl/pump_room.ogg", 224, SONG_IDLE, "Pump Room" },
	{ "100rads/music/chernobyl/waiting_for_the_engineer.ogg", 92, SONG_STINGER, "Waiting for the Engineer" },
	{ "100rads/music/chernobyl/gallery.ogg", 144, SONG_ALERT, "Gallery" },
	{ "100rads/music/chernobyl/corridors.ogg", 193, SONG_ALERT, "Corridors" },
	{ "100rads/music/chernobyl/clean_up.ogg", 101, SONG_IDLE, "Clean Up" },
	{ "100rads/music/chernobyl/dealing_with_destruction.ogg", 115, SONG_IDLE, "Dealing with Destruction" },
	{ "100rads/music/chernobyl/12_hours_before.ogg", 152, SONG_IDLE, "12 Hours Before" },
	{ "100rads/music/chernobyl/evacuation.ogg", 284, SONG_IDLE, "Evacuation" },
	
	{ "100rads/music/stalker/_menu_misery_angelsanddemons_stereo.ogg", 125, SONG_IDLE, "Angels and Demons" },
	{ "100rads/music/stalker/_menu_misery_atriumcarcerieraser_stereo.ogg", 156, SONG_IDLE, "Eraser" },
	{ "100rads/music/stalker/_menu_misery_bloodinthestreets_stereo.ogg", 132, SONG_ALERT, "Blood in the Streets" },
	{ "100rads/music/stalker/_menu_misery_edwardartemiev_stereo.ogg", 329, SONG_IDLE, "Artemiev" },
	{ "100rads/music/stalker/_menu_misery_emanation_stereo.ogg", 137, SONG_ACTION, "Emanation" },
	{ "100rads/music/stalker/_menu_misery_last_day_6.ogg", 64, SONG_STINGER, "Stinger hit" },
	
	{ "100rads/music/stalker/hospital.ogg", 256, SONG_IDLE, "Hospital" },

	{ "100rads/music/stalker/_menu_misery_last_day_8.ogg", 94, SONG_IDLE, "Ambient 21" },
	{ "100rads/music/stalker/_menu_misery_last_day_7.ogg", 183, SONG_ALERT, "Alert 1" },
	{ "100rads/music/stalker/_menu_misery_last_day_10.ogg", 300, SONG_ALERT, "Alert 2" },
	{ "100rads/music/stalker/_menu_misery_last_day_11.ogg", 136, SONG_ALERT, "Alert 3" },
	{ "100rads/music/stalker/_menu_misery_last_day_13.ogg", 109, SONG_ALERT, "Alert 4" },
	{ "100rads/music/stalker/_menu_misery_last_day_14.ogg", 123, SONG_ALERT, "Alert 5" },
	{ "100rads/music/stalker/_menu_misery_last_day_15.ogg", 100, SONG_ALERT, "Alert 6" },
	{ "100rads/music/stalker/_menu_misery_last_day_4.ogg", 164, SONG_ACTION, "Combat 1" },
	{ "100rads/music/stalker/_menu_misery_last_day_5.ogg", 137, SONG_ACTION, "Combat 2" },
	{ "100rads/music/stalker/_menu_misery_last_day_12.ogg", 89, SONG_ACTION, "Combat 3" },

	{ "100rads/music/stalker/_anomaly_heifehen_defenders_of_the_barrier.ogg", 294, SONG_IDLE, "_anomaly_heifehen_defenders_of_the_barrier"},
	{ "100rads/music/stalker/_anomaly_ilya_ponomarenko_day_one.ogg", 260, SONG_IDLE, "_anomaly_ilya_ponomarenko_day_one"},
	{ "100rads/music/stalker/_menu_misery_hitwithoutwarning_stereo.ogg", 20, SONG_IDLE, "_menu_misery_hitwithoutwarning_stereo"},
	{ "100rads/music/stalker/_menu_misery_last_day_1.ogg", 125, SONG_IDLE, "_menu_misery_last_day_1"},
	{ "100rads/music/stalker/_menu_misery_last_day_2.ogg", 155, SONG_IDLE, "_menu_misery_last_day_2"},
	{ "100rads/music/stalker/_menu_misery_last_day_3.ogg", 132, SONG_IDLE, "_menu_misery_last_day_3"},
	{ "100rads/music/stalker/_menu_misery_last_day_9.ogg", 386, SONG_IDLE, "_menu_misery_last_day_9"},
	{ "100rads/music/stalker/_menu_misery_nin_coronaradiata_stereo.ogg", 139, SONG_IDLE, "_menu_misery_nin_coronaradiata_stereo"},
	{ "100rads/music/stalker/_menu_misery_sciencereligion_stereo.ogg", 202, SONG_IDLE, "_menu_misery_sciencereligion_stereo"},
	{ "100rads/music/stalker/_menu_misery_thriller_stereo.ogg", 94, SONG_STINGER, "_menu_misery_thriller_stereo"},
	{ "100rads/music/stalker/credits.ogg", 387, SONG_IDLE, "credits"},

	{ "100rads/music/stalker/combat/theme1_part_1.ogg", 14, SONG_ACTION, "combat_theme1_part_1"},
	{ "100rads/music/stalker/combat/theme1_part_2.ogg", 14, SONG_ACTION, "combat_theme1_part_2"},
	{ "100rads/music/stalker/combat/theme1_part_3.ogg", 24, SONG_ACTION, "combat_theme1_part_3"},
	{ "100rads/music/stalker/combat/theme2_part_1.ogg", 24, SONG_ACTION, "combat_theme2_part_1"},
	{ "100rads/music/stalker/combat/theme2_part_2.ogg", 14, SONG_ACTION, "combat_theme2_part_2"},
	{ "100rads/music/stalker/combat/theme2_part_3.ogg", 14, SONG_ACTION, "combat_theme2_part_3"},
	{ "100rads/music/stalker/combat/theme3_part_1.ogg", 14, SONG_ACTION, "combat_theme3_part_1"},
	{ "100rads/music/stalker/combat/theme3_part_2.ogg", 24, SONG_ACTION, "combat_theme3_part_2"},
	{ "100rads/music/stalker/combat/theme3_part_3.ogg", 14, SONG_ACTION, "combat_theme3_part_3"},
	{ "100rads/music/stalker/combat/theme4_part_1.ogg", 24, SONG_ACTION, "combat_theme4_part_1"},
	{ "100rads/music/stalker/combat/theme4_part_2.ogg", 14, SONG_ACTION, "combat_theme4_part_2"},
	{ "100rads/music/stalker/combat/theme4_part_3.ogg", 14, SONG_ACTION, "combat_theme4_part_3"},
	{ "100rads/music/stalker/combat/theme5_part_1.ogg", 14, SONG_ACTION, "combat_theme5_part_1"},
	{ "100rads/music/stalker/combat/theme5_part_2.ogg", 14, SONG_ACTION, "combat_theme5_part_2"},
	{ "100rads/music/stalker/combat/theme5_part_3.ogg", 24, SONG_ACTION, "combat_theme5_part_3"},
	{ "100rads/music/stalker/combat/theme6_part_1.ogg", 14, SONG_ACTION, "combat_theme6_part_1"},
	{ "100rads/music/stalker/combat/theme6_part_2.ogg", 14, SONG_ACTION, "combat_theme6_part_2"},
	{ "100rads/music/stalker/combat/theme6_part_3.ogg", 24, SONG_ACTION, "combat_theme6_part_3"},
	{ "100rads/music/stalker/combat/theme7_part_1.ogg", 14, SONG_ACTION, "combat_theme7_part_1"},
	{ "100rads/music/stalker/combat/theme7_part_2.ogg", 14, SONG_ACTION, "combat_theme7_part_2"},
	{ "100rads/music/stalker/combat/theme7_part_3.ogg", 24, SONG_ACTION, "combat_theme7_part_3"},
	{ "100rads/music/stalker/level/_shared/music_01.ogg", 521, SONG_IDLE, "_shared_music_01"},
	{ "100rads/music/stalker/level/_shared/music_02.ogg", 337, SONG_IDLE, "_shared_music_02"},
	{ "100rads/music/stalker/level/_shared/music_03.ogg", 191, SONG_IDLE, "_shared_music_03"},
	{ "100rads/music/stalker/level/_shared/music_04.ogg", 226, SONG_IDLE, "_shared_music_04"},
	{ "100rads/music/stalker/level/_shared/music_05.ogg", 278, SONG_IDLE, "_shared_music_05"},
	{ "100rads/music/stalker/level/_shared/music_06.ogg", 299, SONG_IDLE, "_shared_music_06"},
	{ "100rads/music/stalker/level/day_normal/heifehen_icebreaker.ogg", 367, SONG_IDLE, "day_normal_heifehen_icebreaker"},
	{ "100rads/music/stalker/level/day_normal/heifehen_road_to_the_north.ogg", 361, SONG_IDLE, "day_normal_heifehen_road_to_the_north"},
	{ "100rads/music/stalker/level/day_normal/ilya_ponomarenko_day_one.ogg", 260, SONG_IDLE, "day_normal_ilya_ponomarenko_day_one"},
	{ "100rads/music/stalker/level/day_normal/music_01.ogg", 251, SONG_IDLE, "day_normal_music_01"},
	{ "100rads/music/stalker/level/day_normal/music_02.ogg", 316, SONG_IDLE, "day_normal_music_02"},
	{ "100rads/music/stalker/level/day_normal/music_03.ogg", 352, SONG_IDLE, "day_normal_music_03"},
	{ "100rads/music/stalker/level/day_normal/music_04.ogg", 414, SONG_IDLE, "day_normal_music_04"},
	{ "100rads/music/stalker/level/day_normal/music_05.ogg", 358, SONG_IDLE, "day_normal_music_05"},
	{ "100rads/music/stalker/level/day_normal/music_06.ogg", 286, SONG_IDLE, "day_normal_music_06"},
	{ "100rads/music/stalker/level/day_normal/music_07.ogg", 208, SONG_IDLE, "day_normal_music_07"},
	{ "100rads/music/stalker/level/day_normal/music_08.ogg", 228, SONG_IDLE, "day_normal_music_08"},
	{ "100rads/music/stalker/level/day_normal/music_09.ogg", 339, SONG_IDLE, "day_normal_music_09"},
	{ "100rads/music/stalker/level/day_normal/music_10.ogg", 279, SONG_IDLE, "day_normal_music_10"},
	{ "100rads/music/stalker/level/day_normal/music_11.ogg", 196, SONG_IDLE, "day_normal_music_11"},
	{ "100rads/music/stalker/level/day_normal/music_12.ogg", 198, SONG_IDLE, "day_normal_music_12"},
	{ "100rads/music/stalker/level/day_north/heifehen_common_consciousness.ogg", 452, SONG_IDLE, "day_north_heifehen_common_consciousness"},
	{ "100rads/music/stalker/level/day_north/heifehen_scorched_dreams.ogg", 456, SONG_IDLE, "day_north_heifehen_scorched_dreams"},
	{ "100rads/music/stalker/level/day_north/music_01.ogg", 247, SONG_IDLE, "day_north_music_01"},
	{ "100rads/music/stalker/level/day_north/music_02.ogg", 306, SONG_IDLE, "day_north_music_02"},
	{ "100rads/music/stalker/level/day_north/music_03.ogg", 248, SONG_IDLE, "day_north_music_03"},
	{ "100rads/music/stalker/level/day_north/music_04.ogg", 482, SONG_IDLE, "day_north_music_04"},
	{ "100rads/music/stalker/level/day_north/music_05.ogg", 397, SONG_IDLE, "day_north_music_05"},
	{ "100rads/music/stalker/level/day_north/music_06.ogg", 322, SONG_IDLE, "day_north_music_06"},
	{ "100rads/music/stalker/level/night/heifehen_generators.ogg", 360, SONG_IDLE, "night_heifehen_generators"},
	{ "100rads/music/stalker/level/night/ilya_ponomarenko_disappeared.ogg", 166, SONG_IDLE, "night_ilya_ponomarenko_disappeared"},
	{ "100rads/music/stalker/level/night/ilya_ponomarenko_theme_1.ogg", 235, SONG_IDLE, "night_ilya_ponomarenko_theme_1"},
	{ "100rads/music/stalker/level/night/ilya_ponomarenko_theme_2.ogg", 179, SONG_IDLE, "night_ilya_ponomarenko_theme_2"},
	{ "100rads/music/stalker/level/night/ilya_ponomarenko_theme_4.ogg", 230, SONG_IDLE, "night_ilya_ponomarenko_theme_4"},
	{ "100rads/music/stalker/level/night/music_01.ogg", 207, SONG_IDLE, "night_music_01"},
	{ "100rads/music/stalker/level/night/music_02.ogg", 274, SONG_IDLE, "night_music_02"},
	{ "100rads/music/stalker/level/night/music_03.ogg", 304, SONG_IDLE, "night_music_03"},
	{ "100rads/music/stalker/level/night/music_04.ogg", 575, SONG_IDLE, "night_music_04"},
	{ "100rads/music/stalker/level/night/music_05.ogg", 327, SONG_IDLE, "night_music_05"},
	{ "100rads/music/stalker/level/night/music_06.ogg", 271, SONG_IDLE, "night_music_06"},
	{ "100rads/music/stalker/level/night/music_07.ogg", 277, SONG_IDLE, "night_music_07"},
	{ "100rads/music/stalker/level/night/music_08.ogg", 160, SONG_IDLE, "night_music_08"},
	{ "100rads/music/stalker/level/night/music_09.ogg", 300, SONG_IDLE, "night_music_09"},
	{ "100rads/music/stalker/level/night/music_10.ogg", 207, SONG_IDLE, "night_music_10"},
	{ "100rads/music/stalker/level/night/music_11.ogg", 175, SONG_IDLE, "night_music_11"},
	{ "100rads/music/stalker/level/underground/music_01.ogg", 211, SONG_IDLE, "underground_music_01"},
};

local function processFile(path)
	if !path:find(".ogg") then return end

	local str = "\t{ \""..path.."\", "
	sound.PlayFile("sound/"..path, "noplay", function(chnl, errCode, errStr)
		if IsValid(chnl) then
			local exploded = string.Explode("/", path)
			local isCombat = exploded[#exploded -1] == "combat"
			local trackType = isCombat and "SONG_ACTION" or "SONG_IDLE"

			str = str..math.floor(chnl:GetLength())..", "..trackType..", \""..exploded[#exploded - 1].."_"..string.StripExtension(exploded[#exploded]).."\"},"
		else
			print(errStr)
		end

		print(str)
	end)
end

local function recursiveSearch(path)
	local files,dirs = file.Find("sound/"..path.."*.*", "GAME")

	for _,d in ipairs(dirs) do
		recursiveSearch(path..d.."/")
	end

	for _,f in ipairs(files) do
		processFile(path..f)
	end	
end

function GM:GetSongList( e )
	
	local tab = { };
	
	for _, v in pairs( self.Music ) do
		
		if( v[3] == e ) then
			
			table.insert( tab, v[1] );
			
		end
		
	end
	
	return tab;
	
end

GM.OverwatchLines = {
	{ "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav", "Attention, ground units. Anticitizen reported in this community. Code: lock, cauterize, stabilize." },
	{ "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav", "You are charged with anticivil activity level one. Protection units: prosecution code duty, sword, operate." },
	{ "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav", "Protection team alert: Evidence of anticivil activity in this community. Code: assemble, clamp, contain." },
	{ "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav", "Individual: you are charged with capital malcompliance. Anticitizen status approved." },
	{ "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav", "Individual: you are now charged with socioendangerment level five. Cease evasion immediately; receive your verdict." },
	{ "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav", "Individual: you are convicted of multi anticivil violations. Implicit citizenship revoked. Status: malignant." },
	{ "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav", "Attention please: unidentified person of interest, confirm your civil status with local protection team immediately." },
	{ "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav", "Attention please: evasion behavior consistant with malcompliant defendant. Ground protection team: alert. Code: isolate, expose, administer." },
	{ "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav", "Citizen reminder: inaction is conspiracy. Report counterbehavior to a civil protection team immediately." },
	{ "npc/overwatch/cityvoice/f_localunrest_spkr.wav", "Alert, community ground protection units: local unrest structure detected. Assemble, administer, pacify." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav", "Attention protection team: status evasion in progress in this community. Respond, isolate, inquire." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav", "Attention all ground protection teams: autonomous judgement is now in effect. Sentencing is now discretionary. Code: amputate, zero, confirm." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav", "Attention all ground protection teams: Judgement waiver now in effect. Capital prosecution is discretionary." },
	{ "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav", "Attention occupants: your block is now charged with permissive inactive coersion. Five ration units deducted." },
	{ "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav", "Individual: you are charged with socioendangerment level one. Protection units, prosecution code: duty, sword, midnight." },
	{ "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav", "Citizen notice: priority identification check in progress. Please assemble in your designated inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav", "Attention, please. All citizens in local residential block, assume your inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav", "Attention, residents. Miscount detected in your block. Cooperation with your civil protection team permits full ration reward." },
	{ "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav", "Attention, residents. This block contains potential civil infection. Inform, cooperate, assemble." },
	{ "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav", "Citizen notice: failure to cooperate will result in permanent offworld relocation." },
	{ "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav", "Attention, community: unrest procedure code is now in effect. Inoculate, shield, pacify. Code: pressure, sword, sterilize." },
};

GM.BreenLines = {
	{ "scenes/breencast/collaboration.vcd", 0.08, 90.12 },
	{ "scenes/breencast/instinct.vcd", 0.730297, 213.636368 },
	{ "scenes/breencast/welcome.vcd", 0.628889, 40.253338 },
};

GM.BusinessLicenses = { };
GM.BusinessLicenses[LICENSE_FOOD] = { "Food/Drink", 500 };
GM.BusinessLicenses[LICENSE_ALCOHOL] = { "Alcohol", 700 };
GM.BusinessLicenses[LICENSE_ELECTRONICS] = { "Electronics", 1000 };
GM.BusinessLicenses[LICENSE_MISC] = { "Misc.", 400 };
GM.BusinessLicenses[LICENSE_BLACK] = { "Black Market" };

GM.Traits = { };
GM.Traits[TRAIT_NONE] = { "Russian & Ukrainian", "Your character only knows the local tongue." };
GM.Traits[TRAIT_ENGLISH] = { "English", "Your character can also speak English. Use /eng." };
GM.Traits[TRAIT_CHINESE] = { "Chinese", "Your character can also speak Chinese. Use /chi." };
GM.Traits[TRAIT_JAPANESE] = { "Japanese", "Your character can also speak Japanese. Use /jap." };
GM.Traits[TRAIT_SPANISH] = { "Spanish", "Your character can also speak Spanish. Use /spa." };
GM.Traits[TRAIT_FRENCH] = { "French", "Your character can also speak French. Use /fre." };
GM.Traits[TRAIT_GERMAN] = { "German", "Your character can also speak German. Use /ger." };
GM.Traits[TRAIT_ITALIAN] = { "Italian", "Your character can also speak Italian. Use /ita." };
GM.Traits[TRAIT_POLISH] = { "Polish", "Your character can also speak Polish. Use /pol." };

GM.TraitsList = {
	TRAIT_ENGLISH,
	TRAIT_CHINESE,
	TRAIT_JAPANESE,
	TRAIT_SPANISH,
	TRAIT_FRENCH,
	TRAIT_GERMAN,
	TRAIT_ITALIAN,
	TRAIT_POLISH
};

function meta:HasTrait( trait )
	
	if( bit.band( self:Trait(), trait ) == trait ) then return true; end
	return false;
	
end

function meta:IsEventCoordinator()
	
	return self:GetUserGroup() == "gamemaster" or self:HasCharFlag( "G" );
	
end

function game.GetIP()
	
	local hostip = tonumber( GetConVarString( "hostip" ) );
	
	local ip = { };
	ip[1] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 );
	ip[2] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 );
	ip[3] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 );
	ip[4] = bit.band( hostip, 0x000000FF );

	return table.concat( ip, "." );
	
end

function game.GetPort()
	
	return tonumber( GetConVarString( "hostport" ) );
	
end

if (SERVER and game.IsDedicated()) then
	concommand.Remove("gm_save")
	
	concommand.Add("gm_save", function(client, command, arguments)
		if ((client.nutNextWarn or 0) < CurTime()) then
			local message = client:Nick().." ["..client:SteamID().."] has possibly attempted to crash the server with 'gm_save'"

			for k, v in ipairs(player.GetAll()) do
				if (v:IsAdmin()) then
					v:Notify(nil, COLOR_ERR, "%s [%s] has possibly attempted to crash the server with gm_save", client:Nick(), client:SteamID())
				end
			end

			MsgC(Color(255, 255, 0), message.."\n")
			client.nutNextWarn = CurTime() + 60
		end
	end)
end

function GM:CalculatePrice(item)
	local metaitem = self:GetItemByID(item:GetClass())
	if metaitem then
		if metaitem.GetSellPrice then
			return item:GetSellPrice()
		end

		return (metaitem.BulkPrice / 5) * (GAMEMODE.SellPercentage / 100)
	end
	
	return 0
end

GM.ItemPrice = GM.ItemPrice or {}

function GM:GetBuyPrice(ply, id, single)
	local metaitem = self:GetItemByID(id)
	if metaitem then
		local customPrice = self.ItemPrice[id]
		if customPrice then
			return single and self.ItemPrice[id] or (self.ItemPrice[id] * 5)
		else
			return (single and math.Round((metaitem.BulkPrice / 5 + ((metaitem.BulkPrice / 5) / GAMEMODE.SellPercentage)))) or metaitem.BulkPrice
		end
	end
end

function GM:OnGamemodeLoaded()
	self:LoadWeaponItems();
	if CLIENT then
		self:LoadBooks();
	end

	local base_class = weapons.GetStored("tfa_gun_base")
	if base_class then
		base_class.NotifyJam = function(self)
		
		end
		base_class.CanJam = true
	end
	
	local base_class_melee = weapons.GetStored("tfa_nmrimelee_base")
	if base_class_melee then
		self.nmrih = self.nmrih or {}
		self.nmrih.old_primaryattack = self.nmrih.old_primaryattack or base_class_melee.PrimaryAttack
		
		base_class_melee.PrimaryAttack = function(wep, release, docharge)
			if wep:IsSafety() then return end
			
			self.nmrih.old_primaryattack(wep, release, docharge)
		end
	end
	
	local base_class_nade = weapons.GetStored("tfa_ins2_nade_base")
	if base_class_nade then
		self.ins2 = self.ins2 or {}
		self.ins2.old_shootbullet = self.ins2.old_shootbullet or base_class_nade.ShootBullet

		base_class_nade.DoAmmoCheck = function() end
		
		base_class_nade.ShootBullet = function(wep, damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
			self.ins2.old_shootbullet(wep, damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
			
			if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
			
			local item = wep:GetOwner().Inventory[wep:GetOwner().EquippedWeapons[wep:GetClass()]]
			if item and item.OnThrow then
				item:OnThrow(wep)
			end
		end
	end
	
	local current_index = 3
	for _,weapon in next, weapons.GetList() do
		if self.OverrideSlots[weapon.ClassName] then continue end
		local slot = 2
		local stored_wep = weapons.GetStored(weapon.ClassName)
		if stored_wep.Base == "tfa_nmrimelee_base" then
			slot = 1
		end
		
		self.OverrideSlots[weapon.ClassName] = {slot, current_index}
		current_index = current_index + 1
	end
	
	for k,v in next, self.Items do
		if v.OnGamemodeLoaded then
			v:OnGamemodeLoaded()
		end
	end
	
	net.Receive("ArmDupe", function(len, ply)
		for k, v in next, player.GetAll() do
			if (v:IsAdmin()) then
				v:Notify(nil, COLOR_ERR, "%s (%s) is using the ArmDupe exploit!", ply:Nick(), ply:SteamID())
			end
		end
	end)
end

function player.GetAllLoaded()
	local players = {}
	
	for _,ply in next, player.GetAll() do
		if ply:IsValid() and ply:CharID() > 0 then
			players[#players + 1] = ply
		end
	end
	
	return players
end

function player.GetAdmins()
	local players = {}
	for k,v in next, player.GetAll() do
		if v:IsAdmin() and IsValid(v) then
			players[#players + 1] = v
		end
	end
	
	return players
end