-- URLs for web integration

GM.MOTDURL = "";
GM.SteamGroupURL = "";
GM.WebsiteURL = "";
GM.UpdatesURL = "";
GM.BooksURL = "";

-- Security

GM.PrivateMode = false;

GM.PrivateSteamIDs = {
	"STEAM_0:0:17359435", -- disseminate
};

GM.TestingClosedMessage = "This server is closed for testing!";

GM.AdminsCanSpawnSENTs = false;

GM.MinNameLength = 4;
GM.MaxNameLength = 40;

GM.MaxDescLength = 2000;

GM.MaxCharacters = 10;

GM.CitizenModels = {
	"models/tnb/techcom/male_01.mdl",
	"models/tnb/techcom/male_02.mdl",
	"models/tnb/techcom/male_03.mdl",
	"models/tnb/techcom/male_04.mdl",
	"models/tnb/techcom/male_06.mdl",
	"models/tnb/techcom/male_07.mdl",
	"models/tnb/techcom/male_09.mdl",
	"models/tnb/techcom/male_10.mdl",
	"models/tnb/techcom/male_11.mdl",
	"models/tnb/techcom/male_12.mdl",
	"models/tnb/techcom/male_15.mdl",
	"models/tnb/techcom/male_17.mdl",
	"models/tnb/techcom/male_18.mdl",
	"models/tnb/techcom/male_20.mdl",
	"models/tnb/techcom/male_26.mdl",
	"models/tnb/techcom/male_29.mdl",
	"models/tnb/techcom/male_30.mdl",
	"models/tnb/techcom/male_32.mdl",
	"models/tnb/techcom/male_38.mdl",
	"models/tnb/techcom/male_42.mdl",
	"models/tnb/techcom/male_54.mdl",
	"models/tnb/techcom/male_56.mdl",
	"models/tnb/techcom/male_57.mdl",
	"models/tnb/techcom/male_58.mdl",
	"models/tnb/techcom/male_59.mdl",
	"models/tnb/techcom/male_60.mdl",
	"models/tnb/techcom/male_65.mdl",
	"models/tnb/techcom/male_70.mdl",
	"models/tnb/techcom/male_75.mdl",
	"models/tnb/techcom/male_86.mdl",
	"models/tnb/techcom/male_89.mdl",
	"models/tnb/techcom/male_92.mdl",
	"models/tnb/techcom/male_95.mdl",
	"models/srp/fmale_01.mdl",
	"models/srp/fmale_02.mdl",
	"models/srp/fmale_03.mdl",
	"models/srp/fmale_04.mdl",
	"models/srp/fmale_05.mdl",
	"models/srp/fmale_06.mdl",
	"models/srp/fmale_07.mdl",
	"models/srp/fmale_08.mdl",
	"models/srp/fmale_10.mdl",
	"models/srp/fmale_11.mdl",
	"models/srp/fmale_12.mdl",
	"models/srp/fmale_13.mdl",
	"models/srp/fmale_14.mdl",
};

GM.DonatorModels = {
	"models/cultist/head_rips/jonny_cringe.mdl",
	"models/cultist/head_rips/metro_anna.mdl",
	"models/cultist/head_rips/tnb/bandit_shifty.mdl",
	"models/cultist/head_rips/tnb/female_28.mdl",
	"models/cultist/head_rips/tnb/female_57.mdl",
	"models/cultist/head_rips/tnb/female_64.mdl",
	"models/cultist/head_rips/tnb/female_75.mdl",
}

GM.BodyModels = {
	"models/tnb/stalker_2019/anorak.mdl",
	"models/tnb/stalker_2019/anorak_f.mdl",
}

-- efficiency
GM.EfficientModelCheck = {}
for k,v in next, GM.CitizenModels do
	GM.EfficientModelCheck[v] = true
end
for k,v in next, GM.DonatorModels do
	GM.EfficientModelCheck[v] = true
end

-- General Gameplay

GM.UseHunger = true;

GM.FistsHaveEffectOnPlayers = false;
GM.DoorRammingEnabled = true;

GM.StatsAvailable = 40;

GM.UntieOnDeath = false;

-- AFK Autokicker

GM.AFKKickerEnabled = false;
GM.AFKPercentage = 0.90;
GM.AFKTime = 600;

-- Cross-Server Transfers

