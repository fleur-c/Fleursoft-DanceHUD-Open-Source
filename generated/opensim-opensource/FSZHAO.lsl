
// ZHAO-II-core - Ziggy Puff, 07/07

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Main engine script - receives link messages from any interface script. Handles the core AO work
//
// Interface definition: The following link_message commands are handled by this script. All of 
// these are sent in the string field. All other fields are ignored
//
// ZHAO_RESET                          Reset script
// ZHAO_LOAD|<notecardName>            Load specified notecard
// ZHAO_NEXTSTAND                      Switch to next stand
// ZHAO_STANDTIME|<time>               Time between stands. Specified in seconds, expects an integer.
//                                     0 turns it off
// ZHAO_AOON                           AO On
// ZHAO_AOOFF                          AO Off
// ZHAO_SITON                          Sit On
// ZHAO_SITOFF                         Sit Off
// ZHAO_RANDOMSTANDS                   Stands cycle randomly
// ZHAO_SEQUENTIALSTANDS               Stands cycle sequentially
// ZHAO_SETTINGS                       Prints status
// ZHAO_SITS                           Select a sit
// ZHAO_GROUNDSITS                     Select a ground sit
// ZHAO_WALKS                          Select a walk
//
// So, to send a command to the ZHAO-II engine, send a linked message:
//
//   llMessageLinked(LINK_SET, 0, "ZHAO_AOON", NULL_KEY);
//
// This script uses a listener on channel -91234. If other scripts are added to the ZHAO, make sure 
// they don't use the same channel
/////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////
// New notecard format
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Lines starting with a / are treated as comments and ignored. Blank lines are ignored. Valid lines 
// look like this:
//
// [ Walking ]SexyWalk1|SexyWalk2|SexyWalk3
//
// The token (in this case, [ Walking ]) identifies the animation to be overridden. The rest is a 
// list of animations, separated by the '|' (pipe) character. You can specify multiple animations 
// for Stands, Walks, Sits, and GroundSits. Multiple animations on any other line will be ignored. 
// You can have up to 12 animations each for Walks, Sits and GroundSits. There is no hard limit 
// on the number of stands, but adding too many stands will make the script run out of memory and 
// crash, so be careful. You can repeat tokens, so you can split the Stands up across multiple lines. 
// Use the [ Standing ] token in each line, and the script will add the animation lists together.
//
// Advanced: Each 'animation name' can be a comma-separated list of animations, which will be played 
// together. For example:
//
// [ Walking ]SexyWalk1UpperBody,SexyWalk1LowerBody|SexyWalk2|SexyWalk3
//
// Note the ',' between SexyWalk1UpperBody and SexyWalk1LowerBody - this tells ZHAO-II to treat these 
// as a single 'animation' and play them together. The '|' between this 'animation' and SexyWalk2 tells 
// ZHAO-II to treat SexyWalk2 and SexyWalk3 as separate walk animations. You can use this to layer 
// animations on top of each other.
//
// Do not add any spaces around animation names!!!
//
// The token can be one of the following:
//
// [ Standing ]
// [ Walking ]
// [ Sitting ]
// [ Sitting On Ground ]
// [ Crouching ]
// [ Crouch Walking ]
// [ Landing ]
// [ Standing Up ]
// [ Falling ]
// [ Flying Down ]
// [ Flying Up ]
// [ Flying ]
// [ Flying Slow ]
// [ Hovering ]
// [ Jumping ]
// [ Pre Jumping ]
// [ Running ]
// [ Turning Right ]
// [ Turning Left ]
// [ Floating ]
// [ Swimming Forward ]
// [ Swimming Up ]
// [ Swimming Down ]
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

// Fleur, 04/22/17 - Changes to support fleursoft dancehud
//                 - Removed dialog/listen - using DanceHUD UI instead and messages

