/* 
 *	Goko Mag Drop add-on v1.22c for ARMA3 DEV v1.92x (implement CBA & Muzzle Reload EH)
 *	Author: gökmen 'the0utsider' çakal
 *	latest update: 03-29-2019
 *	website: https://github.com/the0utsider/mag-drop
 *	
 *	3D Particle fx
 *
*/

params ["_unit","_relativeVelocity", "_model"];

_popOutMagazine = "#particleSource" createVehicleLocal (getPosATL _unit);
_popOutMagazine setParticleParams
[
	/*Sprite*/				[_model,1,18,1,0],"",// File,Ntieth,Index,Count,Loop
	/*Type*/				"spaceObject",
	/*TimmerPer*/			18000,
	/*Lifetime*/			0.6,
	/*Position*/			[0,0,0],
	/*MoveVelocity*/		_relativeVelocity,
	/*Simulation*/			random 1, 1, 0.2, 0,//rotationVel,weight,volume,rubbing
	/*Scale*/				[0.9],
	/*Color*/				[[1,1,1,1],[1,1,1,1]],
	/*AnimSpeed*/			[1,1],
	/*randDirPeriod*/		5,
	/*randDirIntesity*/		0.5,
	/*onTimerScript*/		"",
	/*DestroyScript*/		"\goko_drop_magz\Functions\onGround.sqf",
	/*Follow*/				"",
	/*Angle*/				random 359,
	/*onSurface*/			true,
	/*bounceOnSurface*/		0.3,
	/*emissiveColor*/		[[0,0,0,0]],
	/*3D Array Vector dir*/	[0.01,0.01,0.99]
];

// RANDOM / TOLERANCE PARAMS

_modelMemoryPoints = selectRandom ["LeftForeArm", "LeftForeArmRoll", "RightForeArmRoll", "rwrist"]; 
_popOutMagazine setDropInterval 18000; 
_popOutMagazine attachTo [_unit, [0,0,0], _modelMemoryPoints];