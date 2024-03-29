AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "ItemClass" );
	self:NetworkVar( "String", 1, "VarString" );
	self:NetworkVar( "String", 2, "ItemName" );
	self:NetworkVar( "String", 3, "ItemWeight" );
	
	if( CLIENT ) then return end
	
	self:NetworkVarNotify( "ItemClass", function( self, name, old, new )
		
		local metaitem = GAMEMODE:GetItemByID( new );

		if !self.ItemObj then
			self:SetModel( metaitem.Model );
			self:SetBodygroup( metaitem.BodygroupCategory or 1, metaitem.Bodygroup or 0 );
			self:SetItemName( metaitem.Name );
			self:SetItemWeight( metaitem.Weight );
		else
			self:SetModel( self.ItemObj:GetModel() );
			if self.ItemObj.GetBodygroup then
				self:SetBodygroup( self.ItemObj:GetBodygroupCategory(), self.ItemObj:GetBodygroup() );
			end
			self:SetItemName( self.ItemObj:GetName() );
			self:SetItemWeight( self.ItemObj:GetWeight() );
		end
		
		if metaitem.Base == "clothes" then
			if self.ItemObj then
				local submats = self.ItemObj:GetItemSubmaterials()
				if submats then
						for k,v in next, submats do
						self:SetSubMaterial( v[1], v[2] )
					end
				end
			else
				local suit = GAMEMODE.SuitVariants[metaitem.Vars["SuitClass"]]
				if suit then
					if suit.ItemSubmaterials then
						for k,v in next, suit.ItemSubmaterials do
							self:SetSubMaterial( v[1], v[2] )
						end
					end
				else
					if metaitem.ItemSubmaterials then
						for k,v in next, metaitem.ItemSubmaterials do
							self:SetSubMaterial( v[1], v[2] )
						end
					end
				end
			end
		else
			if metaitem.ItemSubmaterials then
				for k,v in next, metaitem.ItemSubmaterials do
					self:SetSubMaterial( v[1], v[2] )
				end
			end
		end
		
		local phys = self:GetPhysicsObject();
		if( phys and phys:IsValid() ) then
			
			phys:Wake();
			
		end
		
	end );
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:PhysicsInit( SOLID_VPHYSICS );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
	
	self:SetUseType( SIMPLE_USE );
	
	self.KillTime = CurTime() + 21600; -- 6 hours
	
end

function ENT:OnTakeDamage( dmginfo )

	self:TakePhysicsDamage( dmginfo );
	
end

function ENT:SetVar( key, value )

	local s_Vars = util.JSONToTable( self:GetVarString() );
	
	if( s_Vars ) then
	
		s_Vars[key] = value;
		self:SetVarString( util.TableToJSON( s_Vars ) );
		
	end
	
end

function ENT:GetVar( key, fallback )

	local s_Vars = util.JSONToTable( self:GetVarString() );
	
	if( s_Vars[key] ) then
	
		return s_Vars[key];
		
	else
	
		return fallback or false;
		
	end

end

function ENT:GetVars()
	
	return self:GetVarString();
	
end

function ENT:GetItemObject()

	return self.ItemObj;

end

function ENT:Use( ply, caller, type, val )
	
	local metaitem = GAMEMODE:GetItemByID( self:GetItemClass() );
	
	if( self.ItemObj ) then
	
		if( self.ItemObj.CanPickup ) then
		
			local ret = self.ItemObj:CanPickup( ply, self );
			if( !ret ) then
			
				return;
			
			end
			
		end
		
	end
	
	local ret = hook.Run( "CanPickup", ply, self.ItemObj, self );
	if( !ret ) then
	
		return;
		
	end
	
	if( !self.Used ) then
		
		self.Used = true;

		if !self.ItemObj then
			local should_create = true
			local metaitem = GAMEMODE:GetItemByID(self:GetItemClass())
			if metaitem.Stackable then
				local other_items = ply:HasItem(self:GetItemClass())
				if other_items then
					if !other_items.IsItem then
						other_items = other_items[1]
					end
					
					if other_items:CanStack(metaitem) then
						other_items:AddItemToStack()
						should_create = false
					end
				end
			end
			
			if should_create then
				self.ItemObj = ply:GiveItem( self:GetItemClass(), self.Vars or metaitem.Vars );
			end
		else
			local should_transfer = true
			local metaitem = GAMEMODE:GetItemByID(self:GetItemClass())
			if metaitem.Stackable then
				local other_items = ply:HasItem(self:GetItemClass())
				if other_items then
					if !other_items.IsItem then
						other_items = other_items[1]
					end
					
					if other_items:CanStack(self.ItemObj) then
						other_items:AddItemToStack(self.ItemObj)
						self.ItemObj = nil
						should_transfer = false
					end
				end
			end
			
			if should_transfer then
				self.ItemObj.owner = ply;
				self.ItemObj:SetCharID( ply:CharID() )
				
				local x,y = self.ItemObj:FindBestPosition()
				self.ItemObj.x = x
				self.ItemObj.y = y
				
				self.ItemObj:UpdateSave();
				self.ItemObj:TransmitToOwner();
				ply.Inventory[self.ItemObj:GetID()] = self.ItemObj
			end
		end
		hook.Run( "ItemPickedUp", ply, self.ItemObj or self:GetItemClass() );
		self:Remove();
		
	end
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( CurTime() > self.KillTime ) then
		
		self:Remove();
		
	end
	
end
