// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)
list b;list x;list u;integer l;key A="00000000-0000-0000-0000-000000000000";integer B;
C(string q,list c){integer r;list j;integer e;string y;list f=["1","2","3","4","5","6","7","8","9"];integer v;integer i;integer n;string p;key w="";r=c!=[];j=llParseString2List(q,(list)"|",[]);if (1<(j!=[])){w=llList2Key(j,1);}v=llListFindList(b,(list)llList2String(j,0));if (~v){p=llList2String(x,v);j=llParseStringKeepNulls(p,(list)"&",[]);e=j!=[];p=llList2String(j,0);for(v=1;v<e;++v){y=llList2String(j,v);n=llStringLength(y);if (0<n){i=llListFindList(f,(list)llGetSubString(y,0,0));if (~i){if (i<r){if (1<n){p=p+(llList2String(c,i)+llGetSubString(y,1,-1));}else{p=p+llList2String(c,i);}}else{p=p+("(missing parameter number "+(string)i+") &"+y);}}else{p=p+("&"+y);}}}if (w==""){llOwnerSay(p);}else{llInstantMessage(w,p);}}else{llOwnerSay("Error - unknown error message code:"+q);}}
default{
state_entry(){if (llGetInventoryType("~FSErrors")^7){llOwnerSay("Error message configuration notecard '~FSErrors' is missing - many error messages will not make any sense.");}else{B=1;A=llGetNotecardLine("~FSErrors",l);}}
changed(integer m){if (m&128)llResetScript();}
link_message(integer k,integer s,string o,key g){if ((!s)&o=="RESET"){llResetScript();}if (s==12123405){if (B){u=u+(o+"|"+(string)g);}else{C(o,llParseString2List((string)g,(list)"|",[]));}}}
dataserver(key d,string z){list h;if (d==A){if (z=="\n\n\n"){B=0;if (u!=[]){integer t;string a;for(t=0;t<(u!=[]);++t){h=llParseString2List(llList2String(u,t),(list)"|",[]);a=llList2String(h,0);h=llDeleteSubList(h,0,0);C(a,h);}}}else{h=llParseStringKeepNulls(z,(list)" ",[]);if (0<(h!=[])){b=b+llList2String(h,0);h=llDeleteSubList(h,0,0);x=x+llDumpList2String(h," ");++l;A=llGetNotecardLine("~FSErrors",l);}}}}
}
// lsl script: ~FSLanguage  optimized at:Thu Sep  5 21:04:51 2019
