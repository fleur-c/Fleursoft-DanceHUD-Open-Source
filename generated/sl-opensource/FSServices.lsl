// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)
list l=["ALL","FEMALE","MALE","LEAD","LEFT","CENTER","RIGHT","GROUP1","GROUP2","GROUP3","GROUP4","GROUP5"];list I=[1,2,4,8,16,32,64,128,256,512,1024,2048];list C=["|","ALIAS","DANCE","DELAY","DIALOG","END","GIVE","GROUP","IM","LOOP","MENU","MENUSTYLE","MESSAGE","MIX","NAME","NEXTSEQUENCE","OWNER_SAY","RAND","RANDOM","REGION_SAY","REPEAT","SAY","SETNAME","SHOUT","STOP","STYLE","WHISPER","ZZZDEFER"];key T="00000000-0000-0000-0000-000000000000";integer p;integer M;integer S=-1;integer E=-1;integer W;integer V;list s;integer h;list m;integer O;integer y;list ae;
an(string af,list ah){llMessageLinked(-4,12123405,af,llDumpList2String(ah,"|"));}
ak(string k,integer i){integer c=llList2Integer(ae,0);string F;integer P;if (c==103){integer L=llList2Integer(ae,1);integer q=llList2Integer(ae,2);integer d=llList2Integer(ae,3);if (L<11&-1<L){if (11<L+d){d=-~(10+-L);}ae=(list)("#1 Back|"+(string)i+"|0");for(P=0;P<(~-d);++P){F="#"+(string)(-~-~(P+L))+" Menu "+(string)(-~P)+"|"+(string)i+"|"+(string)(-~P);ae=ae+F;}F=llDumpList2String(ae,"|||");integer t;if (M&-(12123418==i)){t=-305410560+M;}if (!(W|12123427^i)){t=-305410560+W;}if (t){llMessageLinked(-4,q,llDumpList2String(["ITEMS",k,11,L,0,i,t],"|"),F);}else{llMessageLinked(-4,q,llDumpList2String(["ITEMS",k,11,L,0,i],"|"),F);}ae=[];F="";return;}else{llMessageLinked(-4,q,llDumpList2String(["ITEMS",k,10,0,0,i],"|"),"");}}if (c==51){c=llList2Integer(ae,1);if (-1<c&c<11){if (0<c){if (12123417==i){llMessageLinked(-4,305410560+c,"107","");}if (12123418==i){M=305410560+c;S=-1;E=-1;llMessageLinked(-4,M,"103|-1|12123418|10000","");}if (12123422==i){p=305410560+c;llMessageLinked(-4,12123408,"2","12123423");return;}if (12123423==i){if (305410560+c==p){an("MMSG009",[-305410560+p,c]);llMessageLinked(-4,12123408,"2","12123423");return;}llMessageLinked(-4,p,"109",(string)(305410560+c));llMessageLinked(-4,12123408,"2","12123412");return;}if (12123427==i){P=305410560+c;llMessageLinked(-4,12123408,"18",(string)P);llMessageLinked(-4,12123412,"115|"+(string)P,"");W=P;llMessageLinked(-4,12123408,"2","12123412");return;}}else{llMessageLinked(-4,12123408,"2","12123412");}}else{an("DCMSG007",(list)llList2String(ae,1));llMessageLinked(-4,12123408,"2","12123412");}return;}if (i==12123418&llList2String(ae,0)=="ITEMS"){F=llList2String(ae,1);if (0<llList2Integer(ae,2)){S=0;E=llList2Integer(ae,2);an("WMSG002",[F,E]);llMessageLinked(-4,12123408,"2","12123412");return;}M=0;an("WMSG001",[F,"stand_1"]);llMessageLinked(-4,12123408,"2","12123412");}}
al(integer H){integer aj;integer o=llGetAttached();if (o==V&(!H)){return;}if (!o){an("MMSG010",["DanceHUD",llGetObjectName()]);return;}V=o;integer R=llListFindList([35,31,34,33,32,36,37,38],(list)o);if (!~R){return;}float w;float U;list ag;vector Y;for(aj=1;aj<llGetNumberOfPrims()&w==0.;++aj){if ("None,HScroll"==llGetLinkName(-~aj)){ag=llGetLinkPrimitiveParams(-~aj,[7,6]);Y=llList2Vector(ag,1);Y=Y-llGetRootPosition();w=Y.z;Y=llList2Vector(ag,0);w=w+-Y.z;U=Y.y/2;}}if (w<0.){w=-w;}w=0.025+w;float n=llList2Float([1+-(U+U),-1+(U+U),-U,0.,U,-U,0.,U],R);float J=llList2Float([w/2,w/2,-0.045,-0.025,-0.025,w,w,w],R);vector B=<0.,n,J>;llSetLinkPrimitiveParamsFast(-4,[6,B]);}
ao(string f){integer j;integer ab;ab=llStringLength(f);if (1000<ab){for(j=0;j<ab;j=1000+j){if (1023+j<ab){llOwnerSay(llGetSubString(f,j,999+j)+"\\");}else{llOwnerSay(llGetSubString(f,j,-1));}}}else llOwnerSay(f);}
am(string a){integer X;integer K;integer N;string Q;list v;integer D;list z;K=m!=[];z=[];for(X=0;X<K;++X){v=llParseString2List(llList2String(m,X),(list)"|",[]);D=llList2Integer(v,0);N=llListFindList([2,3],(list)D);if (~N){if (~-N){if (v!=[]^2){Q=llList2String(v,1)+"(group="+llList2String("Unknown"+l,-~llListFindList(I,(list)llList2Integer(v,2)))+llList2String(["","",", start",", stop"],-~llList2Integer(v,3))+", dance index="+(string)llList2Integer(v,4)+")";z=z+Q;}else{z=z+llList2String(v,1);}}else{Q=llList2String(v,1);z=z+(llGetSubString(Q,0,-2)+"."+llGetSubString(Q,-1,-1));}}else{if (~llListFindList([4,8,11,14,15,16,22,25],(list)D)){z=z+("["+llList2String(C,D)+"]"+llList2String(v,1));}else{if (~llListFindList([9,13,17,18],(list)D)){z=z+("["+llList2String(C,D)+" "+llList2String(v,1)+"]");}else{if (~llListFindList([1,7,10,12,19,21,23,26],(list)D)){z=z+("["+llList2String(C,D)+" "+llList2String(v,1)+"]"+llList2String(v,2));}else{z=z+("["+llList2String(C,D)+"]");}}}}}ao(a+llDumpList2String(z,"|"));}
default{
state_entry(){T=llGetOwner();}
changed(integer G){if (G&128)llResetScript();}
link_message(integer aa,integer u,string ac,key x){ae=llParseString2List(ac,(list)"|",[]);if (12123417==u){ak("Select menu to clear",12123417);return;}if (12123418==u){ak("Select wait sequence menu",12123418);return;}if (12123422==u){ak("Copy dances/times from menu",12123422);return;}if (12123423==u){ak("Copy dances/times to menu",12123423);return;}if (12123427==u){ak("Select menu",12123427);return;}if (u==12123407){integer r=(integer)ac;if (!~-r){if (-(0<M)&(~S)){llMessageLinked(-4,M,"51|"+(string)S,"2");++S;if (!(S<E)){S=0;}}else{string e;e="2|stand_1|1|1|0|||3|3000|||20";llMessageLinked(-4,12123402,"WAITSEQ|Default wait|12123411",e);}return;}if (2==r){al(1);return;}if (3==r){W=(integer)((string)x);return;}}if (u==12123404){list A=llParseString2List(ac,(list)"|",[]);integer g=llList2Integer(A,0);if (!~-g){m=llParseString2List((string)x,(list)"|||",[]);am("Sequence: "+llList2String(A,1)+":");}if (g==2){O=1;llOwnerSay("Debug - started capturing debugging information");}if (g==3){O=0;llOwnerSay("Debug - stopped capturing debugging information");}if (g==4){y=1;llOwnerSay("Debug - started printing debug information");}if (g==5){y=0;llOwnerSay("Debug - stopped printing debug information");}if (g==6){integer ad;for(ad=0;ad<h;++ad){ao("FSD:"+llList2String(s,ad));}}return;}if (O){string ai=llDumpList2String([llGetTime(),u,ac,x],"@");s=s+ai;if (y){ao("FSD:"+ai);}++h;if (9<h){s=llDeleteSubList(s,0,0);--h;}}if ((!u)&ac=="RESET"){llResetScript();}}
attach(key Z){if (!(Z=="00000000-0000-0000-0000-000000000000")){if (!(T==llGetOwner()))llMessageLinked(-4,0,"RESET","");al(0);}}
on_rez(integer b){if (!(T==llGetOwner()))llMessageLinked(-4,0,"RESET","");}
}
// lsl script: ~FSServices  optimized at:Thu Sep  5 21:04:52 2019
