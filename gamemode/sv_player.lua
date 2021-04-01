local meta = FindMetaTable( "Player" );

GM.CombineRadioFreq = 1000; -- dick weed

function GM:PlayerInitialSpawn( ply )
	
	if( !self.FullyLoaded ) then
		
		self:LogBug( "ERROR: PlayerInitialSpawn on player " .. ply:Nick() .. " before gamemode fully loaded." );
		return;
		
	end
	
	self.BaseClass:PlayerInitialSpawn( ply );
	
	ply:SetCustomCollisionCheck( true );
	ply:SetCanZoom( false );
	ply:Freeze( true );
	
	ply.AFKTime = CurTime();
	
	if( ply:IsBot() ) then
		
		return;
		
	end
	
	ply.SQLPlayerData = { };
	ply.SQLCharData = { };
	
	ply:SetHolstered( true );
	
end

function GM:PlayerInitialSpawnSafe( ply )
	
	ply:SetModelCC( table.Random( { "models/crow.mdl", "models/pigeon.mdl", "models/seagull.mdl" } ) );
	
	ply:LoadPlayerInfo();
	
	ply:SetRadioFreq( math.random( 0, 999 ) );
	ply:SyncAllGlobalData();
	
	ply:SetNotSolid( true );
	ply:SetMoveType( MOVETYPE_NOCLIP );
	
end

function GM:PlayerCheckFlag( ply, respawn )
	
	for i = 1, #ply:GetMaterials() do
		ply:SetSubMaterial( i - 1, ply:GetMaterials()[i] );
	end
	ply:SetModelCC( ply.CharModel )
	ply:SetSkin( ply:GetCharFromID( ply:CharID() ).Skingroup );
	
	if( ply.EntryPort and self.EntryPortSpawns[ply.EntryPort] ) then
		
		ply:SetPos( table.Random( self.EntryPortSpawns[ply.EntryPort] ) );
		return;
		
	end
	
end

function GM:PlayerCheckInventory( ply )
	if !ply.Inventory then
		ply.Inventory = {}
	end

	for _, v in next, ply.Inventory do
		local metaitem = GAMEMODE:GetItemByID(v:GetClass())
		
		if !metaitem then continue end
		if v:GetVar("Equipped", false) then
			v:Initialize()
		end
	end
	
	ply.LastCharID = ply:CharID()
end

function GM:PlayerConnect( name, ip )
	
	if( !self.Books ) then
		
		self:LoadBooks();
		
	end
	
end

function GM:PlayerSpawn( ply )
	self.BaseClass:PlayerSpawn( ply );
	
	player_manager.SetPlayerClass( ply, "player_cc" );
	
	ply:SetNoCollideWithTeammates( false );
	ply:SetAvoidPlayers( false );
	
	ply:SetDuckSpeed( 0.3 );
	ply:SetUnDuckSpeed( 0.3 );
	
	ply:SetHolstered( true );
	
	ply:AllowFlashlight( true );
	
	ply:SetMaxHealth(100)
	if ply.JustDied then
		ply:SetHealth(10)
		ply.JustDied = false
	end
	ply.LastRadiation = 0
	ply:SetRadiation(0)
	
	ply:SetLastLegShot( -20 );
	
	ply:SetConsciousness( 100 );
	ply:WakeUp( true );
	
	ply.DrownDamage = 0;
	
	ply.Uniform = nil;
	
	ply:SetNotSolid( false );
	ply:SetMoveType( MOVETYPE_WALK );
	
	if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
		
		ply:Ragdoll():Remove();
		
	end
	
	if( ply:IsBot() ) then
		
		if( !ply.CharCreateCompleted ) then
			
			local data = { };
			data.Date = os.date( "!%m/%d/%y %H:%M:%S" );
			data.RPName = ply:Nick();
			data.Model = table.Random( self.CitizenModels );
			data.Money = 200;
			data.CharFlags = "";
			data.Inventory = "backpack:1";
			data.BusinessLicenses = 0;
			data.Hunger = 0;
			
			data.Title = "This bot, named " .. ply:Nick() .. ", was born today out of a Xen portal anomaly. They don't remember much, as they have no memories, and their motor functions are extremely hindered by the fact that they have no brain. They cannot speak, simply existing as a shell, forever doomed to wander around Garry's Mod roleplay servers, fruitlessly.";
			data.TitleOne = "[]"
			data.TitleTwo = "[]"
			
			ply:LoadCharacter( data );
			
		end
		
		return;
		
	end
	
	if( !ply.InitialSafeSpawn ) then
		
		ply.InitialSafeSpawn = true;
		self:PlayerInitialSpawnSafe( ply );
		
	end
	
	if( !ply.CharCreateCompleted ) then return end
	
	self:PlayerCheckFlag( ply, true );
	self:PlayerCheckInventory( ply );
	self:SpeedThink( ply );
	
	ply.LastCharID = ply:CharID()
