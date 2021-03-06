/* 
 *	Goko Mag Drop add-on v1.23 for ARMA3 STEAM STABLE BRANCH
 *	Author: cgökmen 'the0utsider'
 *	Repo: github.com/the0utsider/mag-drop
 *	
 *	3D Particle fx function - spawns 3d particle with physics simulation
 *	spawns script to create super simple object on ground
*/

params ["_unit", "_relativeVelocity", "_ammoModelP3D", "_cachedAttachToCount"];

/// attach a particle source at hands of unit and spawn a magazine model with physics simulation
private _popOutMagazine = "#particleSource" createVehicleLocal (getPosATL _unit);
_popOutMagazine setParticleParams
[
	/*Sprite*/				[_ammoModelP3D,1,18,1,0],"",// File,Ntieth,Index,Count,Loop
	/*Type*/				"spaceObject",
	/*TimmerPer*/			0.6,
	/*Lifetime*/			1.1,
	/*Position*/			[0,0,0],
	/*MoveVelocity*/		_relativeVelocity,
	/*Simulation*/			random 1.5, 1, 0.000139253, 0.07,//rotationVel,weight,volume,rubbing
	/*Scale*/				[0.9],
	/*Color*/				[[1,1,1,1],[1,1,1,1]],
	/*AnimSpeed*/			[1,1],
	/*randDirPeriod*/		0.1,
	/*randDirIntesity*/		0.01,
	/*onTimerScript*/		"\goko_drop_magz\Functions\TransformIntoSimpleObject.sqf",
	/*DestroyScript*/		"",
	/*Follow*/				"",
	/*Angle*/				0,
	/*onSurface*/			false,
	/*bounceOnSurface*/		0.15,
	/*emissiveColor*/		[[0,0,0,0]]
	/**3D Array Vector dir	[random 0.5, random -0.5, -1 + random 2]  DEV BRANCH ONLY!!!!!!! wont be available until 1.92@stable */
];

private _modelMemoryPoints = selectRandom ["lwrist", "rwrist", "rightHandmiddle1", "granat"];
_popOutMagazine setDropInterval 7777; // man is five, devil is six, god is seven!!11!1!
_popOutMagazine attachTo [_unit, [0,0,0], _modelMemoryPoints];

/// detach and get rid of particle source. 
/// Array count from previous function represents last added attached array object above without any modification.
private _attachedListLast = attachedObjects _actor;
[{	
	detach (_this#0 select _this#1); 
	deleteVehicle (_this#0 select _this#1);
}, [_attachedListLast, _cachedAttachToCount], 0.1] call CBA_fnc_waitAndExecute;
