/* 
 *	Goko Mag Drop add-on v1.22c for ARMA3 DEV v1.92x (implement CBA & Muzzle Reload EH)
 *	Author: gökmen 'the0utsider' çakal
 *	latest update: 03-29-2019
 *	website: https://github.com/the0utsider/mag-drop
 *	
 *	3D Particle fx
 *
*/




_position = _this;

_findingUnit = _this nearEntities ["man", 5];

_unit = _findingUnit#0;

_findingModel = _unit getVariable "GokoMD_VAR_magazineModelNamePistol";

_findingNormal = _unit getVariable "GokoMD_VAR_surfaceNormalVector";

_ongroundyeah = createVehicle ["Land_Magazine_rifle_F", _position, [], 0, "CAN_COLLIDE"];

_ongroundyeah setVectorUp _findingNormal;

systemchat format ["unit found: %1 - model name: %2 - normalV: %3", _findingUnit, _findingModel, _findingNormal];

/*
drop
[
	[_findingModel,1,18,1,0],"",
	"spaceObject",
	99,
	5,
	[0,0,0],
	[0,0,0],
	0, 1, 0.2, 0,
	[1],
	[[1,1,1,1],[1,1,1,1]],
	[1,1],
	0,
	0,
	"",
	"",
	"",
	0,
	true,
	0,
	[[0,0,0,0]],
	_findingNormal
];