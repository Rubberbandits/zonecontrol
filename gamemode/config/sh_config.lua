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

-- Character Creation

GM.QuizEnabled = false;
GM.QuizQuestions = {
	-- Label, { options }, correct option
	{ "1. The farmer went _____ the market.", { "to", "too", "two" }, "to" },
	{ "2. What is 6 * 8?", { "50", "48", "40" }, "48" },
	{ "3. ______ apples are very ripe.", { "They're", "There", "Their" }, "Their" },
	{ "4. ______ is the name of the rebel scientist in Half-Life 2.", { "Kleiner", "Alyx", "Barney" }, "Kleiner" },
	{ "5. ______ of people like candy.", { "Allot", "A lot", "Alot" }, "A lot" }
}

GM.IntroCinematicEnabled = false;
GM.IntroCamText = { };
GM.IntroCamText[1] = "Welcome to the server. This is a Half-Life 2-themed serious roleplay server.\n\nIf you were looking for something else, you can disconnect at any time.";
GM.IntroCamText[2] = "Citizens here live under control of the Combine. Create a character to start off - you're a citizen.\n\nStart a business, sell drugs, put up propaganda for the Combine, furnish an apartment, etc.";
GM.IntroCamText[3] = "The Combine forces are located in the Nexus. Breaking the law will get you punished.\n\nThey can and will beat you randomly, arrest you - or worse.\n\nYou can join them in the F3 menu after your character has existed for a day.";
GM.IntroCamText[4] = "City 18 isn't without its underground - you might find contraband, covert rebels, even black market dealers.\n\nBe sure to look around, but be quiet or the CCA may catch you.";
GM.IntroCamText[5] = "Please note this is an administrated server and admins reserve the right to take disciplinary action for whatever they see fit.\n\nCommon bannable things are punching everything, trying to farm stats, and improper names (you need a first and last name).\n\nJust be smart about what you do in-character vs. out-of-character.";
GM.IntroCamText[6] = "Good luck in City 18.\n\nPick a first and last name at the character creation prompt, and have fun!";

GM.IntroCinematicMusic = "music/hl2_song26_trainstation1.mp3";



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

GM.BodyModels = {
	"models/tnb/stalker_2019/anorak.mdl",
	"models/tnb/stalker_2019/anorak_f.mdl",
}

-- efficiency
GM.EfficientModelCheck = {}
for k,v in next, GM.CitizenModels do
	GM.EfficientModelCheck[v] = true
end

-- General Gameplay

GM.UseHunger = true;

GM.FistsHaveEffectOnPlayers = false;
GM.DoorRammingEnabled = true;

GM.StatsAvailable = 40;

GM.UntieOnDeath = false;

GM.OffDutyCombineCanBuyDoors = true;

GM.NotifyWhenPlayersJoin = true;

-- AFK Autokicker

GM.AFKKickerEnabled = false;
GM.AFKPercentage = 0.90;
GM.AFKTime = 600;

-- Cross-Server Transfers

IP_GENERAL = "play.100rads.bar";
PORT_CORDON = 27036;
PORT_GARBAGE = 27037;
PORT_GREATSWAMP = 27016;
PORT_DARKSCAPE = 27018;
PORT_RASPAD = 27019;
PORT_AGROPROM = 27020;
PORT_ROSTOK = 27017;
PORT_CROSSROADS = 27015;
PORT_YANTAR = 27022;
PORT_TRUCKCEMETERY = 27016;
PORT_ARMYWAREHOUSES = 27024;
PORT_DEADCITY = 27025;
PORT_LIMANSK = 27026;
PORT_LIMANSKHOSPITAL = 27027;
PORT_REDFOREST = 27028;
PORT_RADAR = 27029;
PORT_JUPITER = 27030;
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

-- Resources

GM.WorkshopMaps = { };
GM.WorkshopMaps["md_venetianredux_b2fix"]		= 106094354;
GM.WorkshopMaps["rp_c18_v1"] 					= 132931674;
GM.WorkshopMaps["rp_c18_v2"] 					= 132937160;
GM.WorkshopMaps["rp_city8"] 					= 132913036;
GM.WorkshopMaps["rp_city8_2"] 					= 132940295;
GM.WorkshopMaps["rp_city8_canals"] 				= 132911524;
GM.WorkshopMaps["rp_city8_district1"] 			= 132919876;
GM.WorkshopMaps["rp_city8_district9"] 			= 132916875;
GM.WorkshopMaps["rp_city11_night_v1b"] 			= 127632645;
GM.WorkshopMaps["rp_city17_v1"] 				= 113352748;
GM.WorkshopMaps["rp_city23_night"] 				= 143076340;
GM.WorkshopMaps["rp_city45_2013"] 				= 118759412;
GM.WorkshopMaps["rp_city45_catalyst_x1f_final"]	= 221567663;
GM.WorkshopMaps["rp_coast_03_fix"] 				= 132960387;
GM.WorkshopMaps["rp_coast_04"] 					= 132961866;
GM.WorkshopMaps["rp_coast05"] 					= 132962296;
GM.WorkshopMaps["rp_coast_07_final"] 			= 132962909;
GM.WorkshopMaps["rp_coast_09"] 					= 132963389;
GM.WorkshopMaps["rp_coast_12"] 					= 132964637;
GM.WorkshopMaps["rp_industrial17_v1"] 			= 171962560;
GM.WorkshopMaps["rp_outercanals"] 				= 119420070;
GM.WorkshopMaps["rp_shhnexustraining_v1"] 		= 147818395;
GM.WorkshopMaps["rp_tb_city45_v01"] 			= 132933551;
GM.WorkshopMaps["rp_tb_city45_v02n"] 			= 132934734;
GM.WorkshopMaps["rp_tnb_central18nexus_v2"] 	= 133029448;
GM.WorkshopMaps["rp_venetian_iconoclasm"] 		= 119692505;
GM.WorkshopMaps["rp_cc_caves_01"] 				= 242386747;
GM.WorkshopMaps["rp_cc_thecanals_1"] 			= 263502310;
GM.WorkshopMaps["rp_cc_thecanals_2"] 			= 268370407;

