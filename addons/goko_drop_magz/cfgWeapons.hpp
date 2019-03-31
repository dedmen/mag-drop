class CfgWeapons
{
	class RifleCore;
	class Rifle: RifleCore
	{
		class EventHandlers
		{
			reload		= "_this call gokomd_fnc_debug";
		};
	};
	class PistolCore;
	class Pistol: PistolCore
	{
		class EventHandlers
		{
			reload		= "_this call GokoMD_fnc_Pistol_MuzzleReloadEH";
		};
	};
};
