local meta = FindMetaTable( "Player" );

if( !mysqloo ) then
	
	require( "mysqloo" );
	
end

function GM:RunQueue()

	for k, v in pairs( self.SQLQueue ) do
		
		timer.Simple( 0.01 * ( k - 1 ), function()
			
			mysqloo.Query( v[1], v[2] );
			
		end );
		
	end
	
	self.SQLQueue = { };

end

function GM:InitSQL()
	
	if( !CCSQL ) then
		
		self.SQLQueue = { };
		
	end
	
	CCSQL = mysqloo.connect( self.MySQLHost, self.MySQLUser, self.MySQLPass, self.MySQLDB, self.MySQLPort );
	
	function CCSQL:onConnected()
		
		MsgC( Color( 200, 200, 200, 255 ), "MySQL successfully connected to " .. self:hostInfo() .. ".\nMySQL server version: " .. self:serverInfo() .. "\n" );
		GAMEMODE.NoMySQL = false;
		
		timer.Simple(0.01, function()
			hook.Run("InitSQLTables", self)
		end)
		
		for k, v in pairs( GAMEMODE.SQLQueue ) do
			
			timer.Simple( 0.01 * ( k - 1 ), function()
				
				mysqloo.Query( v[1], v[2] );
				
			end );
			
		end

		GAMEMODE.SQLQueue = { };
		
		mysqloo.Query( "SET interactive_timeout = 28800" );
		mysqloo.Query( "SET wait_timeout = 28800" );
		mysqloo.Query("DELETE FROM cc_logs WHERE CAST(Date AS UNSIGNED) < (UNIX_TIMESTAMP() - 1209600);")
		mysqloo.Query("DELETE FROM cc_pda_journal WHERE DeletionDate < (UNIX_TIMESTAMP() - 259200);")
		
	end

	function CCSQL:onConnectionFailed( err )
		
		GAMEMODE:LogBug( "ERROR: MySQL connection failed (\"" .. err .. "\")." );
		GAMEMODE.NoMySQL = true;
		
		if( string.find( err, "Unknown MySQL server host" ) ) then return end
		
		GAMEMODE:InitSQL();
		
	end

	CCSQL:connect();
end