// Ziggy, 07/16/07 - Warning instead of error on 'no animation in inventory', that way SL's built-in
//                   anims can be used
//
// Ziggy, 07/14/07 - 2 bug fixes. Listens aren't being reset on owner change, and a typo in the 
//                   ground sit animation code
//
// Ziggy, 06/07:
//          Reduce script count, since idle scripts take up scheduler time
//          Tokenize notecard reader, to simplify notecard setup
//          Remove scripted texture changes, to simplify customization by animation sellers

// Fennec Wind, January 18th, 2007:
//          Changed Walk/Sit/Ground Sit dialogs to show animation name (or partial name if too long) 
//          and only show buttons for non-blank entries.
//          Fixed minor bug in the state_entry, ground sits were not being initialized.
//

// Dzonatas Sol, 09/06: Fixed forward walk override (same as previous backward walk fix). 


// Based on Francis Chung's Franimation Overrider v1.8

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA.
string defaultNoteCard = "Default";


list animState = [ "Sitting on Ground", "Sitting", "Striding", "Crouching", "CrouchWalking",
                   "Soft Landing", "Standing Up", "Falling Down", "Hovering Down", "Hovering Up",
                   "FlyingSlow", "Flying", "Hovering", "Jumping", "PreJumping", "Running",
                   "Turning Right", "Turning Left", "Walking", "Landing", "Standing" ];





list autoDisableList = [
    "3147d815-6338-b932-f011-16b56d9ac18b",
    "ea633413-8006-180a-c3ba-96dd1d756720",
    "b5b4a67d-0aee-30d2-72cd-77b333e932ef",
    "46bb4359-de38-4ed8-6a22-f1f52fe8f506",
    "9a728b41-4ba0-4729-4db7-14bc3d3df741",
    "f3300ad9-3462-1d07-2044-0fef80062da0",
    "c8e42d32-7310-6906-c903-cab5d4a34656",
    "85428680-6bf9-3e64-b489-6f81087c24bd",
    "eefc79be-daae-a239-8c04-890f5d23654a"
];
list tokens = [
    "[ Sitting On Ground ]",
    "[ Sitting ]",
    "",
    "[ Crouching ]",
    "[ Crouch Walking ]",
    "",
    "[ Standing Up ]",
    "[ Falling ]",
    "[ Flying Down ]",
    "[ Flying Up ]",
    "[ Flying Slow ]",
    "[ Flying ]",
    "[ Hovering ]",
    "[ Jumping ]",
    "[ Pre Jumping ]",
    "[ Running ]",
    "[ Turning Right ]",
    "[ Turning Left ]",
    "[ Walking ]",
    "[ Landing ]",
    "[ Standing ]",
    "[ Swimming Down ]",
    "[ Swimming Up ]",
    "[ Swimming Forward ]",
    "[ Floating ]"
];


list multiAnimTokenIndexes = [
    0,
    1,
    18,
    20
];


integer noAnimIndex = -1;
integer sitgroundIndex = 0;
integer sittingIndex = 1;
integer stridingIndex = 2;
integer standingupIndex = 6;
integer hoverdownIndex = 8;
integer hoverupIndex = 9;
integer flyingslowIndex = 10;
integer flyingIndex = 11;
integer hoverIndex = 12;
integer walkingIndex = 18;
integer standingIndex = 20;
integer swimdownIndex = 21;
integer swimupIndex = 22;
integer swimmingIndex = 23;
integer waterTreadIndex = 24;


list underwaterAnim;


list underwaterOverride;






list autoStop = [ 5, 6, 19 ];

float autoStopTime = 1.5;


integer standTimeDefault = 30;



float timerEventLength = 0.25;




float minEventDelay = 0.25;


key typingAnim = "c541c47f-e0c0-058b-ad1a-d6ae3a4584d9";




integer listenChannel = -91234;




integer numStands;
integer randomStands = FALSE;
integer curStandIndex;
string curStandAnim = "";
string curSitAnim = "";
string curWalkAnim = "";
string curGsitAnim = "";

list overrides = [];
key notecardLineKey;
integer notecardIndex;
integer numOverrides;

string lastAnim = "";
string lastAnimSet = "";
integer lastAnimIndex = 0;
string lastAnimState = "";