end

function GM:PlayerLoadout( ply )
	
	if( !ply.CharCreateCompleted ) then return end
	
	if( ply:PhysTrust() == 1 or ply:IsAdmin() ) then
		
		ply:Give( "weapon_physgun" );
		
	end
	
	if( ply:ToolTrust() > 0 or ply:IsAdmin() ) then
		
		ply:Give( "gmod_tool" );
		
	end
	
	ply:Give( "weapon_cc_hands" );
	ply:Give( "weapon_cc_bolt" );
	
end

function meta:LoadPlayer( data )

	if !data then return end
	
	self:SetToolTrust( tonumber( data.ToolTrust ), true );
	self:SetPhysTrust( tonumber( data.PhysTrust ), true );
	self:SetPropTrust( tonumber( data.PropTrust ), true );
	self:SetNewbieStatus( tobool( data.NewbieStatus ), true );
	self:SetCustomMaxProps( tonumber( data.CustomMaxProps ), true );
	self:SetCustomMaxRagdolls( tonumber( data.CustomMaxRagdolls ), true );
	
	self:SetScoreboardTitle( data.ScoreboardTitle, true );
	self:SetScoreboardTitleC( Vector( data.ScoreboardTitleC ), true );
	self:SetScoreboardBadges( tonumber( data.ScoreboardBadges ), true );
	
	self:SetDonationAmount( tonumber( data.DonationAmount ), true );
	
	self:SetUserGroup(data.Rank)
	self:SetWatched(tobool(data.Watched), true)
	
	if self:Watched() then
		GAMEMODE:Notify(player.GetAdmins(), nil, COLOR_ERROR, "Watched player %s has joined the server.", self:Nick())
	end
	
end

function nRequestPData( ply )
	
	if( !ply.RequestedPData ) then
		
		ply:LoadPlayer( ply.SQLPlayerData );
		ply.RequestedPData = true;
		
	end
	
end
netstream.Hook( "nRequestPData", nRequestPData );

