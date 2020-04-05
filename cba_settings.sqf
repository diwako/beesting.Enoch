// ACRE
force acre_sys_core_ts3ChannelSwitch = true;
force acre_sys_core_interference = false;
force acre_sys_core_fullDuplex = true;
force acre_sys_core_ignoreAntennaDirection = true;
force acre_sys_core_revealToAI = 0.2;
force acre_sys_core_terrainLoss = 0.2;

// ACE Misc
ace_common_persistentLaserEnabled = true;
force ace_hitreactions_minDamageToTrigger = 0.1;
force ace_laser_dispersionCount = 2;
force ace_laserpointer_enabled = true;
force ace_overpressure_distanceCoefficient = 1;
force ace_switchunits_enableSwitchUnits = false;
force ace_vehiclelock_vehicleStartingLockState = -1;
force ace_vehiclelock_defaultlockpickstrength = 45;
force ace_vehiclelock_lockvehicleinventory = true;
force ace_scopes_enabled = true;
force ace_noradio_enabled = true;
// force ace_advanced_fatigue_enabled = false;
force ace_microdagr_mapDataAvailable = 2;
force ace_gforces_enabledFor = 1;
force ace_cargo_enable = true;
force ace_cargo_paradropTimeCoefficent = 2;

// ACE Common
force ace_common_checkPBOsAction = 0;
force ace_common_checkPBOsCheckAll = false;
force ace_common_checkPBOsWhitelist = "[]";

// ACE Cookoff
force ace_cookoff_enable = false;
force ace_cookoff_enableAmmobox = false;
force ace_cookoff_enableAmmoCookoff = false;
force ace_cookoff_ammoCookoffDuration = 0.2;
force ace_cookoff_probabilityCoef = 0.75;

// ACE Finger
force ace_finger_enabled = true;
force ace_finger_maxRange = 7;

// ACE Frag
force ace_frag_enabled = true;
force ace_frag_spallEnabled = false;
force ace_frag_reflectionsEnabled = false;
force ace_frag_maxTrack = 8;
force ace_frag_maxTrackPerFrame = 8;

// ACE Interaction
ace_interaction_enableTeamManagement = true;
force ace_interaction_disableNegativeRating = true;

// ACE Mag repack
force ace_magazinerepack_timePerAmmo = 1;
force ace_magazinerepack_timePerMagazine = 1.5;
force ace_magazinerepack_timePerBeltLink = 4;

// ACE Map
force ace_map_BFT_Enabled = false;
force ace_map_BFT_Interval = 5;
force ace_map_BFT_HideAiGroups = true;
force ace_map_BFT_ShowPlayerNames = false;
force ace_map_mapIllumination = false;
force ace_map_mapGlow = true;
force ace_map_mapShake = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShowCursorCoordinates = true;
force ace_map_defaultChannel = 1;
force ace_map_gestures_enabled = true;
force ace_map_gestures_maxRange = 8;
force ace_map_gestures_interval = 0.05;

// ACE Markers
force ace_markers_movableMarkersEnabled = true;
force ace_markers_moveRestriction = 3;

// ACE Medical
force ace_medical_playerDamageThreshold = 1;
force ace_medical_AIDamageThreshold = 1;
force ace_medical_fractures = 1;
force ace_medical_fractureChance = 0.2;

force ace_medical_treatment_advancedBandages = 0;
force ace_medical_treatment_advancedMedication = true;
force ace_medical_treatment_woundReopening = false;