IP_GENERAL = "play.100rads.bar";
PORT_CORDON = 27036;
PORT_GARBAGE = 27037;
PORT_GREATSWAMP = 27038;
PORT_DARKSCAPE = 27018;
PORT_RASPAD = 27019;
PORT_AGROPROM = 27020;
PORT_ROSTOK = 27017;
PORT_CROSSROADS = 27040;
PORT_YANTAR = 27022;
PORT_TRUCKCEMETERY = 27039;
PORT_ARMYWAREHOUSES = 27016;
PORT_DEADCITY = 27025;
PORT_LIMANSK = 27026;
PORT_LIMANSKHOSPITAL = 27027;
PORT_REDFOREST = 27028;
PORT_RADAR = 27029;
PORT_JUPITER = 27015;
PORT_JUPITERUNDERGROUND = 27031;
PORT_ZATON = 27032;
PORT_PRIPYAT = 27033;
PORT_CNPP = 27034;
PORT_GENERATORS = 27035;

TRANSITPORT_CORDON_GARBAGE = 1;
TRANSITPORT_CORDON_DARKSCAPE = 2;
TRANSITPORT_CORDON_SWAMP = 3;

TRANSITPORT_GARBAGE_CORDON = 1;
TRANSITPORT_GARBAGE_AGROPROM = 2;
TRANSITPORT_GARBAGE_RASPAD = 3;
TRANSITPORT_GARBAGE_ROSTOK = 4;

TRANSITPORT_ROSTOK_ARMYWAREHOUSES = 1;
TRANSITPORT_ROSTOK_GARBAGE = 2;
TRANSITPORT_ROSTOK_YANTAR = 3;
TRANSITPORT_ROSTOK_TRUCKCEMETERY = 4;
TRANSITPORT_ROSTOK_CROSSROADS = 5;

TRANSITPORT_CROSSROADS_ROSTOK = 1;
TRANSITPORT_CROSSROADS_REDFOREST = 2;
TRANSITPORT_CROSSROADS_MARSH = 3;
TRANSITPORT_CROSSROADS_ARMYWAREHOUSES = 4;
TRANSITPORT_CROSSROADS_SWAMP = 5;

TRANSITPORT_MARSH_CROSSROADS = 1;

TRANSITPORT_SWAMP_CORDON = 1;
TRANSITPORT_SWAMP_AGROPROM = 2;
TRANSITPORT_SWAMP_CROSSROADS = 1;

TRANSITPORT_AGROPROM_GARBAGE = 1;
TRANSITPORT_AGROPROM_SWAMP = 2;
TRANSITPORT_AGROPROM_YANTAR = 3;

TRANSITPORT_YANTAR_AGROPROM = 1;
TRANSITPORT_YANTAR_ROSTOK = 2;
TRANSITPORT_YANTAR_DEADCITY = 3;

TRANSITPORT_DARKSCAPE_CORDON = 1;
TRANSITPORT_DARKSCAPE_RASPAD = 2;

TRANSITPORT_RASPAD_DARKSCAPE = 1;
TRANSITPORT_RASPAD_GARBAGE = 2;
TRANSITPORT_RASPAD_TRUCKCEMETERY = 3;

TRANSITPORT_ARMYWAREHOUSES_ROSTOK = 1;
TRANSITPORT_ARMYWAREHOUSES_RADAR = 2;
TRANSITPORT_ARMYWAREHOUSES_DEADCITY = 3;
TRANSITPORT_ARMYWAREHOUSES_TRUCKCEMETERY = 4;
TRANSITPORT_ARMYWAREHOUSES_REDFOREST = 5;
TRANSITPORT_ARMYWAREHOUSES_CROSSROADS = 6;
TRANSITPORT_ARMYWAREHOUSES_JUPITER = 7;

TRANSITPORT_TRUCKCEMETERY_RASPAD = 1;
TRANSITPORT_TRUCKCEMETERY_ROSTOK = 2;
TRANSITPORT_TRUCKCEMETERY_ARMYWAREHOUSES = 3;

TRANSITPORT_DEADCITY_LIMANSK = 1;
TRANSITPORT_DEADCITY_ARMYWAREHOUSES = 2;
TRANSITPORT_DEADCITY_YANTAR = 3;