integer standTime = 30;

integer animOverrideOn = FALSE;
integer gotPermission = FALSE;

integer listenHandle;

integer haveWalkingAnim = FALSE;

integer sitOverride = TRUE;

integer listenState = 0;

integer loadInProgress = FALSE;
string notecardName = "";

key Owner = NULL_KEY;


string EMPTY = "";
string SEPARATOR = "|";
string TRYAGAIN = "Please correct the notecard and try again.";





integer hasIntersection( list _list1, list _list2 ) {
    list bigList;
    list smallList;
    integer smallListLength;
    integer i;

    if ( llGetListLength( _list1 ) <= llGetListLength( _list2 ) ) {
        smallList = _list1;
        bigList = _list2;
    }
    else {
        bigList = _list1;
        smallList = _list2;
    }
    smallListLength = llGetListLength( smallList );

    for ( i=0; i<smallListLength; i++ ) {
        if ( llListFindList( bigList, llList2List(smallList,i,i) ) != -1 ) {
            return TRUE;
        }
    }

    return FALSE;
}

startAnimationList( string _csvAnims ) {
    list anims = llCSV2List( _csvAnims );
    integer i;
    for( i=0; i<llGetListLength(anims); i++ )
        llStartAnimation( llList2String(anims,i) );
}

stopAnimationList( string _csvAnims ) {
    list anims = llCSV2List( _csvAnims );
    integer i;
    for( i=0; i<llGetListLength(anims); i++ )
        llStopAnimation( llList2String(anims,i) );
}

startNewAnimation( string _anim, integer _animIndex, string _state ) {
    if ( _anim != lastAnimSet ) {
        string newAnim;
        if ( lastAnim != EMPTY )
            stopAnimationList( lastAnim );
        if ( _anim != EMPTY ) {
             list newAnimSet = llParseStringKeepNulls( _anim, [SEPARATOR], [] );
             newAnim = llList2String( newAnimSet, (integer)llFloor(llFrand(llGetListLength(newAnimSet))) );

             startAnimationList( newAnim );

            if ( llListFindList( autoStop, [_animIndex] ) != -1 ) {




                if ( lastAnim != EMPTY ) {
                   stopAnimationList( lastAnim );
                   lastAnim = EMPTY;
                }
                llSleep( autoStopTime );
                stopAnimationList( _anim );
            }
        }
        lastAnim = newAnim;
        lastAnimSet = _anim;
    }
    lastAnimIndex = _animIndex;
    lastAnimState = _state;
}


animOverride() {
    string curAnimState = llGetAnimation( Owner );
    integer curAnimIndex;
    integer underwaterAnimIndex;


    if ( curAnimState == "Striding" ) {
        curAnimState = "Walking";
    }
    else
    {
        if ( curAnimState == "Soft Landing" ) {
            curAnimState = "Landing";
        }
    }




    if ( curAnimState == "CrouchWalking" ) {
      if ( llVecMag(llGetVel()) < .5 )
         curAnimState = "Crouching";
    }

    if ( curAnimState == lastAnimState ) {





        return;
    }

    curAnimIndex = llListFindList( animState, [curAnimState] );
    underwaterAnimIndex = llListFindList( underwaterAnim, [curAnimIndex] );




    if ( curAnimIndex == standingIndex ) {
        startNewAnimation( curStandAnim, standingIndex, curAnimState );
    }
    else
    {
        if ( curAnimIndex == sittingIndex )
        {

            if (( sitOverride == FALSE ) && ( curAnimState == "Sitting" )) {
                startNewAnimation( EMPTY, noAnimIndex, curAnimState );
            }
            else {
                startNewAnimation( curSitAnim, sittingIndex, curAnimState );
            }
        }
        else
        {
            if ( curAnimIndex == walkingIndex )
            {
                startNewAnimation( curWalkAnim, walkingIndex, curAnimState );
            }
            else
            {
                if ( curAnimIndex == sitgroundIndex )
                {
                    startNewAnimation( curGsitAnim, sitgroundIndex, curAnimState );
                }
                else
                {
                    if ( underwaterAnimIndex != -1 )
                    {

                        vector curPos = llGetPos();
                        if ( llWater(ZERO_VECTOR) > curPos.z ) {
                            curAnimIndex = llList2Integer( underwaterOverride, underwaterAnimIndex );
                        }
                    }
                }
            }
        }
    }
    startNewAnimation( llList2String(overrides, curAnimIndex), curAnimIndex, curAnimState );
}


