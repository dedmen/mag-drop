/* 
 *	Goko Magazine Simulation A3 add-on v1.23d for ARMA3 STEAM DEV BRANCH
 *	Author: cgökmen 'the0utsider'
 *	Repo: github.com/the0utsider/mag-drop
 *
*/

class CfgFunctions
{
	class Goko_Magazine_Simulation
	{
		tag = "GokoMS";
		class particle
		{
			file = "goko_drop_magz\functions";
			class Magazine_Particle3DFx {};
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
