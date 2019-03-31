/* 
 *	Goko Mag Drop add-on v1.22c for ARMA3 DEV v1.92x (implement CBA & Muzzle Reload EH)
 *	Author: gökmen 'the0utsider' çakal
 *	latest update: 03-29-2019
 *	website: https://github.com/the0utsider/mag-drop
 *	
 *	main function for muzzle reload eventhandler
 *
*/


params ["_unit", "_weapon", "_muzzle", "_newmag", ["_oldmag", ["","","",""]]];

/*

/// debug stuff for muzzle 'reload' EH (uses same params as 'reloaded' EH for objects)
hint format ["
	Weapon: %1\n
	Muzzle: %2\n\n
	- New Magazine -\n
	Name: %3\n
	Ammo: %4\n
	ID: %5\n
	Creator: %6\n\n
	- Old Magazine -\n
	Name: %7\n
	Ammo: %8\n
	ID: %9\n
	Creator: %10 \n
	UNIT: %11

	", 
	_weapon, 
	_muzzle, 
	_newmag select 0, 
	_newmag select 1, 
	///The magazine ID number is normally > 10,000,000, so due to the number to string conversion limitation it would always show as 1e+007 in hint. 
	(_newmag select 2) - 1e+007, 
	///In order to be able to see the changing ID number, subtract this amount from the returned ID. 
	_newmag select 3,
	_oldmag select 0, 
	_oldmag select 1, 
	if (_oldmag select 2 isEqualType "") then {""} else {(_oldmag select 2) - 1e+007}, 
	_oldmag select 3,
	_unit
];

*/

/// Do nothing If clip being pulled out still have bullets in it
if !(_oldmag#1 isEqualTo 0) exitWith{};

/// Get unit (Soldier's) velocity and add some randomization
private _addVelocity = (velocity _unit vectorAdd [-0.2 + random 0.5, -0.2 + random 0.5, -0.2 + random 0.5]) vectorMultiply (1 + random 0.2);

/// See if magCfg has 'A3 PROXY MAGAZINE' support to choose model, use generic model if it doesn't
private _getMagazineP3D = if (getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "model") isEqualTo "\A3\weapons_F\ammo\mag_univ.p3d") then 
{
	"\A3\Structures_F_EPB\Items\Military\Magazine_rifle_F.p3d"
} else {
	getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "model")
};

private _getDirectionAndUpVector = surfaceNormal position _unit;

/// Store or update magazine model name in object namespace variable
_unit setVariable ["GokoMD_VAR_magazineModelNamePistol",_getMagazineP3D];

/// store or update surface normal vector
_unit setVariable ["GokoMD_VAR_surfaceNormalVector",_getDirectionAndUpVector];



[_unit, _addVelocity, _getMagazineP3D] remoteExecCall ["GokoMD_fnc_Pistol_Particle3DFx"];
/// TODO: add some delay using CBA_WaitAndExecute

/// TODO: Pass params / call SoundSimulation function using CBA_WaE


systemchat format ["current magazine model name: %1 \n current normal vector: %2", _getMagazineP3D, _getDirectionAndUpVector];
