class CfgFunctions
{
	class Goko_MagDrop
	{
		tag = "GokoMD";
		class particle
		{
			file = "goko_drop_magz\functions";
			class Pistol_Particle3DFx {};
		};
		class eventhandler
		{
			file = "goko_drop_magz\functions";
			class Muzzle_ReloadEH {};
		};
		class audio
		{
			file = "goko_drop_magz\functions";
			class AudioSimulation {};
		};
	};
};