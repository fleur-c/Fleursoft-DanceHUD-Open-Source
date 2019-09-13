// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

h(string e){llOwnerSay(e+" is a Fleursoft DanceHUD product only feature. To enable both Update and Transfer buy the Fleursoft DanceHUD");}
default{
state_entry(){llOwnerSay("Fleursoft DanceHUD OpenSource revision:1.5");}
changed(integer d){if (d&128)llResetScript();}
link_message(integer g,integer c,string b,key a){if (12123421==c){h("Transfer");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123431==c){h("Update");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123433==c){if (b=="show"){string f=llGetEnv("sim_version");llOwnerSay("Simulation version: "+f);llOwnerSay("Fleursoft DanceHUD OpenSource 1.5");return;}}if ((!c)&b=="RESET")llResetScript();}
}
// lsl script: ~FSProduct  optimized at:Fri Sep 13 21:13:08 2019
