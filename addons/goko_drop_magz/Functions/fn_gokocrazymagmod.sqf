/* 
 *	goko mag drop add-on v1.22
 *	author: gokmen 'the0utsider'
 *	latest update: 03-21-2019
 *	website: https://github.com/the0utsider/mag-drop
*/

/// init variables
gokoMag_var_magLifeTime = profileNamespace getVariable ["gokoMag_var_magLifeTime", 1800];

/// cba options
if(isClass(configFile >> "CfgPatches" >> "cba_settings")) then 
{
	[] spawn 
	{
		[
			"gokoMag_var_magLifeTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
			"LIST", // setting type
			["Particle simulation lifetime (Minutes)","Decals lifetime in the world"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
			"Goko Magazine drop sim add-on", // Pretty name of the category where the setting can be found. Can be stringtable entry.
			[[300,600,1200,1800,2400,3600],["5","10","20","30 minutes","40 Minutes", "1 Hour"],3], // default
			true, // "global" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
			{
			} // function that will be executed once on mission start and every time the setting is changed.
		] call CBA_Settings_fnc_init;	
	};	
};

/// main function
goko_fnc_reloadingOver9000 =
{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	private _ammoInMagazine = _unit ammo _muzzle;
	if !(_ammoInMagazine isEqualTo 0 && {_weapon isEqualTo _muzzle}) exitWith{};

	private _bOutofAmmo = getArray(configfile >> "CfgWeapons" >> _muzzle >> "magazines") arrayIntersect magazines _unit isEqualTo [];
	if (_bOutofAmmo || _weapon isEqualTo secondaryWeapon _unit) exitWith{};
		
	_null = _this spawn {
		private _actor = _this#0;
		private _muzzle = _this#2;
		private _magazine = _this#5;
		private _saveCycles = if (isPlayer _actor) then {0.05} else {0.5};
		
		while {alive _actor && currentMuzzle _actor isEqualTo _muzzle} do {
			sleep _saveCycles;
			if (!isPlayer _actor || inputAction "reloadMagazine" > 0) exitwith{};
		};
		if (!alive _actor || !(currentMuzzle _actor isEqualTo _muzzle)) exitwith{};
		
		waitUntil {
			sleep (0.4 + random 0.6);
			if (!alive _actor) exitwith {true};
			private _dirAndVelocity = (velocity _actor vectorAdd [0, -0.2 + random 0.4, -1 + random 2]) vectorMultiply (1 + random 0.5);
			private _getMagazineP3d = if (getText(configfile >> "CfgMagazines" >> _magazine >> "model") isEqualTo "\A3\weapons_F\ammo\mag_univ.p3d") then 
			{"\A3\Structures_F_EPB\Items\Military\Magazine_rifle_F.p3d"} else {getText(configfile >> "CfgMagazines" >> _magazine >> "model")};
			[_actor, _dirAndVelocity, _getMagazineP3d] remoteExecCall ["goko_fx_dropMag"];
			
			private _unitFeetPos = _actor modelToWorldVisualWorld [0,0,-3];
			private _impactOnGround = selectRandom ["goko_dropmagz\sfx\gear_impact01.wav", "goko_dropmagz\sfx\gear_impact02.wav",
			"goko_dropmagz\sfx\gear_impact03.wav", "goko_dropmagz\sfx\gear_impact04.wav", "goko_dropmagz\sfx\gear_impact05.wav",
			"goko_dropmagz\sfx\gear_impact06.wav"];
			sleep 0.6;
			playsound3d [_impactOnGround, _actor, false, _unitFeetPos, 1.2, 1 + random 0.5, 50];
			true;
		};
	};
};

/// 3d particle effect
goko_fx_dropMag =
{
	// function parameters
	_unit = _this#0;
	_unitVel = _this#1;
	_model = _this#2;

	_popOut = "#particleSource" createVehicleLocal (getPosATL _unit);
	_popOut setParticleParams
	[
		/*Sprite*/			[_model,1,0,1,0],"",// File,Ntieth,Index,Count,Loop
		/*Type*/			"spaceObject",
		/*TimmerPer*/		1,
		/*Lifetime*/		gokoMag_var_magLifeTime,
		/*Position*/		[0,0,0],
		/*MoveVelocity*/	_unitVel,
		/*Simulation*/		random 0.4, 1, 0.2, 0,//rotationVel,weight,volume,rubbing
		/*Scale*/		[1],
		/*Color*/		[[1,1,1,1],[1,1,1,1]],
		/*AnimSpeed*/		[1,1],
		/*randDirPeriod*/	0.5,
		/*randDirIntesity*/	0.05,
		/*onTimerScript*/	"",
		/*DestroyScript*/	"",
		/*Follow*/		_this,
		/*Angle*/              0,
		/*onSurface*/          true,
		/*bounceOnSurface*/    0.25,
		/*emissiveColor*/      [[0,0,0,0]]
		/*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
	];

	// RANDOM / TOLERANCE PARAMS
	_source setParticleRandom
	[
		/*LifeTime*/		gokoMag_var_magLifeTime,
		/*Position*/		[0,0,0],
		/*MoveVelocity*/	_unitVel,
		/*rotationVel*/		1,
		/*Scale*/		0.8,
		/*Color*/		[1,1,1,1],
		/*randDirPeriod*/	0.5,
		/*randDirIntesity*/	0.2,
		/*Angle*/		0
	];

	_modelMemoryPoints = ["LeftForeArm", "LeftForeArmRoll", "RightForeArmRoll", "rwrist"]; 
	_memPoint = selectrandom _modelMemoryPoints; 
	_popOut setDropInterval 420; 
	_popOut attachTo [_unit,[0,0,0],_memPoint]; 

};