-- Items

GM.Recipes = {
	{ { "bleach", "water" }, 				{ "drug_breenwater" } },
	{ { "drug_breenwater", "smallmedkit" }, { "drug_medkit" } },
	{ { "drug_breenwater", "vodka" }, 		{ "drug_vodka" } },
	{ { "drug_vodka", "cookedantliongib" }, { "drug_antlion" } },
	{ { "drug_antlion", "bugbait" }, 		{ "drug_extract" } },
	{ { "beans" }, 							{ "cookedbeans" },				{ "burntbeans" },		1/6 },
	{ { "antliongib" }, 					{ "cookedantliongib" },			{ "burntantliongib" },	1/4 },
	{ { "headcrabgib" }, 					{ "cookedheadcrabgib" },		{ "burntheadcrabgib" },	1/4 },
	{ { "chinese", "water" }, 				{ "cookedchinese" } },
	{ { "teapot", "teabags", "water" }, 	{ "tea", "tea", "tea", "tea" } },
	{ { "teapot", "coffeebeans", "water" }, { "coffee", "coffee", "coffee", "coffee" } },
};

GM.GearSelection = {
	["backpack"] = 500,
	["med_medkit"] = 900,
	["smallmedkit"] = 100,
	["antirad"] = 300,
	["bread"] = 85,
	["sausage"] = 50,
	["energydrink"] = 80,
	["touristcan1"] = 100,
	["cossacks"] = 500,
	["radio"] = 800,
	["dollars"] = 80,
	["pda"] = 400,
	["morley_reds"] = 150,
	["playboy"] = 200,
	["guitar"] = 700,
	["gunoil"] = 200,
	["geiger_counter"] = 2500,
	["dosimeter"] = 100,
	["weapon_srp_makarov"] = 4400,
	["ammo_9x18"] = 200,
	["weapon_srp_tokarev"] = 5500,
	["ammo_762x25"] = 350,
	["weapon_srp_sawnoff"] = 3500,
	["ammo_12ga"] = 200,
	["weapon_srp_doublebarrel"] = 6500,
	["weapon_srp_m500"] = 7500,
	["weapon_srp_hammerless"] = 1500,
	["ammo_32acp"] = 100,
	["weapon_srp_kitchenknife"] = 500,
	["weapon_srp_kabar"] = 2500,
	["weapon_srp_hatchet"] = 1000,
	["suit_trenchcoat"] = 2000,
	["weapon_srp_f1"] = 2200,
}

GM.DefaultSelfRepairCond = 80

GM.RubleBudget = 9500;
GM.SellPercentage = 70;

GM.StalkerCursorEnabled = false

GM.SellToMenuEnabled = true

GM.ModSalesModifier = 15
GM.AttachSalesModifier = 25

GM.GiveOldBDUBack = true

GM.InventoryWidth = 7
GM.InventoryHeight = 50

-- 10% of current rad, so like 1000 rads would remove 100 health at this rate
GM.RadHealthReductionRate = 0.1

-- Voices

GM.VoicesEnabled = false;
GM.VoiceDelay = 3;

GM.RadioBeeps = {
	"npc/metropolice/vo/off1.wav",
	"npc/metropolice/vo/off2.wav",
	"npc/metropolice/vo/off3.wav",
	"npc/metropolice/vo/off4.wav",
	"npc/metropolice/vo/on1.wav",
	"npc/metropolice/vo/on2.wav",
	"npc/overwatch/radiovoice/on3.wav",
}

GM.Voices = { };
GM.Voices[GENDER_MALE] = {
	{ "Joke 1", "pointoc/human/talk/jokes/joke_1.ogg" },
	{ "Greetings", {
		{ "Well, hey.", "pointoc/human/meet/meet_hello_1.ogg" },
		{ "Hey, brother.", "pointoc/human/meet/meet_hello_2.ogg" },
		{ "I'm listening.", "pointoc/human/meet/meet_hello_3.ogg" },
		{ "Heeeeeeeeey!", "pointoc/human/meet/meet_hello_4.ogg" },
		
	} },
};

GM.CombineDeathLineEnabled = true;
GM.CombineDeathLine = "DISPATCH: Biosignal lost for $COMBINENAME. Remaining units contain.";

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