TRANSITPORT_LIMANSK_DEADCITY = 1;
TRANSITPORT_LIMANSK_REDFOREST = 2;
TRANSITPORT_LIMANSK_LIMANSKHOSPITAL = 3;

TRANSITPORT_REDFOREST_LIMANSK = 1;
TRANSITPORT_REDFOREST_ARMYWAREHOUSES = 2;
TRANSITPORT_REDFOREST_RADAR = 3;
TRANSITPORT_REDFOREST_JUPITER = 4;
TRANSITPORT_REDFOREST_CROSSROADS = 5;

TRANSITPORT_RADAR_ARMYWAREHOUSES = 1;
TRANSITPORT_RADAR_REDFOREST = 2;
TRANSITPORT_RADAR_PRIPYAT = 3;

TRANSITPORT_JUPITER_REDFOREST = 1;
TRANSITPORT_JUPITER_JUPITERUNDERGROUND = 2;
TRANSITPORT_JUPITER_ZATON = 3;
TRANSITPORT_JUPITER_ARMYWAREHOUSES = 4;

TRANSITPORT_ZATON_JUPITER = 1;
TRANSITPORT_ZATON_CNPP = 2;

TRANSITPORT_PRIPYAT_RADAR = 1;
TRANSITPORT_PRIPYAT_JUPITERUNDERGROUND = 2;
TRANSITPORT_PRIPYAT_CNPP = 3;

TRANSITPORT_LIMANSKHOSPITAL_LIMANSK = 1;
TRANSITPORT_LIMANSKHOSPITAL_CNPP = 2;

TRANSITPORT_JUPITERUNDERGROUND_PRIPYAT = 1;
TRANSITPORT_JUPITERUNDERGROUND_JUPITER = 2;

TRANSITPORT_CNPP_LIMANSKHOSPITAL = 1;
TRANSITPORT_CNPP_ZATON = 2;
TRANSITPORT_CNPP_PRIPYAT = 3;
TRANSITPORT_CNPP_GENERATORS = 4;

TRANSITPORT_GENERATORS_CNPP = 1;

-- Donations

GM.BronzeDonorAmount = 0;
GM.SilverDonorAmount = 15;
GM.GoldDonorAmount = 30;

-- Items