force ace_medical_ai_enabledFor = 0; // no one
force ace_medical_blood_enabledFor = 2; // blood drops are players only
force ace_medical_fatalDamageSource = 1; // trauma
force ace_medical_fractures = 0; // enable fractures
force ace_medical_gui_enableMedicalMenu = 1;
force ace_medical_gui_maxDistance = 5;
force ace_medical_gui_openAfterTreatment = true;
force ace_medical_ivFlowRate = 3.5;
force ace_medical_limping = 1; // limp on open wounds
force ace_medical_spontaneousWakeUpChance = 1; // boosted wake up chance
force ace_medical_spontaneousWakeUpEpinephrineBoost = 10; // epi boost on wake up chance
force ace_medical_statemachine_AIUnconsciousness = false; // disallow AI to be unconscious
force ace_medical_statemachine_cardiacArrestTime = 900; // 15 minutes
force ace_medical_statemachine_fatalInjuriesAI = 0; // AI can die any time
force ace_medical_statemachine_fatalInjuriesPlayer = 1; // players can only die during cardiac arrest
force ace_medical_treatment_advancedDiagnose = true;
force ace_medical_treatment_medicIV = 0; // anyone can give blood
force ace_medical_treatment_allowSelfIV = 1; // allow giving IV to yourself
force ace_medical_treatment_allowSharedEquipment = 1; // use medics stuff first
force ace_medical_treatment_clearTraumaAfterBandage = true; // clear trauma on bandage
force ace_medical_treatment_consumePAK = 0; // do not consume pak
force ace_medical_treatment_convertItems = 0; // convert vanilla items to ace medical
force ace_medical_treatment_cprSuccessChance = 0.40; // chance to stabilize heart rate
force ace_medical_treatment_locationEpinephrine = 0; // allow everywhere
force ace_medical_treatment_locationPAK = 0; // allow everywhere
force ace_medical_treatment_medicEpinephrine = 0; // allow for everyone
force ace_medical_treatment_medicPAK = 1; // only allow for medics
force ace_medical_painCoefficient = 0.8; // pain coefficient
force ace_medical_bleedingCoefficient = 0.5; // bleeding coeficient

// ACE MK6 Mortar
force ace_mk6mortar_airResistanceEnabled = false;
force ace_mk6mortar_allowComputerRangefinder = true;
force ace_mk6mortar_allowCompass = true;
force ace_mk6mortar_useAmmoHandling = true;

// ACE Name Tags
force ace_nametags_playerNamesViewDistance = 10;
force ace_nametags_showCursorTagForVehicles = false;
force ace_nametags_showNamesForAI = false;
force ace_nametags_showPlayerNames = 1;
force ace_nametags_showSoundWaves = 1;
force ace_nametags_showVehicleCrewInfo = true;

// ACE NVG
force ace_nightvision_disableNVGsWithSights = false;
force ace_nightvision_fogScaling = 1.5; 
force ace_nightvision_effectScaling = 0.75; 
force ace_nightvision_noiseScaling = 0.5; 
force ace_nightvision_aimDownSightsBlur = 0.1;
// ACE Overheating
force ace_overheating_overheatingDispersion = true;
force ace_overheating_unJamOnreload = true;
force ace_overheating_unJamFailChance = 0;
force ace_overheating_enabled = true;

// ACE Pylons
force ace_pylons_enabled = true;
force ace_pylons_searchDistance = 15;
force ace_pylons_timePerPylon = 5;
force ace_pylons_rearmNewPylons = true;
force ace_pylons_requireEngineer = false;
force ace_pylons_requireToolkit = false;

// ACE Rearm
force ace_rearm_level = 1;
force ace_rearm_supply = 0;

// ACE Refuel
force ace_refuel_rate = 5;
force ace_refuel_hoseLength = 20;

// ACE Respawn
force ace_respawn_savePreDeathGear = false;
force ace_respawn_removeDeadBodiesDisconnected = true;

// ACE Repair
force ace_repair_engineerSetting_repair = 0;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_repairDamageThreshold = 0.75;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_consumeItem_toolKit = 0;
force ace_repair_fullRepairLocation = 3;
force ace_repair_engineerSetting_fullRepair = 1;
force ace_repair_addSpareParts = true;
force ace_repair_wheelRepairRequiredItems = 0;
force ace_repair_autoShutOffEngineWhenStartingRepair = true;

// ACE Spect
force ace_spectator_enableAI = true;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;

// ACE VD
force ace_viewdistance_enabled = false;
ace_viewdistance_viewDistanceOnFoot = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_limitViewDistance = 0;
ace_viewdistance_objectViewDistanceCoeff = 0;

