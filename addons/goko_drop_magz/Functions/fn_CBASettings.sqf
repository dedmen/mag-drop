/* 
 *	Goko Mag Drop add-on v1.22c for ARMA3 DEV v1.92x (implement CBA & Muzzle Reload EH)
 *	Author: gökmen 'the0utsider' çakal
 *	latest update: 03-29-2019
 *	website: https://github.com/the0utsider/mag-drop
 *	
 *	CBA options config
 *
*/

GokoMD_VAR_particleLifeTime = profileNamespace getVariable ["GokoMD_VAR_particleLifeTime",900];

[
	"GokoMD_VAR_particleLifeTime",
	"LIST",
	["Magazines Lifetime","How long particle simulation lasts (DEFAULT: 15 Minutes)"],
	"Goko Magazine Options",
	[[60,300,900,1800,3600,7200],["A minute","5 Minutes","15 Minutes","30 Minutes","1 Hour","2 Hours"],2],
	true
] call CBA_Settings_fnc_init;