doNextStand(integer fromUI) {
    if ( numStands > 0 ) {
        if ( randomStands ) {
            curStandIndex = llFloor( llFrand(numStands) );
        } else {
            curStandIndex = (curStandIndex + 1) % numStands;
        }

        curStandAnim = findMultiAnim( standingIndex, curStandIndex );
        if ( lastAnimState == "Standing" )
            startNewAnimation( curStandAnim, standingIndex, lastAnimState );

        if ( fromUI == TRUE ) {
            llOwnerSay( "Switching to stand '" + curStandAnim + "'." );
        }
    } else {
        if ( fromUI == TRUE ) {
            llOwnerSay( "No stand animations configured." );
        }
    }

    llResetTime();
}


doMultiAnimMenu( integer _animIndex, string _animType, string _currentAnim )
{



    list anims = llParseString2List( llList2String(overrides, _animIndex), [SEPARATOR], [] );
    integer numAnims = llGetListLength( anims );
    if ( numAnims > 12 ) {
        llOwnerSay( "Too many animations, cannot generate menu. " + TRYAGAIN );
        return;
    }

    list buttons = [];
    integer i;
    string animNames = EMPTY;
    for ( i=0; i<numAnims; i++ ) {
        animNames += "\n" + (string)(i+1) + ". " + llList2String( anims, i );
        buttons += [(string)(i+1)];
    }

    if ( animNames == EMPTY ) {
        animNames = "\n\nNo overrides have been configured.";
    }

    llMessageLinked(LINK_THIS, 12123408 , llDumpList2String(["ITEMS",_animType,numAnims,0, 0 , 12123419 ],"|"), animNames) ;
}


string findMultiAnim( integer _animIndex, integer _multiAnimIndex )
{
    list animsList = llParseString2List( llList2String(overrides, _animIndex), [SEPARATOR], [] );
    return llList2String( animsList, _multiAnimIndex );
}


checkMultiAnim( integer _animIndex, string _animName )
{
    list animsList = llParseString2List( llList2String(overrides, _animIndex), [SEPARATOR], [] );
    if ( llGetListLength(animsList) > 12 )
        llOwnerSay( "You have more than 12 " + _animName + " animations. Please correct this." );
}

checkAnimInInventory( string _csvAnims )
{
    list anims = llCSV2List( _csvAnims );
    integer i;
    for( i=0; i<llGetListLength(anims); i++ ) {
        string animName = llList2String( anims, i );
        if ( llGetInventoryType( animName ) != INVENTORY_ANIMATION ) {

            llOwnerSay( "Warning: Couldn't find animation '" + animName + "' in inventory." );
        }
    }
}


printFreeMemory()
{
    float memory = (float)llGetFreeMemory() * 100.0 / 65536.0;
    llOwnerSay( (string)((integer)memory) + "% memory free" );
}


integer checkAndOverride() {
    if ( animOverrideOn && gotPermission ) {

        if ( hasIntersection( autoDisableList, llGetAnimationList(Owner) ) ) {
            startNewAnimation( EMPTY, noAnimIndex, EMPTY );
            return FALSE;
        }

        animOverride();
        return TRUE;
    }

    return FALSE;
}


loadNoteCard() {

    if ( llGetInventoryKey(notecardName) == NULL_KEY ) {

        loadInProgress = FALSE;
        notecardName = EMPTY;
        return;
    }

    llOwnerSay( "Loading AO notecard '" + notecardName + "'..." );





    overrides = [];
    integer i;
    for ( i=0; i<numOverrides; i++ )
        overrides += [EMPTY];



    curStandIndex = 0;
    curStandAnim = EMPTY;
    curSitAnim = EMPTY;
    curWalkAnim = EMPTY;
    curGsitAnim = EMPTY;


    notecardIndex = 0;
    notecardLineKey = llGetNotecardLine( notecardName, notecardIndex );
}


