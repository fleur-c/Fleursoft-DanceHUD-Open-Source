// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

h(string c){llOwnerSay(c+" is a Fleursoft DanceHUD product only feature. To enable both Update and Transfer buy the Fleursoft DanceHUD");}
default{
state_entry(){llOwnerSay("Fleursoft DanceHUD OpenSource revision:1.5");}
changed(integer a){if (a&128)llResetScript();}
link_message(integer d,integer g,string f,key b){if (12123421==g){h("Transfer");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123431==g){h("Update");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123433==g){if (f=="show"){string e=llGetEnv("sim_version");llOwnerSay("Simulation version: "+e);llOwnerSay("Fleursoft DanceHUD OpenSource 1.5");return;}}if ((!g)&f=="RESET")llResetScript();}
}
// lsl script: ~FSProduct  optimized at:Fri Sep 13 15:20:36 2019