GM.GearSelection = {
	backpack = {
		cost = 500,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	med_medkit = {
		cost = 900,
		origin = Vector(-19, 16, 0),
		angs = Angle(0, -90, 0),
		scale = 1
	},
	smallmedkit = {
		cost = 100,
		origin = Vector(-20, 8.5, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	antirad = {
		cost = 300,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	bread = {
		cost = 85,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["sausage"] = {
		cost = 50,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["energydrink"] = {
		cost = 80,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["touristcan1"] = {
		cost = 100,
		origin = Vector(-24, 11, 0),
		angs = Angle(0, 0, 0),
		scale = 0.8
	},
	["cossacks"] = {
		cost = 500,
		origin = Vector(-24, 16, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["radio"] = {
		cost = 800,
		origin = Vector(-29, 12, 0),
		angs = Angle(0, -90, 0),
		scale = 1
	},
	["dollars"] = {
		cost = 80,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["pda"] = {
		cost = 400,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["morley_reds"] = {
		cost = 150,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["playboy"] = {
		cost = 200,
		origin = Vector(-9, 12, 0),
		angs = Angle(0, -90, 0),
		scale = 1
	},
	["guitar"] = {
		cost = 700,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["gunoil"] = {
		cost = 200,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["geiger_counter"] = {
		cost = 2500,
		origin = Vector(-29, 4, 0),
		angs = Angle(0, -90, 0),
		scale = 1
	},
	["dosimeter"] = {
		cost = 100,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["ammo_9x18"] = {
		cost = 200,
		origin = Vector(-29, -13, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["weapon_srp_tokarev"] = {
		cost = 5500,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["ammo_762x25"] = {
		cost = 350,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["weapon_srp_sawnoff"] = {
		cost = 3500,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["ammo_12ga"] = {
		cost = 200,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["weapon_srp_doublebarrel"] = {
		cost = 6500,
		origin = Vector(8, 16.5, 13),
		angs = Angle(-85, -90, 90),
		scale = 1
	},
	["weapon_srp_m500"] = {
		cost = 7500,
		origin = Vector(-2, -4, 0),
		angs = Angle(0, -90, 90),
		scale = 1
	},
	["weapon_srp_hammerless"] = {
		cost = 1500,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["ammo_32acp"] = {
		cost = 100,
		origin = Vector(-29, -7, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["weapon_srp_kitchenknife"] = {
		cost = 500,
		origin = Vector(26, -11, 0),
		angs = Angle(0, 90, 90),
		scale = 1
	},
	["weapon_srp_kabar"] = {
		cost = 2500,
		origin = Vector(0, 0, 0),
		angs = Angle(0, 0, 0),
		scale = 1
	},
	["weapon_srp_hatchet"] = {
		cost = 1000,
		origin = Vector(12, 1, 0),
		angs = Angle(0, 0, 90),
		scale = 1
	},
	["suit_trench"] = {
		cost = 2000,
		origin = Vector(23, 7, 0),
		angs = Angle(0, 90, 0),
		scale = 1
	},
	["weapon_srp_f1"] = {
		cost = 2200,
		origin = Vector(10, 14, 1),
		angs = Angle(90, 0, 0),
		scale = 1
	},
}

GM.DefaultSelfRepairCond = 80

GM.RubleBudget = 9500;
GM.SellPercentage = 80;

GM.StalkerCursorEnabled = false

GM.SellToMenuEnabled = true

GM.ModSalesModifier = 15
GM.AttachSalesModifier = 25

GM.GiveOldBDUBack = true

GM.InventoryWidth = 7
GM.InventoryHeight = 50

-- 10% of current rad, so like 1000 rads would remove 100 health at this rate
GM.RadHealthReductionRate = 0.1

GM.RadioBeeps = {
	"npc/metropolice/vo/off1.wav",
	"npc/metropolice/vo/off2.wav",
	"npc/metropolice/vo/off3.wav",
	"npc/metropolice/vo/off4.wav",
	"npc/metropolice/vo/on1.wav",
	"npc/metropolice/vo/on2.wav",
	"npc/overwatch/radiovoice/on3.wav",
}

-- Sandbox

GM.PropBlacklist = {
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props_junk/gascan001a.mdl",
	"models/cranes/crane_frame.mdl",
	"models/props_c17/metalladder003.mdl",
	"models/props_canal/canal_bridge01.mdl",
	"models/props_canal/canal_bridge02.mdl",
	"models/props_canal/canal_bridge03a.mdl",
	"models/props_combine/prison01c.mdl",
	"models/props_combine/prison01b.mdl",
	"models/props_combine/prison01.mdl",
	"models/props_c17/furniturechair001a.mdl",
	"models/vehicles/car001b_hatchback.mdl",
	"models/props_junk/propane_tank001a.mdl",
	"models/props_combine/combine_bunker01.mdl",
	"models/props_combine/combine_tptimer.mdl",
	"models/props_combine/breen_tube.mdl",
	"models/combine_room/combine_monitor003a.mdl",
	"models/combine_room/combine_monitor002.mdl",
	"models/props_wasteland/submarine001a.mdl",
	"models/props_wasteland/submarine001b.mdl"
};

GM.PropWhitelist = {
	"models/props_c17/furniturestove001a.mdl",
}

GM.ToolTrustBasic = {
	"weld",
	"nocollide",
	"remover",
	"camera",
	"colour",
	"material",
	"rope",
	"winch",
	"ballsocket"
};

GM.ToolTrustAdvanced = {
	"ladder",
	"stacker_improved",
	"advresizer",
	"balloon",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"trails",
	"hoverball",
	"superfreeze",
	"streamradio"
};

GM.ToolTrustBlacklist = {
	"dynamite",
	"creator",
	"radiation",
	"duplicator",
};

GM.MainServerLocation = LOCATION_CROSSROADS

GM.RandomMutantGroups = {
	"vj_mutant_bloodsucker4",
	{
		"vj_mutant_boar", 
		"vj_mutant_flesh",
		"vj_mutant_flesh",
		"vj_mutant_flesh",
	},
	{
		"npc_wick_mutant_snork",
		"npc_wick_mutant_snork",
	},
	{
		"vj_mutant_cat",
		"vj_mutant_cat",
		"vj_mutant_cat",
	},
	{
		"vj_mutant_psevdodog",
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
	},
	{
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
		"npc_wick_mutant_dog",
	},
}

GM.ItemSpawnChance = 10