function meta:LoadCharacter( data )
	
	if self.CharCreateCompleted and self:CharID() and self:CharID() > 0 then
		GAMEMODE:UpdateCharacterFieldOffline(self:CharID(), "Health", self:Health())
	end

	self.CharCreateCompleted = true;
	self:Freeze( false );
	
	self:StripWeapons();
	self.EquippedWeapons = {}
	
	self:ClearDrug();
	
	self:SetTeam( TEAM_CITIZEN );
	
	self:SetCharCreationDate( data.Date );
	
	self:SetCharID( tonumber( data.id ) );

	local TitleOneTab = util.JSONToTable( data.TitleOne ) or {};
	local TitleTwoTab = util.JSONToTable( data.TitleTwo ) or {};
	local DescTab = util.JSONToTable( data.Title ) or {};
	
	self:SetRPName( data.RPName );
	self:SetDescription( DescTab["offduty"] or "" );
	self:SetTitleOne( TitleOneTab["offduty"] or "" );
	self:SetTitleTwo( TitleTwoTab["offduty"] or "" );
	
	self.CharModel = data.Model;
	
	if table.HasValue(GAMEMODE.CitizenModels, data.Model) then
		self:SetBody(data.Body)
	else
		self:SetBody("")
	end
	
	self:SetTrait( tonumber( data.Trait ) );
	
	self:SetMoney( tonumber( data.Money ) );
	
	self:SetCharFlags( data.CharFlags );
	
	self:SetBusinessLicenses( tonumber( data.BusinessLicenses ) );
	
	self:SetHunger( tonumber( data.Hunger ) );

	self:SetHealth(tonumber(data.Health))

	self.EntryPort = tonumber( data.EntryPort );
	
	self:UpdateCharacterField( "LastOnline", os.date( "!%m/%d/%y %H:%M:%S" ) );
	
	if( self:IsBot() ) then return end
	
	self:SyncAllOtherData();
	
	self:PostLoadCharacter();
	
	if self.Inventory then
		if table.Count(self.Inventory) > 0 then
			for k,v in next, self.Inventory do
				if v.OnUnloadItem then
					v:OnUnloadItem()
					netstream.Start(self, "UnloadItem", k)
				end
				GAMEMODE.g_ItemTable[k] = nil
				self.Inventory[k] = nil
			end
		end
	end
	
	self.Inventory = {}
	netstream.Start(self, "nLoadInventory", {})
	
	local function onSuccess(ret)
		for k,v in next, ret do
			if !GAMEMODE:GetItemByID(v.ItemClass) then continue end
		
			local object = item(self, v.ItemClass, v.id, util.JSONToTable(v.Vars), v.PosX, v.PosY)
			object:TransmitToOwner()
		end
	
		netstream.Start(self, "CharacterLoaded")
		self:Spawn()
	end
	mysqloo.Query(Format("SELECT * FROM cc_items WHERE Owner = '%d' AND Stockpile = 0", self:CharID()), onSuccess)
	
	GAMEMODE:LogSQL( "Player " .. self:Nick() .. " loaded character " .. data.RPName .. "." )
end

function meta:PostLoadCharacter()
	
end

function GM:SpeedThink( ply )

	local walk, run, jump, crouch = ply:GetSpeeds();

	if( ply:GetRunSpeed() != run ) then
		
		ply:SetRunSpeed( run );
		
	end
	
	if( ply:GetWalkSpeed() != walk ) then
		
		ply:SetWalkSpeed( walk );
		
	end
	
	if( ply:GetJumpPower() != jump ) then
		
		ply:SetJumpPower( jump );
		
	end
	
	if( ply:GetCrouchedWalkSpeed() != math.floor( crouch / walk ) ) then
		
		ply:SetCrouchedWalkSpeed( math.floor( crouch / walk ) );
		
	end
	
end

function GM:FindUseEntity( ply, ent )
	
	if( ply:PassedOut() ) then return; end
	if( ply:TiedUp() and !( ent and ent:IsValid() and ent:IsVehicle() ) ) then return; end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return ply:MountedGun() end
	
	return self.BaseClass:FindUseEntity( ply, ent );
	
end

function GM:PlayerUse( ply, ent )
	
	return self.BaseClass:PlayerUse( ply, ent );
	
end

function GM:KeyPress( ply, key )
	

	
end

function GM:PlayerSay( ply, text, t )
	
	return "";
	
end

function ccCSay( ply, cmd, args )
	
	if( ply:EntIndex() != 0 ) then return end
	
	local text = "";
	
	for i = 1, #args do
		
		text = text .. args[i] .. " ";
		
	end
	
	text = string.Trim( text );

	netstream.Start( nil, "nConSay", text );
	
end
concommand.Add( "csay", ccCSay );