function mysqloo.Query( q, cb, cbe, noerr )
	
	if( GAMEMODE.NoMySQL ) then
		
		cb( { } );
		return;
		
	end
	
	local qo = CCSQL:query( q );
	
	if( !qo ) then
		
		table.insert( GAMEMODE.SQLQueue, { q, cb } );
		CCSQL:abortAllQueries();
		CCSQL:connect();
		return;
		
	end
	
	function qo:onSuccess( ret )
		
		if( cb ) then
			
			cb( ret, qo );
			
		end
		
	end
	
	function qo:onError( err )
		
		if( CCSQL:status() == mysqloo.DATABASE_NOT_CONNECTED ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( err == "MySQL server has gone away" ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( string.find( err, "Lost connection to MySQL server" ) ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( cbe ) then
			
			cbe( err, qo );
			
		end
		
		if( !noerr ) then
			
			GAMEMODE:LogBug( "ERROR: MySQL query \"" .. q .. "\" failed (\"" .. err .. "\")." );
			
		end
		
	end
	
	qo:start();
	
end

function mysqloo.Escape( s )
	
	if( !s ) then return "" end
	
	return CCSQL:escape( s );
	
end

local CharTable = {
	{ "SteamID", "VARCHAR(30)" },
	{ "RPName", "VARCHAR(100)" },
	{ "Model", "VARCHAR(100)" },
	{ "Body", "VARCHAR(100)" },
	{ "Title", "VARCHAR(8192)", "" },
	{ "TitleOne", "VARCHAR(160)", "" },
	{ "TitleTwo", "VARCHAR(160)", "" },
	{ "Money", "INT", "0" },
	{ "Trait", "INT", TRAIT_NONE },
	{ "Skingroup", "INT", "0" },
	{ "CharFlags", "VARCHAR(10)", "" },
	{ "BusinessLicenses", "FLOAT", "0" },
	{ "Hunger", "FLOAT", "0" },
	{ "Date", "VARCHAR(20)", "" },
	{ "LastOnline", "VARCHAR(20)", "" },
	{ "Location", "FLOAT", "1" },
	{ "EntryPort", "FLOAT", "1" },
	{ "Health", "FLOAT", "100"},
	{ "JustTransitioned", "TINYINT(1)", "0"}
};

local PlayerTable = {
	{ "IPAddress", "VARCHAR(128)" },
	{ "LastName", "VARCHAR(128)", "" },
	{ "ToolTrust", "INT", "0" },
	{ "PhysTrust", "INT", "1" },
	{ "PropTrust", "INT", "1" },
	{ "Rank", "VARCHAR(128)", "user" },
	{ "NewbieStatus", "INT", 1 },
	{ "DonationAmount", "DOUBLE", "0" },
	{ "CustomMaxProps", "INT", "0" },
	{ "CustomMaxRagdolls", "INT", "0" },
	{ "ScoreboardTitle", "VARCHAR(100)", "" },
	{ "ScoreboardTitleC", "VARCHAR(100)", "200 200 200" },
	{ "ScoreboardBadges", "INT", "0" },
	{ "Watched", "INT", "0" },
};

local BansTable = {
	{ "Length", "INT" },
	{ "Reason", "VARCHAR(512)", "" },
	{ "Date", "VARCHAR(20)" }
};

local StockpileTable = {
	{ "Accessors", "TEXT" },
	{ "Name", "TEXT" }
};

local ItemTable = {
	{ "Owner", "INT" },
	{ "Stockpile", "INT", 0 },
	{ "ItemClass", "VARCHAR(256)" },
	{ "PosX", "INT" },
	{ "PosY", "INT" },
	{ "Vars", "TEXT" },
};

function GM:InitSQLTable( tab, dtab )
	
	for _, v in pairs( tab ) do
	
		local function qS()
			
			--self:LogSQL( "Column \"" .. v[1] .. "\" already exists in table " .. dtab .. "." );
			
		end
		
		local function qF( err )
			
			if( string.find( string.lower( err ), "unknown column" ) ) then
				
				self:LogSQL( "Column \"" .. v[1] .. "\" does not exist in table " .. dtab .. ", creating..." );
				
				local q = "ALTER TABLE " .. dtab .. " ADD COLUMN " .. v[1] .. " " .. v[2];
				
				if( v[3] ) then
					
					q = q .. " DEFAULT '" .. tostring( v[3] ) .. "'";
					
				end
				
				mysqloo.Query( q );
				
			end
			
		end
		
		mysqloo.Query( "SELECT " .. v[1] .. " FROM " .. dtab, qS, qF, true );
		
	end
	
end

function GM:InitSQLTables()
	
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_chars ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_players ( SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( SteamID ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_bans ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_stockpiles ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_items ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );" );
	
	self:InitSQLTable( CharTable, "cc_chars" );
	self:InitSQLTable( PlayerTable, "cc_players" );
	self:InitSQLTable( BansTable, "cc_bans" );
	self:InitSQLTable( StockpileTable, "cc_stockpiles" );
	self:InitSQLTable( ItemTable, "cc_items" );
	
end

function CreateNewStockpileEntry( ply, name )

	if( ply:CharID() <= 0 ) then return end
	
	local function NameCheck( ret )
		
		if( #ret == 0 ) then
		
			local function onSuccess(ret, query)
				GAMEMODE.LoadedStockpiles[query:lastInsert()] = {
					["Name"] = mysqloo.Escape( name ),
					["Inventory"] = {},
					["Accessors"] = { math.floor( ply:CharID() ) }
				}
			end
			mysqloo.Query( Format( "INSERT INTO cc_stockpiles ( SteamID, Accessors, Name ) VALUES ( '%s', '%s', '%s' )", ply:SteamID(), util.TableToJSON( { math.floor( ply:CharID() ) } ), mysqloo.Escape( name ) ), onSuccess );
			
		else
		
			netstream.Start( ply, "nStockpileNameTaken" );
		
		end
		
	end
	mysqloo.Query( Format( "SELECT * FROM cc_stockpiles WHERE Name = '%s'", mysqloo.Escape( name ) ), NameCheck );
	
end

function RetrieveStockpiles()

	local function onSuccess( ret )
	
		for k,v in next, ret do
	
			GAMEMODE.LoadedStockpiles[v.id] = { 
				["Name"] = v.Name,
				["Inventory"] = {},
				["Accessors"] = util.JSONToTable( v.Accessors )
			}
			local function onSuccess( ret )
				local inventory = GAMEMODE.LoadedStockpiles[v.id].Inventory
				for m,n in next, ret do
					inventory[n.id] = true
				end
			end
			mysqloo.Query(Format("SELECT id FROM cc_items WHERE Stockpile = %d", v.id), onSuccess)
			
		end
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end

function GM:DumpSQL( t )
	
	if( !t ) then return end
	
	local function qS( ret )
		
		MsgC( Color( 200, 200, 200, 255 ), "Dumping table...\n" );
		
		if( ret ) then
			
			PrintTable( ret );
			
		end
		
		MsgC( Color( 200, 200, 200, 255 ), "Finished dumping table.\n" );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Loading table " .. t .. "...\n" );
	mysqloo.Query( "SELECT * FROM " .. t, qS );
	
end

function GM:PurgeSQL()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "SQL has been purged." );
		
		game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" );
		
	end
	
	local function qF( err )
		
		self:PurgeSQL();
		
	end
	
	mysqloo.Query( "DROP TABLE cc_chars;", qS, qF );
	
end

function GM:LoadBans()
	
	local function qS( ret )
		
		local nBans = #ret;
		
		self:LogSQL( "Banlist successfully retrieved. " .. nBans .. " entries loaded." );
		self.BanTable = ret;
		
		for k, v in pairs( self.BanTable ) do
			
			if( v.Length > 0 and util.TimeSinceDate( v.Date ) > v.Length ) then
				
				table.remove( self.BanTable, k );
				self:RemoveBan( v.SteamID, "time's up" );
				
			end
			
		end
		
	end
	
	local function qF( err )
		
		self:LoadBans();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_bans", qS, qF );
	
end

function GM:AddBan( steam, len, reason, t )
	
	local function qS( ret )
		
		self:LogSQL( "Banned SteamID " .. steam .. " for " .. len .. " minutes (" .. reason .. ")." );
		
	end
	
	local function qF( err )
		
		self:AddBan( steam, len, mysqloo.Escape( reason ), t );
		
	end
	
	mysqloo.Query( "INSERT INTO cc_bans ( SteamID, Length, Reason, Date ) VALUES ( '" .. steam .. "', '" .. len .. "', '" .. mysqloo.Escape( reason ) .. "', '" .. t .. "' )", qS, qF );
	
end

function GM:RemoveBan( steam, r )
	
	local function qS( ret )
		
		self:LogSQL( "Unbanned SteamID " .. steam .. ": " .. r .. "." );
		
	end
	
	local function qF( err )
		
		self:RemoveBan( steam, r );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_bans WHERE SteamID = '" .. steam .. "'", qS, qF );
	
end

function GM:LookupBan( steam )
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	for k, v in pairs( self.BanTable ) do
		
		if( v.SteamID == steam ) then
			
			return k;
			
		end
		
	end
	
end

function meta:SQLSaveNewPlayer()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Created new player record for user " .. self:Nick() .. "." );
		
		local tab = { };
		
		for _, v in pairs( PlayerTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = self:SteamID();
		
		self.SQLPlayerData = tab;
		
		self:LoadPlayer( self.SQLPlayerData );
		
		self:LoadCharsInfo();
		
	end
	
	GAMEMODE:LogSQL( "Creating new player record for user " .. self:Nick() .. "..." );
	mysqloo.Query( "INSERT INTO cc_players ( SteamID, IPAddress, LastName ) VALUES ( '" .. self:SteamID() .. "', '".. self:IPAddress() .."', '".. mysqloo.Escape(self:Nick()) .."' )", qS );
	
end

function meta:PostLoadCharsInfo()
	
	if( self:SQLGetNumChars() > 0 ) then
		
		netstream.Start( self, "nCharacterList", self.SQLCharData );
		
		local nStartType = 0;
		if( GAMEMODE.CurrentLocation != GAMEMODE.MainServerLocation ) then
			nStartType = CC_SELECT;
		else
			if( self:SQLGetNumChars() < GAMEMODE.MaxCharacters ) then
				nStartType = CC_CREATESELECT;
			else
				nStartType = CC_SELECT;
			end
		end
		
		netstream.Start( self, "nOpenCharCreate", nStartType );
		
	else
		
		if( GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != GAMEMODE.MainServerLocation ) then

			netstream.Start( self, "nConnect", IP_GENERAL..PORT_CITY );
			return;
			
		end
		
		netstream.Start( self, "nOpenCharCreate", CC_CREATE );
		
	end
	
end

function meta:PostLoadPlayerInfo()
	
	netstream.Start( self, "nIntroStart", false );
	
	if( !self:SQLHasPlayer() ) then
		
		self:SQLSaveNewPlayer();
		
	else
		
		self:LoadPlayer( self.SQLPlayerData );
		self:LoadCharsInfo();
		
	end
	
	self:UpdateCharacterField( "LastName", self:Nick() );
	
end

function meta:LoadCharsInfo()
	
	local function qS( ret )
		if #ret > 0 then
			self.SQLCharData = ret;
			self:PostLoadCharsInfo();
		else
			self.SQLCharData = { };
			self:PostLoadCharsInfo();
		end
	end
	
	local function qF( err )
	
		self.SQLCharData = { };
		self:PostLoadCharsInfo();
		
	end
	mysqloo.Query( "SELECT * FROM cc_chars WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:LoadPlayerInfo()
	
	local function qS( ret )
		
		self.SQLPlayerData = ret[1];
		self:PostLoadPlayerInfo();
		
	end
	
	local function qF( err )
		
		self.SQLPlayerData = { };
		self:PostLoadPlayerInfo();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_players WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:SQLCharExists( id )
	
	for _, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return true;
			
		end
		
	end
	
	return false;
	
end

function meta:SQLHasPlayer()
	
	return self.SQLPlayerData and table.Count( self.SQLPlayerData ) > 0;
	
end

function meta:SQLGetNumChars()
	
	if( !self.SQLCharData ) then return 0 end
	
	return #self.SQLCharData;
	
end

function meta:GetCharFromID( id )
	
	for _, v in ipairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return v;
			
		end
		
	end
	
end

function meta:GetCharIndexFromID( id )
	
	for k, v in ipairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return k;
			
		end
		
	end
	
end

function meta:SaveNewCharacter( name, title, titleone, titletwo, model, trait, skin, gear )
	
	if GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != GAMEMODE.MainServerLocation then return end

	local d = os.date( "!%m/%d/%y %H:%M:%S" );
	local ply = self;
	local inventoryTbl = {}
	
	local body_mdl = GAMEMODE.BodyModels[1]
	if string.find( model, "female" ) then 
		body_mdl = string.StripExtension(GAMEMODE.BodyModels[1]).."_f.mdl"
	end

	local rublediff = GAMEMODE.RubleBudget;
	for k,v in next, gear do
	
		for i = 1, v do
	
			inventoryTbl[#inventoryTbl + 1] = k;
			
		end
		rublediff = rublediff - ( v * GAMEMODE.GearSelection[k] );
		
	end
	local add = "";
	add = ", Money";
	
	local str = "INSERT INTO cc_chars ( SteamID, RPName, TitleOne, TitleTwo, Title, Model, Body, Trait, Skingroup, Date" .. add;
	str = str .. " ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );";
	
	local query = CCSQL:prepare( str );
	function query:onSuccess( ret )
	
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " created character " .. name .. "." );
		
		local tab = { };
		
		for _, v in pairs( CharTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = ply:SteamID();
		tab["RPName"] = name;
		tab["Title"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = title } );
		tab["TitleOne"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = titleone } );
		tab["TitleTwo"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = titletwo } );
		tab["Model"] = model;
		tab["Body"] = body_mdl;
		tab["Trait"] = trait;
		tab["Skingroup"] = skin;
		tab["Date"] = d;
		tab["LastOnline"] = d;
		tab["Money"] = rublediff;
		
		tab["id"] = tonumber( self:lastInsert() );
		
		table.insert( ply.SQLCharData, tab );
		
		local transaction = CCSQL:createTransaction()
		for k,v in next, inventoryTbl do
		
			local metaitem = GAMEMODE:GetItemByID(v)
			local str = Format("INSERT INTO cc_items ( Owner, ItemClass, Vars ) VALUES ( '%d', '%s', '%s' );", self:lastInsert(), v, util.TableToJSON(metaitem.Vars or {}));
			local query = CCSQL:query( str );
			transaction:addQuery(query)
		
		end
		
		function transaction:onSuccess( ret )
		
			netstream.Start( ply, "nCharacterList", ply.SQLCharData );
			ply:LoadCharacter( tab );
			
		end
		transaction:start()
		
	end
	function query:onError( err )
	
		MsgC( Color( 255, 0, 0 ), "MySQL query failed: "..err );
		
	end
	
	query:setString( 1, self:SteamID() );
	query:setString( 2, name );
	query:setString( 3, util.TableToJSON( { ["onduty"] = "", ["offduty"] = titleone } ) );
	query:setString( 4, util.TableToJSON( { ["onduty"] = "", ["offduty"] = titletwo } ) );
	query:setString( 5, util.TableToJSON( { ["onduty"] = "", ["offduty"] = title } ) );
	query:setString( 6, model );
	query:setString( 7, body_mdl );
	query:setNumber( 8, trait );
	query:setNumber( 9, skin );
	query:setString( 10, d );
	query:setNumber( 11, rublediff );
	query:start();
	
end

function GM:DeleteCharacter( id, deleter, name )
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. deleter .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:DeleteCharacter( id, name )
	
	for k, v in pairs( self.SQLCharData ) do
		
		if( v.id == id ) then
			
			table.remove( self.SQLCharData, k );
			
		end
		
	end
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:UpdateCharacterField( field, value, nolog )
	
	if( self:IsBot() ) then return end
	if( self:CharID() == -1 ) then return end
	
	if( self.SQLCharData[self:GetCharIndexFromID( self:CharID() )][field] == tostring( value ) ) then return end

	local ply = self;
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = ? WHERE id = '" .. self:CharID() .. "'";
	
	local query = CCSQL:prepare( q );
	function query:onSuccess( ret )
	
		if( !nolog ) then
			
			--GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " (" .. ply:RPName() .. ") updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		ply.SQLCharData[ply:GetCharIndexFromID( ply:CharID() )][field] = tostring( value );
		
	end
	function query:onError( err )
	
		MsgC( Color( 255, 0, 0 ), "MySQL Query failed: "..err );
	
	end
	query:setString( 1, tostring( value ) );
	query:start();
	
end

function GM:UpdateCharacterFieldOffline( id, field, value, nolog )
	
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = ? WHERE id = ?";
	
	local query = CCSQL:prepare( q );
	function query:onSuccess( ret )
	
		if( !nolog ) then
			
			--GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
	end
	function query:onError( err )
	
		MsgC( Color( 255, 0, 0 ), "MySQL Query failed: "..err );
	
	end
	query:setString( 1, tostring( value ) );
	query:setNumber( 2, id );
	query:start();
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v.SQLCharData["id"] == id ) then
			
			v.SQLCharData[field] = value;
			
		end
		
	end
	
end

function GM:AddCharacterFieldOffline( id, field, value, min, max )
	
	local q = "SELECT " .. field .. " FROM cc_chars WHERE id = '" .. id .. "'";
	
	local function qS( ret )
		
		local q = "UPDATE cc_chars";
		q = q .. " SET " .. mysqloo.Escape( field );
		q = q .. " = '" .. mysqloo.Escape( tostring( math.Clamp( tonumber( ret[1][field] ) + tonumber( value ), min or -math.huge, max or math.huge ) ) );
		q = q .. "' WHERE id = '" .. id .. "'";
		
		local function qS( ret )
			
			--GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		mysqloo.Query( q, qS );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function meta:UpdatePlayerField( field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. self:SteamID() .. "'";
	
	local function qS( ret )
		
		--GAMEMODE:LogSQL( "Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
		self.SQLPlayerData[field] = tostring( value );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:UpdatePlayerFieldOffline( steamid, field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. steamid .. "'";
	
	local function qS( ret )
		
		--GAMEMODE:LogSQL( "Player " .. steamid .. " updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:SQLThink()
	
end