endNotecardLoad()
{

    llMessageLinked(LINK_THIS, 12123410 , (string) 112 + "|" + notecardName, "") ;

    loadInProgress = FALSE;
    notecardName = EMPTY;



}


initialize() {
    Owner = llGetOwner();

    if ( animOverrideOn )
        llSetTimerEvent( timerEventLength );
    else
        llSetTimerEvent( 0 );

    lastAnim = EMPTY;
    lastAnimSet = EMPTY;
    lastAnimIndex = noAnimIndex;
    lastAnimState = EMPTY;
    gotPermission = FALSE;
}




default {
    state_entry() {
        underwaterAnim = [ hoverIndex, flyingIndex, flyingslowIndex, hoverupIndex, hoverdownIndex ];

        underwaterOverride = [ waterTreadIndex, swimmingIndex, swimmingIndex, swimupIndex, swimdownIndex];

        integer i;

        Owner = llGetOwner();
        if ( llGetAttached() )
            llRequestPermissions( llGetOwner(), PERMISSION_TRIGGER_ANIMATION|PERMISSION_TAKE_CONTROLS );

        numOverrides = llGetListLength( tokens );


        for ( i=0; i<llGetListLength(autoDisableList); i++ ) {
            key k = llList2Key( autoDisableList, i );
            autoDisableList = llListReplaceList ( autoDisableList, [ k ], i, i );
        }


        overrides = [];
        for ( i=0; i<numOverrides; i++ ) {
            overrides += [ EMPTY ];
        }
        randomStands = FALSE;
        initialize();
        notecardName = defaultNoteCard;




        if ( autoStopTime == 0 )
            autoStop = [];

        llResetTime();
    }

    on_rez( integer _code ) {
        initialize();
    }

    changed(integer change)
    {
        if (change & CHANGED_REGION)
        {
            if(llGetAttached())
                llRequestPermissions( llGetOwner(), PERMISSION_TRIGGER_ANIMATION|PERMISSION_TAKE_CONTROLS );
        }

        if (change & CHANGED_OWNER)
            llResetScript();
    }

    attach( key _k ) {
        if ( _k != NULL_KEY )
            llRequestPermissions( llGetOwner(), PERMISSION_TRIGGER_ANIMATION|PERMISSION_TAKE_CONTROLS );
    }

    run_time_permissions( integer _perm ) {
      if ( _perm != (PERMISSION_TRIGGER_ANIMATION|PERMISSION_TAKE_CONTROLS) )
         gotPermission = FALSE;
      else {
         llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );
         gotPermission = TRUE;
      }
    }

    link_message( integer _sender, integer _num, string _message, key _id) {



        if ((_num == 0) && ( _message == "RESET" ) || ( _message == "ZHAO_RESET" ))
        {
            llOwnerSay( "Resetting..." );
            llResetScript();

        }



        if ( 12123409  == _num)
        {

            if ( _message == "ZHAO_AOON" ) {

                llSetTimerEvent( timerEventLength );
                animOverrideOn = TRUE;
                checkAndOverride();

            } else if ( _message == "ZHAO_AOOFF" ) {
                llSetTimerEvent( 0 );
                animOverrideOn = FALSE;
                startNewAnimation( EMPTY, noAnimIndex, lastAnimState );
                lastAnim = EMPTY;
                lastAnimSet = EMPTY;
                lastAnimIndex = noAnimIndex;
                lastAnimState = EMPTY;

            } else if ( _message == "ZHAO_SITON" ) {

                sitOverride = TRUE;
                llOwnerSay( "Sit override: On" );
                if ( lastAnimState == "Sitting" )
                    startNewAnimation( curSitAnim, sittingIndex, lastAnimState );

            } else if ( _message == "ZHAO_SITOFF" ) {

                sitOverride = FALSE;
                llOwnerSay( "Sit override: Off" );
                if ( lastAnimState == "Sitting" )
                    startNewAnimation( EMPTY, noAnimIndex, lastAnimState );

            } else if ( _message == "ZHAO_RANDOMSTANDS" ) {

                randomStands = TRUE;
                llOwnerSay( "Stand cycling: Random" );

            } else if ( _message == "ZHAO_SEQUENTIALSTANDS" ) {

                randomStands = FALSE;
                llOwnerSay( "Stand cycling: Sequential" );

            } else if ( _message == "ZHAO_SETTINGS" ) {

                if ( sitOverride == TRUE ) {
                    llOwnerSay( "Sit override: On" );
                } else {
                    llOwnerSay( "Sit override: Off" );
                }
                if ( randomStands == TRUE ) {
                    llOwnerSay( "Stand cycling: Random" );
                } else {
                    llOwnerSay( "Stand cycling: Sequential" );
                }
                llOwnerSay( "Stand cycle time: " + (string)standTime + " seconds" );

            } else if ( _message == "ZHAO_NEXTSTAND" ) {


                doNextStand( TRUE );

            } else if ( llGetSubString(_message, 0, 14) == "ZHAO_STANDTIME|" ) {

                standTime = (integer)llGetSubString(_message, 15, -1);
                llOwnerSay( "Stand cycle time: " + (string)standTime + " seconds" );

            } else if ( llGetSubString(_message, 0, 9) == "ZHAO_LOAD|" ) {

                if ( loadInProgress == TRUE ) {
                    llOwnerSay( "Cannot load new notecard, still reading notecard '" + notecardName + "'" );
                    return;
                }


                loadInProgress = TRUE;
                notecardName = llGetSubString(_message, 10, -1);
                loadNoteCard();

            } else if ( _message == "ZHAO_SITS" ) {



                doMultiAnimMenu( sittingIndex, "Sitting", curSitAnim );

                listenState = 1;

            } else if ( _message == "ZHAO_WALKS" ) {



                doMultiAnimMenu( walkingIndex, "Walking", curWalkAnim );

                listenState = 2;
            } else if ( _message == "ZHAO_GROUNDSITS" ) {



                doMultiAnimMenu( sitgroundIndex, "Sitting On Ground", curGsitAnim );

                listenState = 3;
            }

    }


    if ( 12123419  == _num)
    {

        	list p = llParseString2List(_message, ["|"], []);

	        if ( listenState == 1 ) {


	            curSitAnim = findMultiAnim( sittingIndex, llList2Integer(p,1) );
	            if ( lastAnimState == "Sitting" ) {
	                startNewAnimation( curSitAnim, sittingIndex, lastAnimState );
	            }
	           llOwnerSay( "New sitting animation: " + curSitAnim );

	        } else if ( listenState == 2 ) {


	            curWalkAnim = findMultiAnim( walkingIndex, llList2Integer(p,1) );
	            if ( lastAnimState == "Walking" ) {
	                startNewAnimation( curWalkAnim, walkingIndex, lastAnimState );
	            }
	            llOwnerSay( "New walking animation: " + curWalkAnim );

	        } else if ( listenState == 3 ) {


	            curGsitAnim = findMultiAnim( sitgroundIndex,llList2Integer(p,1) );

	            if ( lastAnimState == "Sitting on Ground" || ( lastAnimState == "Standing" ) ) {
	                startNewAnimation( curGsitAnim, sitgroundIndex, lastAnimState );
	            }
	            llOwnerSay( "New sitting on ground animation: " + curGsitAnim );
	        }

	        llMessageLinked(LINK_THIS, 12123408 , (string) 2 , (string) 12123410 ) ;
        }

    }
    dataserver( key _query_id, string _data ) {

        if ( _query_id != notecardLineKey ) {
            endNotecardLoad();
            return;
        }

        if ( _data == EOF ) {





            if ( llList2String(overrides, walkingIndex) != EMPTY ) {
                 haveWalkingAnim = TRUE;
            }


            checkMultiAnim( walkingIndex, "walking" );
            checkMultiAnim( sittingIndex, "sitting" );
            checkMultiAnim( sitgroundIndex, "sitting on ground" );


            curStandIndex = 0;
            numStands = llGetListLength( llParseString2List(llList2String(overrides, standingIndex),
                                         [SEPARATOR], []) );

            curStandAnim = findMultiAnim( standingIndex, 0 );
            curWalkAnim = findMultiAnim( walkingIndex, 0 );
            curSitAnim = findMultiAnim( sittingIndex, 0 );
            curGsitAnim = findMultiAnim( sitgroundIndex, 0 );


            startNewAnimation( EMPTY, noAnimIndex, lastAnimState );
            lastAnim = EMPTY;
            lastAnimSet = EMPTY;
            lastAnimIndex = noAnimIndex;
            lastAnimState = EMPTY;

            llOwnerSay( "Finished reading AO notecard '" + notecardName + "'." );
            printFreeMemory();

            endNotecardLoad();
            return;
        }


        if (( _data == EMPTY ) || ( llGetSubString(_data, 0, 0) == "#" )) {
            notecardLineKey = llGetNotecardLine( notecardName, ++notecardIndex );
            return;
        }


        integer i;
        integer found = FALSE;
        for ( i=0; i<numOverrides; i++ ) {
            string token = llList2String( tokens, i );


            if (( token != EMPTY ) && ( llGetSubString( _data, 0, llStringLength(token) - 1 ) == token )) {


                found = TRUE;

                if ( _data != token ) {
                    string animPart = llGetSubString( _data, llStringLength(token), -1 );


                    if ( llListFindList( multiAnimTokenIndexes, [i] ) != -1 ) {
                        list anims2Add = llParseString2List( animPart, [SEPARATOR], [] );

                        integer j;
                        for ( j=0; j<llGetListLength(anims2Add); j++ ) {
                            checkAnimInInventory( llList2String(anims2Add,j) );
                        }


                        list currentAnimsList = llParseString2List( llList2String(overrides, i), [SEPARATOR], [] );
                        currentAnimsList += anims2Add;
                        overrides = llListReplaceList( overrides, [llDumpList2String(currentAnimsList, SEPARATOR)], i, i );
                    } else {

                        if ( llSubStringIndex( animPart, SEPARATOR ) != -1 ) {
                            llOwnerSay( "Cannot have multiple animations for " + token + ". " + TRYAGAIN );

                            endNotecardLoad();
                            return;
                        }


                        checkAnimInInventory( animPart );


                        overrides = llListReplaceList( overrides, [animPart], i, i );
                    }
                }


                jump done;

            }
        }

        @done;

        if ( !found ) {
            llOwnerSay( "Could not recognize token on line " + (string)notecardIndex + ": " +
                        _data + ". " + TRYAGAIN );

            endNotecardLoad();
            return;
        }


        notecardLineKey = llGetNotecardLine( notecardName, ++notecardIndex );
        return;
    }

    collision_start( integer _num ) {
        checkAndOverride();
    }

    collision( integer _num ) {
        checkAndOverride();
    }

    collision_end( integer _num ) {
        checkAndOverride();
    }

    control( key _id, integer _level, integer _edge ) {
        if ( _edge ) {






            if ( llGetAnimation(Owner) == "Walking" ) {
                if ( _level & _edge & ( CONTROL_BACK | CONTROL_FWD ) ) {
                    if ( haveWalkingAnim ) {
                        llStopAnimation( "walk" );
                        llStopAnimation( "female_walk" );
                    }
                }
            }

            checkAndOverride();
            }
        }

    timer() {
        if ( checkAndOverride() ) {


            if ( (standTime != 0) && (llGetTime() > standTime) ) {


                if ( llListFindList(llGetAnimationList(Owner), [typingAnim]) == -1 )
                    doNextStand( FALSE );
            }
        }
    }
}