function ccASay( ply, cmd, args )
	
	if( ply:EntIndex() != 0 ) then return end
	
	local text = "";
	
	for i = 1, #args do
		
		text = text .. args[i] .. " ";
		
	end
	
	text = string.Trim( text );
	
	local rf = { };
	for _, v in pairs( player.GetAll() ) do
		
		if( v != ply and ( v:IsAdmin() or v:IsEventCoordinator() ) ) then
			
			table.insert( rf, v );
			
		end
		
	end

	netstream.Start( rf, "nConASay", text );
	
end
concommand.Add( "asay", ccASay );

function GM:PlayerDeathSound()
	
	return true;
	
end

GM.BannedWeaponPickups = {
	"weapon_crowbar",
	"weapon_stunstick",
	"weapon_pistol",
	"weapon_smg1",
	"weapon_ar2",
	"weapon_shotgun",
	"weapon_crossbow",
	"weapon_357",
	"weapon_rpg",
	"weapon_annabelle",
};

GM.VortWeaponPickups = {
	"weapon_cc_vortigaunt",
	"weapon_cc_vortigaunt_slave",
	"weapon_cc_vortbroom",
	"weapon_cc_vortbroom_diss",
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
};

GM.StalkerWeaponPickups = {
	"weapon_cc_stalker",
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
};

function GM:PlayerCanPickupWeapon( ply, wep )
	
	if( table.HasValue( self.BannedWeaponPickups, wep:GetClass() ) ) then
		
		return false;
		
	end
	
	if( ply:HasCharFlag( "V" ) or ply:HasCharFlag( "W" ) ) then
		
		if( !table.HasValue( self.VortWeaponPickups, wep:GetClass() ) ) then
			
			return false;
			
		end
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( !table.HasValue( self.StalkerWeaponPickups, wep:GetClass() ) ) then
			
			return false;
			
		end
		
	end
	
	return true;
	
end

function GM:EntityTakeDamage( ent, dmg )
	
	if( ent:GetClass() == "prop_ragdoll" and ent:PropFakePlayer() and ent:PropFakePlayer():IsValid() ) then
		local ply = ent:PropFakePlayer()
		
		if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then return end
		
		if( dmg:GetDamageType() == DMG_CRUSH ) then return end
		
		local pdmg = DamageInfo();
		pdmg:SetAttacker( dmg:GetAttacker() );
		pdmg:SetDamage( dmg:GetDamage() );
		pdmg:SetDamageForce( dmg:GetDamageForce() );
		pdmg:SetDamagePosition( ent:GetPos() );
		pdmg:SetInflictor( dmg:GetInflictor() );
		
		ent:PropFakePlayer():TakeDamageInfo( pdmg );
		
	end

	
	if( ent:IsPlayer() ) then
		
		if( ent:IsEFlagSet( EFL_NOCLIP_ACTIVE ) or ent:Team() == TEAM_UNASSIGNED ) then
			
			dmg:ScaleDamage( 0 );
			return;
			
		end
		
		dmg:ScaleDamage( ent:DrugDamageMod() );
		dmg:ScaleDamage( math.Clamp( ( ent:Hunger() / 100 ) * 2, 1, 2 ) );
		
	end
	
	if( bit.band( dmg:GetDamageType(), DMG_BULLET ) == DMG_BULLET and dmg:GetAttacker():IsPlayer() ) then
		
		if( dmg:GetAttacker():GetPos():Distance( ent:GetPos() ) > 200 or ent:GetVelocity():Length() > 50 ) then
			
			if( !dmg:GetAttacker().NextShoot ) then dmg:GetAttacker().NextShoot = CurTime(); end
			
			if( CurTime() >= dmg:GetAttacker().NextShoot ) then
				
				dmg:GetAttacker().NextShoot = CurTime() + 5;
				
			end
			
		end
		
	end
	
	if( ent:IsNPC() ) then
		
		ent:AddEntityRelationship( dmg:GetAttacker(), D_HT, 99 );
		
	end
	
	if ent:IsPlayer() and !dmg:IsFallDamage() then
		if ent.Inventory then
		    local nDmgScale = 1
			for _,item in next, ent.Inventory do
				if item.OnTakeDamage then
					item:OnTakeDamage(dmg)
				end
				
			    if !item:GetVar("Equipped",false) then continue end
			    if !item.GetArmorValues then continue end

		    	for m,n in next, item:GetArmorValues() do
				    if dmg:IsDamageType(m) then
				    	nDmgScale = nDmgScale * n
				    end
				end
	        end
	    
	        if nDmgScale then
                dmg:ScaleDamage(nDmgScale)
		    end
	    end
	end
