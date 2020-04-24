GM.DummyItems = GM.DummyItems or {};

netstream.Hook( "LoadItems", function( s_ItemTable )

	if !LocalPlayer().Inventory then
		LocalPlayer().Inventory = {}
	end

	for k,v in next, s_ItemTable do
	
		GAMEMODE.g_ItemTable[v.id] = nil;
		local s_Object = item( 
			LocalPlayer(), 
			v.ItemClass, 
			v.id, 
			util.JSONToTable( v.Vars )
		); -- need all before Initialize is called.
	
	end

end );

netstream.Hook( "ReceiveItem", function( s_szClass, s_iID, s_Vars)

	if !LocalPlayer().Inventory then
		LocalPlayer().Inventory = {}
	end

	if( GAMEMODE.g_ItemTable[s_iID] ) then
	
		GAMEMODE.g_ItemTable[s_iID] = nil;
		
	end
	
	local s_Object = item( LocalPlayer(), s_szClass, s_iID, s_Vars );
	GAMEMODE:PMUpdateInventory();

end );

netstream.Hook( "ReceiveDummyItem", function( s_iID, s_szClass, s_Vars, s_Owner, s_CharID )

	GAMEMODE.DummyItems[s_iID] = {
	
		szClass = s_szClass,
		Vars = s_Vars,
		Owner = s_Owner,
		CharID = s_CharID,
		
	};

	hook.Run( "OnReceiveDummyItem", s_iID, GAMEMODE.DummyItems[s_iID] );
	
end );

netstream.Hook("SetItemVar", function(id, key, value)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:SetVar(key, value)
	end
end)

netstream.Hook("RemoveItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:RemoveItem()
	end
end)

netstream.Hook("CallFunction", function(id, key)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:CallFunction(key)
	end
end)

netstream.Hook("DropItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:DropItem()
	end
end)

netstream.Hook("UnloadItem", function(id)
	if !LocalPlayer().Inventory then return end
	local item = LocalPlayer().Inventory[id]
	if item then
		item:OnUnloadItem()
		LocalPlayer().Inventory[id] = nil
		GAMEMODE.g_ItemTable[id] = nil
	end
end)