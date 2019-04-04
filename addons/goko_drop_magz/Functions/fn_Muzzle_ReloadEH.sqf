/* 
 *	Goko Mag Drop add-on v1.22c for ARMA3
 *	Author: gökmen 'the0utsider' çakal
 *	Repo: github.com/the0utsider/mag-drop
 *
 *	Main function for muzzle reload eventhandler
 *	Passes arguements to particle system (_particle3dFx.sqf)
*/

params ["_unit", "_weapon", "_muzzle", "_newmag", ["_oldmag", ["","","",""]]];

/// Do nothing If clip being pulled out still have bullets in it
if !(_oldmag#1 isEqualTo 0) exitWith{};

/// See if mag belongs to RHS and use individual model. if not use generic model 
private _bMagtypeIsRHS = (getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "author") == "Red Hammer Studios");
private _getMagazineP3D = if (_bMagtypeIsRHS) then
{
	private _rhsMagString = getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "model");
	private _addExtension = ".p3d";
	[_rhsMagString, _addExtension] joinString "";
} else {
	"\A3\Structures_F_EPB\Items\Military\Magazine_rifle_F.p3d";
};

/// Store or update magazine model name in object's namespace variable
_unit setVariable ["GokoMD_VAR_magazineModelNamePistol",_getMagazineP3D];

[
	{	
		params ["_unit", "_magconfigclass"];

		private _addVelocity = (velocity _unit vectorMultiply 1.1) vectorAdd [-0.4 + random 0.8, -0.4 + random 0.8, 0];
		private _existingParticleFxCount = {typeOf _x == "#particleSource"} count attachedObjects _unit;

		[_unit, _addVelocity, _magconfigclass, _existingParticleFxCount] remoteExecCall ["GokoMD_fnc_Pistol_Particle3DFx"];
	}, [_unit, _getMagazineP3D], (0.3 + (random 0.3))
] call CBA_fnc_waitAndExecute;


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