/* 
 *	Goko Magazine Simulation A3 add-on v1.23d for ARMA3 STEAM DEV BRANCH
 *	Author: cgökmen 'the0utsider'
 *	Repo: github.com/the0utsider/mag-drop
 *
 *	Main function for muzzle reload eventhandler
 *	old/newmag sub params [name, ammo count (number), unique magazine ID, creator]
*/

params ["_unit", "_weapon", "_muzzle", "_newmag", ["_oldmag", ["","","",""]]];
systemchat "working";
/// Do nothing If clip being pulled out still have bullets in it
if !(_oldmag#1 isEqualTo 0) exitWith{};

/// velocity to pass on magazine: calculate forward vector of unit and bump it a little
private _unitVelocity =  velocity _unit;
private _unitDirection = direction _unit;
private _addVelocity = if (speed _unit isEqualTo 0) then {random 0.5 + random 0.5} else {0.5 + random 1};	
private _addVelocityForwardVector = 
[
	(velocity _unit # 0) + (sin _unitDirection * _addVelocity),
	(velocity _unit # 1) + (cos _unitDirection * _addVelocity),
	(velocity _unit # 2)
];
// add some randomization and finalize calculation
private _particleVelocity = ([0.8 - random 1.6, 0.8 - random 1.6, random 0.1] vectorAdd _addVelocityForwardVector);

/// magazine config check for p3d model
private _getMagazineCfgModelName = getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "model");
private _getMagazineCfgModelNameSpecial = getText(configfile >> "CfgMagazines" >> _oldmag#0 >> "modelSpecial");
// nameSpecial have detailed models but their Z orientation is 90degrees off, they stand straight on ground, don't look good.
private _getModel = if (_getMagazineCfgModelName isEqualTo "") then {_getMagazineCfgModelNameSpecial;} else {_getMagazineCfgModelName;};
private _foundMagazineP3D = "";
private _findIfP3D = _getModel splitString ".";

if ("p3d" in _findIfP3D) then
{
	switch _getModel do {
		case "\A3\weapons_F\ammo\mag_univ.p3d" : {_foundMagazineP3D = "\A3\Structures_F_EPB\Items\Military\Magazine_rifle_F.p3d"};
		case "" : {_foundMagazineP3D = "\A3\Structures_F_EPB\Items\Military\Magazine_rifle_F.p3d"};
		default { _foundMagazineP3D = _getModel };
	};
} else {
	_foundMagazineP3D = ([_getModel, "p3d"] joinString ".");
};

/// Store or update magazine model name in object's namespace variable, will be needed in SimpleObject script
_unit setVariable ["GokoMS_VAR_magazineModelName",_foundMagazineP3D];

/// count array, it will become index selector after incrementing attached objects array with particle Source
private _existingAttachedObjects = (count attachedObjects _unit);

/// pass params and exec particle function with delay
[{
	[
		_this#0,
		_this#1,
		_this#2,
		_this#3
	] remoteExecCall ["GokoMS_fnc_Magazine_Particle3DFx"];

}, [_unit, _particleVelocity, _foundMagazineP3D, _existingAttachedObjects], 0.3 + random 0.3] call CBA_fnc_waitAndExecute;


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