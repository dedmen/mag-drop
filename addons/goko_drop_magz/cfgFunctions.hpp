class CfgFunctions
{
	class Goko_MagDrop
	{
		tag = "GokoMD";
		class particle
		{
			file = "goko_drop_magz\functions";
			class Pistol_Particle3DFx {};
			class Rifle_Particle3DFx {};
		};
		class eventhandler
		{
			file = "goko_drop_magz\functions";
			class Pistol_MuzzleReloadEH {};
			class Rifle_MuzzleReloadEH {};
		};
		class init
		{
			file = "goko_drop_magz\functions";
			class CBASettings {};
			class postInit {};
			class preInit {preInit = 1;};
			class unitInit {};
		};
	};
};