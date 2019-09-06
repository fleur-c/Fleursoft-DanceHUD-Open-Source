// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

g(string d){llOwnerSay(d+" is a Fleursoft DanceHUD product only feature. To enable both Update and Transfer buy the Fleursoft DanceHUD");}
default{
state_entry(){llOwnerSay("Fleursoft DanceHUD OpenSource revision:1.5");}
changed(integer b){if (b&128)llResetScript();}
link_message(integer f,integer e,string c,key a){if (12123421==e){g("Transfer");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123431==e){g("Update");llMessageLinked(-4,12123408,"2","12123412");return;}if (12123433==e){if (c=="show"){llOwnerSay("Fleursoft DanceHUD OpenSource 1.5");return;}}if ((!e)&c=="RESET")llResetScript();}
}
// lsl script: ~FSProduct  optimized at:Thu Sep  5 21:04:52 2019
