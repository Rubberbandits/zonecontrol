ITEM.Name =  "Medkit";
ITEM.Desc =  "General purpose medkit. Contains emergency first aid materials to stave off death.";
ITEM.Model =  "models/kali/miscstuff/stalker/aid/first aid kit.mdl";
ITEM.ConsumeText = "You tend to your wounds. It'll do for now."
ITEM.HealAmount = 45
ITEM.Weight =  1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.02 );
ITEM.BulkPrice =  7500;
ITEM.License =  "D";
ITEM.DrugType = "MEDKIT"

GM:CreateDrugType("MEDKIT", {
	Duration = 60,
	Hooks = {
		HUDPaint = function()
			if GAMEMODE.DrugType and GAMEMODE.DrugType == "MEDKIT" then
				local d = CurTime() - GAMEMODE.DrugStart;
				
				if( d <= 60 ) then
					
					local mul = 1;
					
					if( d < 4 ) then
						
						mul = d / 4;
						
					else
						
						mul = 1 - ( ( d - 4 ) / 56 );
						
					end
					
					DrawSharpen( 5 + math.sin( CurTime() * 10 ) * mul * 5, math.sin( CurTime() * 2 ) * mul );
					
				else
					
					GAMEMODE:ResetDrugFX();
					
				end
			end
		end,
		Think = function()
			if GAMEMODE.DrugType and GAMEMODE.DrugType == "MEDKIT" then
				local d = CurTime() - GAMEMODE.DrugStart;
			
				if( d <= 60 ) then
					
					local mul = 1;
					
					if( d < 4 ) then
						
						mul = d / 4;
						
					elseif( d > 40 ) then
						
						mul = 1 - ( ( d - 40 ) / 20 );
						
					end
					
					if( GAMEMODE.DrugAmbience ) then
						
						GAMEMODE.DrugAmbience:ChangeVolume( math.abs( math.sin( CurTime() * 10 ) * mul ), 0 );
						
					end
					
				else
					
					GAMEMODE:ResetDrugFX();
					
				end
			end
		end,
		/*RenderScreenspaceEffects = function()
			if GAMEMODE.DrugType and GAMEMODE.DrugType == "MEDKIT" then
				local d = CurTime() - GAMEMODE.DrugStart;
				
				if( d <= 60 ) then
					
					local mul = 1;
					
					if( d < 4 ) then
						
						mul = d / 4;
						
					else
						
						mul = 1 - ( ( d - 4 ) / 56 );
						
					end
					
					local tab = { };
					
					tab[ "$pp_colour_addr" ] 		= 0;
					tab[ "$pp_colour_addg" ] 		= 0;
					tab[ "$pp_colour_addb" ] 		= 0;
					tab[ "$pp_colour_brightness" ] 	= 0;
					tab[ "$pp_colour_contrast" ] 	= 1;
					tab[ "$pp_colour_colour" ] 		= 1 + 3 * mul;
					tab[ "$pp_colour_mulr" ] 		= 255 * mul;
					tab[ "$pp_colour_mulg" ] 		= 255 * mul;
					tab[ "$pp_colour_mulb" ] 		= 255 * mul;
					
					DrawColorModify( tab );
					
				else
					
					GAMEMODE:ResetDrugFX();
					
				end
			end
		end,*/
		PlayerDrugApplied = function(ply, drug)
			if drug == "MEDKIT" and CLIENT then
				GAMEMODE:ResetDrugFX();
				
				GAMEMODE.DrugType = "MEDKIT";
				GAMEMODE.DrugStart = CurTime();
				
				surface.PlaySound( Sound( "ambient/atmosphere/hole_hit2.wav" ) );
				
				GAMEMODE.DrugAmbience = CreateSound( LocalPlayer(), "ambient/atmosphere/noise2.wav" );
				GAMEMODE.DrugAmbience:SetSoundLevel( 0 );
				GAMEMODE.DrugAmbience:Play();
			end
		end,
		PlayerDrugRemoved = function(ply, drug)
			if drug == "MEDKIT" and CLIENT then
				GAMEMODE:ResetDrugFX()
			end
		end,
	},
})