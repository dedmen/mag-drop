class CfgWeapons
{
	class riflecore;
	class rifle: riflecore
	{
		class eventhandlers
		{
			class gokomd_riflekind
			{
				reload		= "_this call GokoMD_fnc_Pistol_MuzzleReloadEH";
			};
		};
	};
	class pistolcore;
	class pistol: pistolcore
	{
		class eventhandlers
		{
			class gokomd_pistolkind
			{
				reload		= "_this call GokoMD_fnc_Pistol_MuzzleReloadEH";
			};
		};
	};
};