end

function GM:DoPlayerDeath( ply, attacker, dmg )

	if( ply.Inventory ) then
		
		for _, v in pairs( ply.Inventory ) do
			
			if( v.OnPlayerDeath ) then
				
				v:OnPlayerDeath()
				
			end
			
		end
		
	end
	
	if( self.UntieOnDeath ) then
		
		ply:SetTiedUp( false );
		
	end
	
	if( !ply:PassedOut() ) then
		
		ply:CreateRagdoll();
		
	end

	ply.JustDied = true
end

function GM:PlayerDeathThink(ply)
	if ( ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end
	if ( ply:IsBot() || ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then

		ply:Spawn()

	end
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) or ply:Team() == TEAM_UNASSIGNED ) then
       
        dmginfo:ScaleDamage( 0 );
        return;
       
    end

    if( hitgroup == HITGROUP_HEAD ) then

        dmginfo:ScaleDamage( 1.5 );
       
    end
   
    if( hitgroup == HITGROUP_LEFTARM or
        hitgroup == HITGROUP_RIGHTARM or
        hitgroup == HITGROUP_LEFTLEG or
        hitgroup == HITGROUP_RIGHTLEG or
        hitgroup == HITGROUP_GEAR ) then

        dmginfo:ScaleDamage( 0.5 );
       
    end
   
    if( hitgroup == HITGROUP_LEFTLEG or
        hitgroup == HITGROUP_RIGHTLEG ) then
       
        if( bit.band( dmginfo:GetDamageType(), DMG_BULLET ) == DMG_BULLET ) then
           
            local b = 15 - ( ply:Toughness() / 100 * 15 );
            b = b + ( ply:Hunger() / 100 ) * 10;
           
            if( CurTime() - ply:LastLegShot() >= b + 5 ) then
               
                ply:EmitSound( "Flesh.Break" );
               
            end
           
            ply:SetLastLegShot( CurTime() );
           
        end
       
    end

end

function GM:GetFallDamage( ply, speed )
	
	local b = 15 - ( ply:Toughness() / 100 * 15 );
	b = b + ( ply:Hunger() / 100 ) * 10;
	
	if( CurTime() - ply:LastLegShot() >= b + 5 ) then
		
		ply:EmitSound( "Flesh.Break" );
		
	end
	
	ply:SetLastLegShot( CurTime() );
	
	return self.BaseClass:GetFallDamage( ply, speed );
	
end

function GM:CanPlayerSuicide( ply )
	
	if( ply:CharID() == -1 ) then return false end
	if( ply:TiedUp() ) then return false end
	if( ply:PassedOut() ) then return false end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return false end
	if( ply:APC() and ply:APC():IsValid() ) then return false end
	
	return true;
	
end

function GM:PlayerShouldTakeDamage( ply, attacker )
	
	if( attacker:GetClass() == "prop_ragdoll" or attacker:GetClass() == "cc_item" ) then return false end
	
	return true;
	
end

