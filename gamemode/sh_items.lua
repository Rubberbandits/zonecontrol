GM.Items = { };
GM.g_ItemTable = GM.g_ItemTable or {};
GM.MetaItems = GM.MetaItems or {};
GM.MetaBases = GM.MetaBases or {};
GM.Upgrades = GM.Upgrades or {};
GM.UpgradeBases = GM.UpgradeBases or {};
GM.SuitVariants = GM.SuitVariants or {};

local files = file.Find( GM.FolderName.."/gamemode/items/base/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in next, files do
	
		BASE = {};
		
		if( SERVER ) then
		
			AddCSLuaFile( "items/base/"..v );
		
		end
		
		include( "items/base/"..v );
		
		GM.MetaBases[string.StripExtension( v )] = table.Copy( BASE );
		
	end

end

local files = file.Find( GM.FolderName.."/gamemode/items/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in next, files do
	
		-- this prevents autorefresh from affecting items.
		if( GM.Items[string.StripExtension( v )] ) then return end
	
		local s_BaseItem = {};
		ITEM = {};
		
		ITEM.Name = "Item";
		ITEM.Desc = "Description";
		ITEM.Model = "models/error.mdl";

		if( SERVER ) then
			
			AddCSLuaFile( "items/"..v );
			
		end
		
		include( "items/"..v );
		
		ITEM.Class = string.StripExtension( v )
		
		if( ITEM.Base ) then
			
			/*
				Explanation for use of Inherit:
				Copies any missing data from base to target, and sets the target's BaseClass member to the base table's pointer.
				
				We don't need a reference to base class table because we can retrieve the item base via accessing the value
				ITEM.Base
				Since ITEM tables are associative arrays, we do not need to shift all indices down
				That is why we do not use table.Remove.
			*/
			
			s_BaseItem = table.Copy( GM.MetaBases[ITEM.Base] );
			table.Inherit( ITEM, s_BaseItem );
			ITEM.BaseClass = nil;
			
		end
		
		GM.Items[string.StripExtension( v )] = ITEM;

	end

end

for k,v in next, GM.MetaBases do
	local files = file.Find( GM.FolderName.."/gamemode/items/"..k.."/*.lua", "LUA", "namedesc" );
	for _,n in next, files do
		-- this prevents autorefresh from affecting items.
		if( GM.Items[string.StripExtension( n )] ) then return end
	
		local s_BaseItem = {};
		ITEM = {};
		
		ITEM.Name = "Item";
		ITEM.Desc = "Description";
		ITEM.Model = "models/error.mdl";

		if( SERVER ) then
			
			AddCSLuaFile( "items/"..k.."/"..n );
			
		end
		
		include( "items/"..k.."/"..n );
		
		ITEM.Class = string.StripExtension( n );
		ITEM.Base = ITEM.Base or k;
		
		if ITEM.Base == "weapon" then
			WEAPON_ALL[ITEM.Class] = true
		end
		
		s_BaseItem = table.Copy( GM.MetaBases[k] );
		table.Inherit( ITEM, s_BaseItem );
		ITEM.BaseClass = nil;
		
		GM.Items[string.StripExtension( n )] = ITEM;
	end
end

/* 
	While these aren't technically objects, you can still interact with them like objects.
	They are not objects because we do not need class inherentence, or any separate instances.
	These tables purely hold information to retrieve from when needed.
	
	The specific reason the system is designed this way is to allow any item to be upgraded
	without needing to construct strict tree rules. You can create any kind of upgrade tree
	using the tables RequiredItems, RequiredUpgrades, and Incompatible. Useful for technicians.
	
	Default functions:
		CanUpgrade( item )
		OnUpgrade( item )
		
	Default members:
		Name
		Desc
		IconX
		IconY
		RequiredItems
		Incompatible
		
	Future members:
		RequiredUpgrades
		RequiredFlag

	Keep in mind, these default functions are members of the UPGRADE table itself, and if you do not call
	them as if the UPGRADE table was an object, you will need to pass the upgrade table as the first argument.
	e.g.
	
	UPGRADE.CanUpgrade( UPGRADE, item )
*/

local s_tBaseUpgradeFiles = file.Find( GM.FolderName.."/gamemode/upgrades/base/*.lua", "LUA", "namedesc" );
if( #s_tBaseUpgradeFiles > 0 ) then

	for _, v in next, s_tBaseUpgradeFiles do
	
		if( GM.UpgradeBases[string.StripExtension( v )] ) then return end
	
		UPGRADE = {};
		UPGRADE.ClassName = string.StripExtension( v );
		
		if( SERVER ) then
		
			AddCSLuaFile( "upgrades/base/"..v );
		
		end
		
		include( "upgrades/base/"..v );
		
		GM.UpgradeBases[string.StripExtension( v )] = table.Copy( UPGRADE );
		
	end
	
end

local s_tUpgradeFiles = file.Find( GM.FolderName.."/gamemode/upgrades/*.lua", "LUA", "namedesc" );
if( #s_tUpgradeFiles > 0 ) then

	for _, v in next, s_tUpgradeFiles do
	
		if( GM.Upgrades[string.StripExtension( v )] ) then return end
	
		local s_UpgradeBase = {}
		UPGRADE = {};
		UPGRADE.ClassName = string.StripExtension( v );
		
		if( SERVER ) then
		
			AddCSLuaFile( "upgrades/"..v );
		
		end
		
		include( "upgrades/"..v );
		
		if( UPGRADE.Base ) then
			
			s_UpgradeBase = table.Copy( GM.UpgradeBases[UPGRADE.Base] );
			table.Inherit( UPGRADE, s_UpgradeBase );
			
		end
		
		GM.Upgrades[string.StripExtension( v )] = table.Copy( UPGRADE );
		
	end
	
end

local s_tSuitFiles = file.Find( GM.FolderName.."/gamemode/suit_variants/*.lua", "LUA", "namedesc" );
if( #s_tSuitFiles > 0 ) then

	for _, v in next, s_tSuitFiles do
	
		if( GM.SuitVariants[string.StripExtension( v )] ) then return end
	
		SUIT = {};
		SUIT.ClassName = string.StripExtension( v );
		
		if( SERVER ) then
		
			AddCSLuaFile( "suit_variants/"..v );
		
		end
		
		include( "suit_variants/"..v );
		
		GM.SuitVariants[string.StripExtension( v )] = table.Copy( SUIT );
		
	end
	
end

for k,v in next, GM.SuitVariants do
	local classname = "bdu_"..k
	
	-- this prevents autorefresh from affecting items.
	if( GM.Items[classname] ) then return end

	local s_BaseItem = {};
	local ITEM = {};
	
	ITEM.Name = v.Name
	ITEM.Desc = v.Desc
	ITEM.Model = "models/props_junk/cardboard_box003a.mdl"
	ITEM.Class = classname
	ITEM.Item = v.BaseSuit
	ITEM.SuitVariant = k
	if v.BulkPrice then
		ITEM.BulkPrice = v.BulkPrice
		ITEM.License = LICENSE_BLACK
	end
	ITEM.Weight = 0.5

	/*
		Explanation for use of Inherit:
		Copies any missing data from base to target, and sets the target's BaseClass member to the base table's pointer.
		
		We don't need a reference to base class table because we can retrieve the item base via accessing the value
		ITEM.Base
		Since ITEM tables are associative arrays, we do not need to shift all indices down
		That is why we do not use table.Remove.
	*/
	
	s_BaseItem = table.Copy( GM.MetaBases["bdu_change"] );
	table.Inherit( ITEM, s_BaseItem );
	
	GM.Items[classname] = ITEM;
end

function GM:LoadWeaponItems()

	for _, v in pairs( weapons.GetList() ) do
		
		if( v.Itemize ) then
			
			local s_BaseItem = {};
			ITEM = { };
			ITEM.Name 			= v.PrintName;
			ITEM.Desc	= v.ItemDescription or "";
			ITEM.Model			= v.WorldModel;
			ITEM.Weight			= v.ItemWeight or 1;
			
			ITEM.FOV			= v.ItemFOV;
			ITEM.CamPos			= v.ItemCamPos;
			ITEM.LookAt			= v.ItemLookAt;
			
			ITEM.Bodygroup = v.Bodygroup or 0;
			ITEM.BodygroupCategory = v.BodygroupCategory or 1;

			ITEM.BulkPrice		= v.ItemBulkPrice;
			ITEM.SinglePrice	= v.ItemSinglePrice;
			ITEM.License		= v.ItemLicense;
			
			ITEM.Class = v.ClassName;
			ITEM.WeaponClass = v.ClassName;
			
			s_BaseItem = table.Copy( self.MetaBases["weapon"] );
			table.Inherit( ITEM, s_BaseItem );
			ITEM.BaseClass = nil;
			
			self.Items[v.ClassName] = ITEM;
			
		end
		
	end
	
end

-- helper functions

local meta = FindMetaTable( "Player" );

function InStockpileRange( ply )

	for k,v in next, ents.FindByClass( "cc_stockpile" ) do
	
		if( v:GetPos():Distance( ply:GetPos() ) <= 300 ) then
		
			return true;
			
		end
	
	end

end

function GM:GetItemByID( id )
	
	return table.Copy(self.Items[id]) or false;
	
end

function meta:FindItemByID( nID )
	
	return GAMEMODE.g_ItemTable[nID];

end

function GM:CreateItem( ply, item )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local ent = self:CreateNewItemEntity( item, tr.HitPos + tr.HitNormal * 10, Angle() );
	
	ent:SetPropSteamID( ply:SteamID() );
	
	return ent;
	
end

function GM:CreateArtifact( ply, item )

	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local ent = self:CreatePhysicalArtifact( item, tr.HitPos + tr.HitNormal * 10, Angle() );
	
	ent:SetPropSteamID( ply:SteamID() );
	
	return ent;
	
end

function GM:CreatePhysicalArtifact( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	
	e:SetItemClass( item );
	
	e:SetModel( GAMEMODE:GetItemByID( item ).Model );
	
	e:SetPos( pos );
	e:SetAngles( ang );
	
	e:Spawn();
	e:Activate();
	
	e:SetNoDraw( true );
	
	if( e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() ) then
		
		e:GetPhysicsObject():Wake();
		
	end
		
	if( GAMEMODE:GetItemByID( item ).ItemSubmaterials ) then
	
		for k,v in next, GAMEMODE:GetItemByID( item ).ItemSubmaterials do
		
			e:SetSubMaterial( v[1], v[2] );
			
		end
		
	end
	
	return e;
	
end

function GM:CreatePhysicalItem( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	local metaitem = GAMEMODE:GetItemByID( item );
	if( !metaitem ) then return end
	
	e:SetItemClass( item );
	
	e:SetModel( metaitem.Model );
	e:SetBodygroup( metaitem.BodygroupCategory or 1, metaitem.Bodygroup or 0 );
	
	e:SetPos( pos );
	e:SetAngles( ang );
	
	e:Spawn();
	e:Activate();
	
	if( metaitem.PhysicalMass ) then
	
		e:GetPhysicsObject():SetMass( metaitem.PhysicalMass );
	
	end
	
	if( e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() ) then
		
		e:GetPhysicsObject():Wake();
		
	end
	
	if metaitem.Base == "clothes" then
		local suit = GAMEMODE.SuitVariants[metaitem.Vars["SuitClass"]]
		
		if suit.ItemSubmaterials then
			for k,v in next, suit.ItemSubmaterials do
				e:SetSubMaterial( v[1], v[2] )
			end
		end
	else
		if metaitem.ItemSubmaterials then
			for k,v in next, metaitem.ItemSubmaterials do
				e:SetSubMaterial( v[1], v[2] )
			end
		end
	end
	
	return e;
	
end

local function LoadBook( contents, size, headers, code )
	
	local lines = string.Explode( "\n", string.gsub( contents, "\t", "     " ) );
	
	local title = lines[1];
	table.remove( lines, 1 );
	
	local desc = lines[1];
	table.remove( lines, 1 );
	
	local model = lines[1];
	table.remove( lines, 1 );
	
	local code = lines[1];
	table.remove( lines, 1 );
	
	GAMEMODE.Books[title] = { };
	
	local nextNewChapter = false;
	local curTitle = "";
	local curText = "";
	
	for k, v in pairs( lines ) do
		
		if( k == #lines ) then
			
			curText = curText .. string.gsub( v, "|", "" );
			
			table.insert( GAMEMODE.Books[title], { curTitle, curText } );
			
			break;
			
		end
		
		local p = string.find( v, "|", nil, true );
		
		if( p == 1 ) then
			
			if( string.len( curTitle ) > 0 ) then
				
				table.insert( GAMEMODE.Books[title], { curTitle, curText } );
				
			end
			
			curTitle = string.gsub( v, "|", "" );
			curText = "";
			
		else
			
			curText = curText .. string.gsub( v, "|", "" ) .. "\n";
			
		end
		
	end
	
	ITEM = { };
	ITEM.ID				= code;
	ITEM.Name 			= title;
	ITEM.Description	= desc;
	ITEM.Model			= model;
	ITEM.Weight			= 1;
	
	ITEM.FOV			= 13;
	ITEM.CamPos 		= Vector( 50, 50, 50 );
	ITEM.LookAt 		= Vector( 0, 0, 5.73 );
	ITEM.BookID			= title;
	
	ITEM.ProcessEntity	= function() end;
	ITEM.ProcessEntity	= function() end;
	ITEM.IconMaterial	= nil;
	ITEM.IconColor		= nil;
	
	ITEM.Usable			= true;
	ITEM.Droppable		= true;
	ITEM.Throwable		= true;
	ITEM.UseText		= "Read";
	ITEM.DeleteOnUse	= false;
	
	ITEM.OnPlayerUse = function( self, ply )
		
		if( SERVER ) then return end
		
		if( CCP.Book ) then CCP.Book:Remove() end
		
		CCP.Book = vgui.Create( "DFrame" );
		CCP.Book:SetSize( 800, 600 );
		CCP.Book:Center();
		CCP.Book:SetTitle( GAMEMODE:GetItemByID( self ).BookID );
		CCP.Book.lblTitle:SetFont( "CombineControl.Window" );
		CCP.Book:MakePopup();
		CCP.Book.PerformLayout = CCFramePerformLayout;
		CCP.Book:PerformLayout();
		CCP.Book.ChapterNum = 1;
		CCP.Book.BookID = GAMEMODE:GetItemByID( self ).BookID;
		
		local scroll = vgui.Create( "DScrollPanel", CCP.Book );
		scroll:SetPos( 10, 64 );
		scroll:SetSize( 780, 526 );
		function scroll:Paint( w, h )
			
			surface.SetDrawColor( 30, 30, 30, 150 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 20, 20, 20, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		CCP.Book.Text = vgui.Create( "CCLabel", scroll );
		CCP.Book.Text:SetPos( 0, 0 );
		CCP.Book.Text:SetSize( 780, 526 );
		CCP.Book.Text:SetFont( "CombineControl.LabelSmall" );
		CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][1][2] );
		CCP.Book.Text:PerformLayout();
		
		local function UpdateChapter()
			
			CCP.Book.Chapter:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][1] );
			CCP.Book.Chapter:SizeToContents();
			CCP.Book.Chapter:PerformLayout();
			CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][2] );
			CCP.Book.Text:PerformLayout();
			
		end
		
		local left = vgui.Create( "DButton", CCP.Book );
		left:SetFont( "CombineControl.LabelSmall" );
		left:SetText( "<<" );
		left:SetPos( 720, 34 );
		left:SetSize( 30, 20 );
		left.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum - 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		left:PerformLayout();
		
		local right = vgui.Create( "DButton", CCP.Book );
		right:SetFont( "CombineControl.LabelSmall" );
		right:SetText( ">>" );
		right:SetPos( 760, 34 );
		right:SetSize( 30, 20 );
		right.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum + 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		right:PerformLayout();
		
		CCP.Book.Chapter = vgui.Create( "DLabel", CCP.Book );
		CCP.Book.Chapter:SetText( GAMEMODE.Books[CCP.Book.BookID][1][1] );
		CCP.Book.Chapter:SetPos( 10, 34 );
		CCP.Book.Chapter:SetFont( "CombineControl.LabelBig" );
		CCP.Book.Chapter:SizeToContents();
		CCP.Book.Chapter:PerformLayout();
		
	end
	ITEM.OnPlayerSpawn	= function() end;
	ITEM.OnPlayerPickup	= function() end;
	ITEM.OnPlayerDeath	= function() end;
	ITEM.OnRemoved		= function() end;
	ITEM.Think			= function() end;
	
	table.insert( GAMEMODE.Items, ITEM );
	MsgC( Color( 200, 200, 200, 255 ), "Item " .. code .. " loaded.\n" );
	
end

local function FailedBook( err )
	
	
	
end

function GM:LoadBooks()
	
	self.Books = { };
	
	if( self.BooksURL != "" ) then
		
		http.Fetch( self.BooksURL .. "_index.txt", function( c )
			
			local list = string.Explode( "\n", c );
			
			MsgC( Color( 200, 200, 200, 255 ), "Loading " .. #list .. " books...\n" );
			
			for _, v in pairs( list ) do
				
				http.Fetch( self.BooksURL .. v, LoadBook, FailedBook );
				
			end
			
		end, function( err )
			
			MsgC( Color( 200, 0, 0, 255 ), "Error loading books.\n" );
			
		end );
		
	else
		
		MsgC( Color( 200, 200, 200, 255 ), "No book data specified - skipping...\n" );
		
	end
	
end