// ACE Weather
force ace_weather_enabled = true;
force ace_weather_updateInterval = 60;
force ace_weather_windSimulation = false;

// ACE Wind deflection
force ace_winddeflection_enabled = true;
force ace_winddeflection_vehicleEnabled = true;
force ace_winddeflection_simulationInterval = 0.05;

// ACE Adv Throwing
force ace_advanced_throwing_enabled = true;
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;

// ACE Captives
force ace_captives_allowHandcuffOwnSide = true;
force ace_captives_requireSurrender = 2;
force ace_captives_allowSurrender = true;
force ace_captives_requireSurrenderAi = false;

// ACE Expl
force ace_explosives_requireSpecialist = false;
force ace_explosives_punishNonSpecialists = true;
force ace_explosives_explodeOnDefuse = false;

// ACE Zeus
force ace_zeus_zeusAscension = false;
force ace_zeus_zeusBird = false;
force ace_zeus_remoteWind = false;
force ace_zeus_radioOrdnance = false;
force ace_zeus_revealMines = 0;
force ace_zeus_autoAddObjects = true;

// ACE Adv ballistic
force ace_advanced_ballistics_enabled = true;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Arsenal
force ace_arsenal_enableModIcons = true;
force ace_arsenal_allowDefaultLoadouts = false;
force ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_EnableRPTLog = false;

// ace quickmount
force ace_quickmount_enabled = true;

//ACEX
force acex_sitting_enable = true;
force acex_viewrestriction_mode = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveSea = 0;

// ACEX HC
force acex_headless_enabled = true;
force acex_headless_delay = 60;
force acex_headless_endMission = 2;
force acex_headless_log = false;


// Enhanced Movement
force EM_ALLOW_AIR_CLIMB = true;
force EM_COOLDOWN = 0.5;
force EM_ENABLE_MOD = true;
force EM_MAXHEIGHT = 3;
force EM_MAXWEIGHT_CLIMB1 = 100;
force EM_MAXWEIGHT_CLIMB2 = 66;
force EM_MAXWEIGHT_CLIMB3 = 44;
force EM_MAXWEIGHT_JUMP = 88;
force EM_STAMINA_COEF = 1;

// DUI - Squad Radar - Radar
force diwako_dui_radar_sortType = "fireteam2";
force diwako_dui_radar_sqlFirst = true;

// ACEX Field Rations
force acex_field_rations_affectAdvancedFatigue = false;
force acex_field_rations_enabled = true;
force acex_field_rations_hungerSatiated = 10;
force acex_field_rations_thirstQuenched = 10;
force acex_field_rations_timeWithoutFood = 6;
force acex_field_rations_timeWithoutWater = 3;
force acex_field_rations_hudShowLevel = 60;

// TFAR - Global settings
force TFAR_AICanHearPlayer = true;
force TFAR_AICanHearSpeaker = true;
force TFAR_curatorCamEars = true;
force TFAR_fullDuplex = true;
force TFAR_giveLongRangeRadioToGroupLeaders = false;
force TFAR_giveMicroDagrToSoldier = false;
force TFAR_givePersonalRadioToRegularSoldier = false;
force TFAR_SameLRFrequenciesForSide = true;
force TFAR_SameSRFrequenciesForSide = true;
force TFAR_setting_DefaultRadio_Rifleman_East = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Rifleman_Independent = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Rifleman_West = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Personal_east = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Personal_Independent = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Personal_West = "TFAR_rf7800str";
force TFAR_spectatorCanHearEnemyUnits = true;
force TFAR_spectatorCanHearEnemyUnits = true;
force TFAR_spectatorCanHearFriendlies = true;
force TFAR_voiceCone = true;

// LAMBS Danger
force lambs_danger_CQB_range = 25;
force lambs_danger_disableAIFleeing = true;
force lambs_danger_disableAIGestures = true;
force lambs_danger_minSuppression_range = 10;
force lambs_danger_panic_chance = 1;