function GM:EntityRemoved( ent )
	
	if( ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:RagdollIndex() == ent:EntIndex() ) then
				
				v:SetRagdollIndex( -1 );
				
			end
			
		end
		
		if( ent:PropFakePlayer() and ent:PropFakePlayer():IsValid() and ent:PropFakePlayer():PassedOut() ) then
			
			ent:PropFakePlayer():Kill();
			
		end
		
	end
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:APC() == ent ) then
			
			v:SetPos( ent:GetPos() + Vector( 0, 0, 20 ) );
			v:SetAPC( NULL );
			
			local rag = v:PassOut();
			v:SetConsciousness( 80 );
			
			rag:GetPhysicsObject():SetVelocity( Vector( math.random( -5000000, 5000000 ), math.random( -5000000, 50000000 ), math.random( 500000, 5000000 ) ) );
			
		end
		
	end
	
end

function GM:PlayerDisconnected( ply )
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( table.HasValue( v:DoorOwners(), ply:CharID() ) ) then
			
			if( table.Count( v:DoorOwners() ) == 1 ) then
				
				ply:SellDoor( v );
				
			else
				
				ply:RemoveDoorOwner( v );
				
			end
			
		end
		
		if( table.HasValue( v:DoorAssignedOwners(), ply ) ) then
			
			ply:RemoveDoorAssignedOwner( v );
			
		end
		
	end
	
	if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
		
		ply:Ragdoll():Remove();
		
	end
	
	if( ply:ToolTrust() == 0 and !ply:IsAdmin()) then
		
		for _, v in pairs( ents.FindByClass( "prop_physics" ) ) do
			
			if( ply:SteamID() == v:PropSteamID() ) then
				
				v:Remove();
				
			end
			
		end
		
	end

	self:UpdateCharacterFieldOffline(ply:CharID(), "Health", ply:Health())
	
end

function GM:ShutDown()

	for k,v in next, ents.FindByClass( "cc_item" ) do
		if v:GetItemObject() then
			mysqloo.Query( Format( "DELETE FROM Items WHERE id = %d", v:GetItemObject():GetID() ) );
		end
	end
	
end

function GM:PlayerSpray( ply )
	
	return game.IsDedicated();
	
end

function GM:PlayerCanHearPlayersVoice( targ, ply )
	
	return !game.IsDedicated();
	
end

function GM:PlayerShouldTaunt( ply, act )
	
	return true;
	
end

function GM:CanPlayerEnterVehicle( ply, vehicle, role )
	
	if( self.BaseClass:CanPlayerEnterVehicle( ply, vehicle, role ) ) then

	return true;
	
end
	
end

function GM:CanExitVehicle( vehicle, ply )
	
	if( vehicle.Static ) then
		
		vehicle.PlayerAngles = ply:EyeAngles();
		vehicle.PlayerAngles.r = 0;
		
	end
	
	return self.BaseClass:CanExitVehicle( vehicle, ply );
	
end

function GM:PlayerLeaveVehicle( ply, vehicle )
	
	if( vehicle.PlayerPos ) then
		
		ply:SetPos( vehicle.PlayerPos );
		
	end
	
	if( vehicle.PlayerAngles ) then
		
		ply:SetEyeAngles( vehicle.PlayerAngles );
		
	end
	
	vehicle.PlayerPos = nil;
	
end

