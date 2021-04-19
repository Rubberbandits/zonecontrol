ITEM.Name =  "Vodka";
ITEM.Desc =  "A bottle of vodka. Probably unsafe to drink.";
ITEM.Model =  "models/kek1ch/dev_vodka2.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  11;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.56 );
ITEM.BulkPrice =  100;
ITEM.License =  "X"
ITEM.ConsumeText = "You open and drink the vodka."
ITEM.UseText = "Drink"
ITEM.HungerReduce = 15
ITEM.RadiationHealAmount = 10
ITEM.DrugType = "VODKA"

GM:CreateDrugType("VODKA", {
	Duration = 60,
	Hooks = {
		Think = function()
			if GAMEMODE.DrugType and GAMEMODE.DrugType == "VODKA" then
				local d = CurTime() - GAMEMODE.DrugStart
				
				if( d <= 60 ) then
					local mul = 1;
					
					if( d < 4 ) then
						
						mul = d / 4;
						
					else
						
						mul = 1 - ( ( d - 4 ) / 56 );
						
					end
					
					if( GAMEMODE.DrugAmbience ) then
						
						GAMEMODE.DrugAmbience:ChangeVolume( math.abs( math.sin( CurTime() * 3 ) * 0.5 * mul ), 0 );
						
					end
					
				else
					
					GAMEMODE:ResetDrugFX();
					
				end
			end
		end,
		HUDPaint = function()
			if !GAMEMODE.matWater then
				GAMEMODE.matWater = Material("effects/water_warp01")
			end

			local matWater = GAMEMODE.matWater

			if GAMEMODE.DrugType and GAMEMODE.DrugType == "VODKA" then
				local d = CurTime() - GAMEMODE.DrugStart
			
				if d <= 60 then
					local mul = 1
					
					if( d < 4 ) then
						mul = d / 4
					else
						mul = 1 - ( ( d - 4 ) / 56 );
					end
					
					render.SetBlend( mul )
					render.UpdateScreenEffectTexture()
					matWater:SetFloat( "$envmap", 0 )
					matWater:SetFloat( "$envmaptint", 0 )
					matWater:SetFloat( "$refractamount", math.sin( CurTime() * 3 ) * 0.5 * mul )
					matWater:SetInt( "$ignorez", 1 )
					render.SetMaterial( matWater )
					render.DrawScreenQuad()
					DrawSharpen( 5, math.sin( CurTime() * 2 ) * mul )
				else
					GAMEMODE:ResetDrugFX()
				end
			end
		end,
		PlayerDrugApplied = function(ply, drug)
			if !CLIENT then return end

			if drug == "VODKA" then
				GAMEMODE:ResetDrugFX();
				
				GAMEMODE.DrugType = "VODKA";
				GAMEMODE.DrugStart = CurTime();
				
				surface.PlaySound( Sound( "ambient/atmosphere/city_skypass1.wav" ) );
				
				GAMEMODE.DrugAmbience = CreateSound( LocalPlayer(), "ambient/water/underwater.wav" );
				GAMEMODE.DrugAmbience:SetSoundLevel( 0 );
				GAMEMODE.DrugAmbience:Play();
			end
		end,
		PlayerDrugRemoved = function(ply, drug)
			if drug == "VODKA" and CLIENT then
				GAMEMODE:ResetDrugFX()
			end
		end,
	}
})
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true