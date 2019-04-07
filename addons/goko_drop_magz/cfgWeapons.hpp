/* 
 *	Goko Magazine Simulation A3 add-on v1.23d for ARMA3 STEAM DEV BRANCH
 *	Author: cgökmen 'the0utsider'
 *	Repo: github.com/the0utsider/mag-drop
 *
*/

class CfgWeapons
{
	class RifleCore;
	class Rifle : RifleCore 
	{
	    class Eventhandlers;
	};
	class Rifle_Base_F: Rifle 
	{
	    // inheriting Eventhandlers class for better modcross compatibility
	    class Eventhandlers: Eventhandlers 
	    {
	        reload = "systemchat format['fired EH output: %1 [time: %2]',_this, time]";
	    };
	};
	class PistolCore;
	class Pistol : PistolCore 
	{
	    class Eventhandlers;
	};
	class Pistol_Base_F: Pistol 
	{
	    // inheriting Eventhandlers class for better modcross compatibility
	    class Eventhandlers: Eventhandlers 
	    {
	        reload = "systemchat format['fired EH output: %1 [time: %2]',_this, time]";
	    };
	};
};