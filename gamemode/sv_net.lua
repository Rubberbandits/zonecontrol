-- there isnt any sv_items file or any other good place to put this so
-- you know we have like 4x populate funcs... we really should just create a single modular populate func.
GM.LoadedStockpiles = {};
local function nUnhideItem( ply, index )
	local ent = Entity(index)
	
	if not IsValid(ent) then return end
	
	local metaitem = GAMEMODE:GetItemByID( ent:GetItemClass() );
	local pPos = ply:GetPos()
	local ePos = ent:GetPos()
	if pPos:Distance(ePos) < 128 then
		ent:SetNoDraw(false)
		if metaitem.ItemSubmaterials then
			for k,v in next, metaitem.ItemSubmaterials do
			
				ent:SetSubMaterial( v[1], v[2] );
				
			end
		end
	else
		ent:SetNoDraw(true)
	end
end
netstream.Hook( "nUnhideItem", nUnhideItem )

local function nRequestStockpiles( ply )
	
	if( !InStockpileRange( ply ) ) then return end

	local tbl = {};

	for k,v in next, GAMEMODE.LoadedStockpiles do

		if( table.HasValue( v.Accessors, math.floor( ply:CharID() ) ) ) then

			tbl[k] = { ["Name"] = v.Name, ["Inventory"] = v.Inventory };
			
		end
	
	end

	netstream.Start( ply, "nPopulateStockpilesMenu", tbl );

end
netstream.Hook( "nRequestStockpiles", nRequestStockpiles );

local function nRequestMoveStockpiles( ply )

	if( !InStockpileRange( ply ) ) then return end

	local tbl = {};

	for k,v in next, GAMEMODE.LoadedStockpiles do

		if( table.HasValue( v.Accessors, math.floor( ply:CharID() ) ) ) then

			tbl[k] = { ["Name"] = v.Name, ["Inventory"] = v.Inventory };
			
		end
	
	end
	
	netstream.Start( ply, "nPopulateMoveToStock", tbl );

end
netstream.Hook( "nRequestMoveStockpiles", nRequestMoveStockpiles );

local function nTakeFromStockpile( ply, index, id )

	local stockpile = GAMEMODE.LoadedStockpiles[id]
	if( !InStockpileRange( ply ) ) then return end
	if !stockpile then return end
	if( !table.HasValue( stockpile.Accessors, math.floor( ply:CharID() ) ) ) then return end

	local has_item = stockpile.Inventory[index]
	if has_item then
		local function onSuccess(ret)
			stockpile.Inventory[index] = nil
			
			local object = item( ply, ret[1].ItemClass, ret[1].id, util.JSONToTable(ret[1].Vars) );
			object:TransmitToOwner();
			object:UpdateSave()

			stockpile.Inventory[ret[1].id] = nil

			GAMEMODE:LogItems("[G] " .. ply:VisibleRPName() .. " removed item " .. object:GetName() .. " from a stockpile.", ply);
		end
		mysqloo.Query(Format("SELECT * FROM cc_items WHERE id = %d", index), onSuccess)
	end
	
end
netstream.Hook( "nTakeFromStockpile", nTakeFromStockpile );

local function nMoveToStockpile( ply, index, id )

	local item = ply.Inventory[index];
	local stockpile = GAMEMODE.LoadedStockpiles[id]
	
	if( !InStockpileRange( ply ) ) then return end
	if( item and stockpile ) then

		if !item:CanDrop() then return end
		if( !table.HasValue( stockpile.Accessors, math.floor( ply:CharID() ) ) ) then return end

		item:StockpileItem(id)
		
	end

end
netstream.Hook( "nMoveToStockpile", nMoveToStockpile );

local function nAdminRequestStockpilesMenu( ply )

	if( !ply:IsAdmin() ) then return end

	netstream.Start( ply, "nAdminPopulateStockpilesMenu", GAMEMODE.LoadedStockpiles );

end
netstream.Hook( "nAdminRequestStockpilesMenu", nAdminRequestStockpilesMenu );

local function nAdminRequestPopulateStockpile(ply, id)
	if( !ply:IsAdmin() ) then return end
	local function onSuccess(ret)
		netstream.Start(ply, "nAdminRequestPopulateStockpile", GAMEMODE.LoadedStockpiles[id].Name, ret, id)
	end
	mysqloo.Query(Format("SELECT id,ItemClass,Vars FROM cc_items WHERE Stockpile = %d", id), onSuccess)
end
netstream.Hook( "nAdminRequestPopulateStockpile", nAdminRequestPopulateStockpile )

local function nAdminPopulateTakeAccessMenu( ply )
	if( !ply:IsAdmin() ) then return end
	local function onSuccess( ret )
	
		local tbl = {};
	
		for k,v in next, ret do
		
			local acc = util.JSONToTable( v.Accessors );

			if( table.HasValue( acc, math.floor( ply:CharID() ) ) ) then

				tbl[tostring( v.id )] = { ["Name"] = v.Name };
				
			end
		
		end

		netstream.Start( ply, "nAdminPopulateTakeAccessMenu", tbl );
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end
netstream.Hook( "nAdminPopulateTakeAccessMenu", nAdminPopulateTakeAccessMenu );

local function nAdminPopulateGiveAccessMenu( ply )
	if( !ply:IsAdmin() ) then return end
	local function onSuccess( ret )
	
		local tbl = {};
	
		for k,v in next, ret do
		
			local acc = util.JSONToTable( v.Accessors );
			if( !table.HasValue( acc, math.floor( ply:CharID() ) ) ) then

				tbl[tostring( v.id )] = { ["Name"] = v.Name };
				
			end
		
		end

		netstream.Start( ply, "nAdminPopulateGiveAccessMenu", tbl );
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end
netstream.Hook( "nAdminPopulateGiveAccessMenu", nAdminPopulateGiveAccessMenu );

local function nAdminRemoveStockpile( ply, id )

	if( !ply:IsAdmin() ) then return end
	local function onSuccess( ret )

		GAMEMODE.LoadedStockpiles[id] = nil
		ply:Notify(Color(0,200,0,255), "Stockpile removed successfully.")
		
		local function onSuccess( ret )
		end
		mysqloo.Query( Format( "DELETE FROM cc_items WHERE Stockpile = '%s'", mysqloo.Escape(tostring(id)) ), onSuccess );
	
	end
	mysqloo.Query( Format( "DELETE FROM cc_stockpiles WHERE id = '%s'", mysqloo.Escape(tostring(id)) ), onSuccess );

end
netstream.Hook( "nAdminRemoveStockpile", nAdminRemoveStockpile );

local function nSetupStockpile( ply, name ) -- could be sql injected... need prepped queries.
	
	if( ply:HasCharFlag( "M" ) and ply.StartStockpileCreation ) then
	
		CreateNewStockpileEntry( ply, name );
		ply.StartStockpileCreation = false;
		
	end

end
netstream.Hook( "nSetupStockpile", nSetupStockpile );

local function nPopulateStockpile(ply, id)
	local stockpile = GAMEMODE.LoadedStockpiles[id]
	if stockpile and table.HasValue(stockpile.Accessors, math.floor(ply:CharID())) then
		local function onSuccess(ret)
			netstream.Start(ply, "nPopulateStockpile", ret, id)
		end
		mysqloo.Query(Format("SELECT id,ItemClass,Vars FROM cc_items WHERE Stockpile = %s", mysqloo.Escape(tostring(id))), onSuccess)
	end
end
netstream.Hook("nPopulateStockpile", nPopulateStockpile)