function meta:WaterThink()
	
	if( !self:Alive() ) then return end
	
	local waterlevel = 3;
	local targ = self;
	
	if( self:PassedOut() ) then
		
		waterlevel = 1;
		targ = self:Ragdoll();
		
	end
	
	if( targ:WaterLevel() < waterlevel ) then
		
		self.AirFinished = CurTime() + 7;
		
		if( self.DrownDamage and self.DrownDamage > 0 ) then
			
			if( !self.PainFinished ) then self.PainFinished = 0 end
			
			if( self.PainFinished < CurTime() ) then
				
				self.PainFinished = CurTime() + 1;
				
				local dmg = DamageInfo();
				dmg:SetAttacker( game.GetWorld() );
				dmg:SetDamage( 10 );
				dmg:SetDamageForce( Vector() );
				dmg:SetDamagePosition( self:GetPos() );
				dmg:SetInflictor( game.GetWorld() );
				dmg:SetDamageType( DMG_DROWN );
				
				GAMEMODE:EntityTakeDamage( self, dmg );
				
				self:SetHealth( self:Health() + dmg:GetDamage() );
				self.DrownDamage = self.DrownDamage - 10;
				
			end
			
		end
		
	else
		
		if( !self:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then
			
			if( self.AirFinished < CurTime() ) then
				
				if( !self.PainFinished ) then self.PainFinished = 0 end
				
				if( self.PainFinished < CurTime() ) then
					
					self.PainFinished = CurTime() + 1;
					
					local dmg = DamageInfo();
					dmg:SetAttacker( game.GetWorld() );
					dmg:SetDamage( 10 );
					dmg:SetDamageForce( Vector() );
					dmg:SetDamagePosition( self:GetPos() );
					dmg:SetInflictor( game.GetWorld() );
					dmg:SetDamageType( DMG_DROWN );
					
					if( !self.DrownDamage ) then self.DrownDamage = 0 end
					self.DrownDamage = math.min( self.DrownDamage + 10, 50 );
					
					self:TakeDamageInfo( dmg );
					
				end
				
			end
			
		end
		
	end
	
end

function nSetTyping( ply, val )
	
	ply:SetTyping( val );
	
end
netstream.Hook( "nSetTyping", nSetTyping );

function GM:PlayerButtonDown( ply, button )
	
	if( SERVER ) then
		
		ply.AFKTime = CurTime();
		
	end
	
	self.BaseClass:PlayerButtonDown( ply, button );
	
end

function GM:AFKThink( ply )
	
	if( self.AFKKickerEnabled and CurTime() - ply.AFKTime > self.AFKTime and ( #player.GetAll() / game.MaxPlayers() ) > self.AFKPercentage and ply:DonationAmount() == 0 and !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		ply:Kick( "Auto-kicked for being AFK" );
		
	end
	
end

function GM:PlayerSetHandsModel( pl, ent )
	local info = player_manager.RunClass( pl, "GetHandsModel" )
	if ( !info ) then
		local playermodel = player_manager.TranslateToPlayerModelName( pl:GetModel() )
		info = player_manager.TranslatePlayerHands( playermodel )
	end

	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
		if info.submaterials and #info.submaterials > 0 then
			for k,v in next, info.submaterials do
				ent:SetSubMaterial(v[1], v[2])
			end
		end
	end
end

function meta:ApplyRadiation(amt)
	if !amt or amt == 0 then return end

	hook.Run("PlayerRadiationApplied", self, amt)
end

local function handle_rads(ply, amt)
	ply:SetRadiation(ply:Radiation() + amt)
	
	if !ply.LastRadiation then
		ply.LastRadiation = ply:Radiation()
	end

	if ply:Radiation() - ply.LastRadiation >= 1 then
		local cur_health = ply:Health()
		local cur_max = ply:GetMaxHealth()
		local next_max = math.Clamp(ply:GetMaxHealth() - (ply:Radiation() - ply.LastRadiation), 1, 100)

		if cur_health > next_max then
			ply:SetHealth(math.Round(next_max))
		end

		ply:SetMaxHealth(math.Round(next_max))

		ply.LastRadiation = ply:Radiation()
	end
end
hook.Add("PlayerRadiationApplied", "STALKER.ApplyRadiationDamage", handle_rads)

local function handle_dosi(ply, amt)
	if ply.Inventory then
		local items = ply:HasItem("dosimeter")
		if istable(items) and !items.IsItem then
			for k,v in next, items do
				if v:GetVar("Activated", false) then
					v:SetVar("Radiation", math.Clamp(v:GetVar("Radiation", 0) + amt, 0, 25), false, true)
				end
			end
		elseif istable(items) then
			if items:GetVar("Activated", false) then
				items:SetVar("Radiation", math.Clamp(items:GetVar("Radiation", 0) + amt, 0, 25), false, true)
			end
		end
	end
end
hook.Add("PlayerRadiationApplied", "STALKER.UpdateDosimeter", handle_dosi)