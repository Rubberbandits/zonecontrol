function nCBuyDoor( ply, ent )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #ent:DoorOwners() == 0 and #ent:DoorAssignedOwners() == 0 and ply:CombineBuyDoors() ) then
		
		if( ply:Money() >= ent:DoorPrice() ) then
			
			ply:BuyDoor( ent );
			
		end
		
	end
	
end
netstream.Hook( "nCBuyDoor", nCBuyDoor );

function nCSellDoor( ply, ent )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		ply:SellDoor( ent );
		
	end
	
end
netstream.Hook( "nCSellDoor", nCSellDoor );

function nCLockUnlock( ply, ent )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ply:CanLock( ent ) ) then
		
		if( ent:GetSaveTable().m_bLocked ) then
			
			ply:EmitSound( "doors/door_latch3.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Unlock" );
			
		else
			
			ply:EmitSound( "doors/door_locked2.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Lock" );
			
		end
		
	end
	
end
netstream.Hook( "nCLockUnlock", nCLockUnlock );

function nCNameDoor( ply, ent, val )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( string.len( val ) <= 50 and string.len( val ) >= 1 ) then
			
			ent:SetDoorName( val );
			
		end
		
	end
	
end
netstream.Hook( "nCNameDoor", nCNameDoor );

function nCMakeOwner( ply, ent, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( targ and targ:IsValid() and !table.HasValue( ent:DoorOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:AddDoorOwner( ent );
			
		end
		
	end
	
end
netstream.Hook( "nCMakeOwner", nCMakeOwner );

function nCRemoveOwner( ply, ent, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end

	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( targ and targ:IsValid() and table.HasValue( ent:DoorOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:RemoveDoorOwner( ent );
			
		end
		
	end
	
end
netstream.Hook( "nCRemoveOwner", nCRemoveOwner );

function nCGiveCredits( ply, amt, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end

	if amt <= 0 then return end
	
	if( ply:Money() >= amt ) then
		
		ply:AddMoney( -amt );
		targ:AddMoney( amt );
		
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		
		hook.Run( "MoneyGiven", ply, targ, amt )
		
	end
	
end
netstream.Hook( "nCGiveCredits", nCGiveCredits );

function nCExamine( ply )
	local ent = ply:GetEyeTrace().Entity
	if ent:GetClass() != "cc_item" then return end
	
	local metaitem = GAMEMODE:GetItemByID(ent:GetItemClass())
	local text = metaitem.Desc
	if ent:GetItemObject() then
		text = ent:GetItemObject():GetDesc()
	end
	
	ply:Notify(nil, COLOR_NOTIF, "%s", text)
end
netstream.Hook( "nCExamine", nCExamine );

function nCPatDownStart( ply, targ )
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	local mul = 1;
	netstream.Start( targ, "nCreateTimedProgressBar", 5*mul, "Being pat down...", ply );
	
end
netstream.Hook( "nCPatDownStart", nCPatDownStart );

function nCPatDown( ply, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if ply:GetPos():Distance( targ:GetPos() ) > 128 then return end
	
	if targ:GetVelocity():Length2D() <= 5 then
		local tab = {}
		if !targ.Inventory then return end
		
		for k, v in next, targ.Inventory do
			tab[k] = { v:GetClass(), v.Vars }
		end
		
		netstream.Start(ply, "nCPattedDown", tab)
	end
end
netstream.Hook( "nCPatDown", nCPatDown );

local function nCReviveStart(ply, targ)
	if ply == targ then return end
	if !ply:HasItem("med_medkit") and !ply:HasCharFlag("D") then return end
	if ply:GetPos():Distance(targ:GetPos()) > 64 then return end
	
	netstream.Start(targ, "nCreateTimedProgressBar", 10, "Being revived...", ply)
end
netstream.Hook("nCReviveStart", nCReviveStart)

function nCRevive(ply, targ)
	if ply == targ then return end
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end
	if ply:APC() and ply:APC():IsValid() then return end
	if !ply:HasItem("med_medkit") and !ply:HasCharFlag("D") then return end
	if !targ:InDeathState() then return end
	
	if ply:GetPos():Distance(targ:GetPos()) > 64 then return end
	
	if targ:GetVelocity():Length2D() <= 5 then
		local ragdoll_pos = targ:Ragdoll():GetPos()
		targ:Spawn()
		targ:SetPos(ragdoll_pos)
		
		if !ply:HasCharFlag("D") then
			ply:HasItem("med_medkit"):RemoveItem(true)
		end
	end
end
netstream.Hook( "nCRevive", nCRevive );

local function nCTreatStart(ply, targ)
	if ply == targ then return end
	if !ply:HasItem("med_medkit") and !ply:HasCharFlag("D") then return end
	if ply:GetPos():Distance(targ:GetPos()) > 64 then return end
	
	netstream.Start(targ, "nCreateTimedProgressBar", 10, "Being treated...", ply)
end
netstream.Hook("nCTreatStart", nCTreatStart)

function nCTreat(ply, targ)
	if ply == targ then return end
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end
	if ply:APC() and ply:APC():IsValid() then return end
	if !ply:HasItem("med_medkit") and !ply:HasCharFlag("D") then return end
	if !targ:IsWounded() then return end
	
	if ply:GetPos():Distance(targ:GetPos()) > 64 then return end
	
	if targ:GetVelocity():Length2D() <= 5 then
		targ:SetTiedUp(false)
		targ:SetIsWounded(false)
		
		if !ply:HasCharFlag("D") then
			ply:HasItem("med_medkit"):RemoveItem(true)
		end
	end
end
netstream.Hook( "nCTreat", nCTreat );

function nCTieUpStart( ply, targ )
	
	if( !ply:HasItem( "zipties" ) ) then return end
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	netstream.Start( targ, "nCreateTimedProgressBar", 5, "Being tied up...", ply );
	
end
netstream.Hook( "nCTieUpStart", nCTieUpStart );

function nCTieUp( ply, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 and ply:HasItem( "zipties" ) ) then
		
		targ:SetTiedUp( true );
		for _, v in pairs( GAMEMODE.HandsWeapons ) do
			
			if( targ:HasWeapon( v ) ) then
				
				targ:SelectWeapon( v );
				break;
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nCTieUp", nCTieUp );

function nCUntieStart( ply, targ )
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	if targ:IsWounded() then return end
	
	netstream.Start( targ, "nCreateTimedProgressBar", 2, "Being untied...", ply );
	
end
netstream.Hook( "nCUntieStart", nCUntieStart );

function nCUntie( ply, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	if targ:IsWounded() then return end
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 ) then
		
		targ:SetTiedUp( false );
		
	end
	
end
netstream.Hook( "nCUntie", nCUntie );

function nCSlitThroat( ply, targ )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end

	if( ply:GetPos():Distance( targ:GetPos() ) > 64 ) then return end
	
	if( (targ:PassedOut() or targ:InDeathState()) and ply:HasItem( "weapon_cc_knife" ) and targ:GetVelocity():Length2D() <= 5 ) then
		
		ply:SelectWeapon( "weapon_cc_knife" );
		ply:SetHolstered( false );
		
		ply:EmitSound( "Weapon_Knife.Hit" );
		
		local dmg = DamageInfo();
		dmg:SetAttacker( ply );
		dmg:SetDamage( 200 );
		dmg:SetDamageForce( Vector( 0, 0, 1 ) );
		dmg:SetDamagePosition( targ:GetPos() );
		dmg:SetDamageType( DMG_SLASH );
		dmg:SetInflictor( ply:GetWeapon( "weapon_cc_knife" ) );
		
		targ:TakeDamageInfo( dmg );
		
	end
	
end
netstream.Hook( "nCSlitThroat", nCSlitThroat );

function nCTakeRadio( ply, targ )
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_radio" and ply:CharID() == targ:GetDeployer() ) then
		
		targ:Remove();
		ply:GiveItem( "bigradio" );
		
	end
	
end
netstream.Hook( "nCTakeRadio", nCTakeRadio );

function nCRadioChannel( ply, targ, val )
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_radio" ) then
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
				
				targ:SetChannel( val );
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nCRadioChannel", nCRadioChannel );