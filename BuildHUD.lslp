
// Script to build the Fleursoft DanceHUD OpenSource from cubes
//
// The order of creation of prims:
// 	0) Root prim = We add a texture here too - this is the REAL name of the object...
//	1) Menu prim (is where the menu name text appears) - we add a texture here (menu name)
//	2) MenuItem:1
//	3) MenuItem:2|MenuName
//	4) MenuItem:3|MenuText:1
//	5) MenuItem:4|MenuText:2
// ...
//  31) MenuItem:30|MenuText:28
//	32) MenuText:29 - blank (hidden scroll - works as as scroll, but no texture) - makes clicks easier
//	33) MenuText:30 - scroll buttons
//	34)  (nothing here) - blank (hidden scroll - works as scroll - but no texture) - makes clicks easier

list numberMenu = ["1.0,0.050,0.0,0.47",
"1.0,0.050,0.0,0.407",
"1.0,0.050,0.0,0.345",
"1.0,0.050,0.0,0.282",
"1.0,0.050,0.0,0.220",
"1.0,0.050,0.0,0.157",
"1.0,0.050,0.0,0.095",
"1.0,0.050,0.0,0.0325",
"1.0,0.050,0.0,-0.03",
"1.0,0.050,0.0,-0.093",
"1.0,0.050,0.0,-0.155",
"1.0,0.050,0.0,-0.218",
"1.0,0.050,0.0,-0.28"];

list modeMenu = ["1.0,0.025,0.0,-0.328",
"1.0,0.025,0.0,-0.359",
"1.0,0.025,0.0,-0.391"];

list scrollMenu = ["1.0,0.025,0.0,-0.422"];
list menuTitle = ["1.0,0.025,0.0,-0.454"];

integer frontSide = 4;
integer topSide = 0;
integer bottomSide = 5;



// Need to put these into another module and include it so that we can just draw the textures
// into the new cubes once we've created it all :-) No sense in doing this here AND in the
// hud - as changing themes is going to be part of it all...

float changedZ = 0.0144;	// Height of one prim or a line of hover text - for most all lines
float doubleHeight = 0.0288; // Height of two lines of hovertext (sigh 2*changedZ would be better...)
float fullWidth = 0.308;	// Width of 256 pixels on my system
vector gPrimSize = <0.0144, fullWidth, changedZ>;	// For the generic box prim
vector gPrimMenus = <0.0144, fullWidth, doubleHeight>;	// For the menu # box (2 lines)

 
integer gPrimNumber = 0;	// This is the index of the prim names
float gVerticalIndex = 0;	// How far have we moved vertically (on the setting of the prim details)
integer gWorking = FALSE;
vector black = <0.0, 0.0, 0.0>;
vector white = <1.0, 1.0, 1.0>;

// ## indicates a little prim (not sent to it's prim name) - every prim has a name
list primNames = [ "Top", "Mode", "Half", "Numbers",
    "Menu prim", "MenuItem:1", "MenuItem:2,MenuName", "MenuItem:3,MenuText:1",
	"MenuItem:4,MenuText:2", "MenuItem:5,MenuText:3", "MenuItem:6,MenuText:4", "MenuItem:7,MenuText:5", "MenuItem:8,MenuText:6",
	"MenuItem:9,MenuText:7", "MenuItem:10,MenuText:8", "MenuItem:11,MenuText:9", "MenuItem:12,MenuText:10", "MenuItem:13,MenuText:11",
	"MenuItem:14,MenuText:12", "MenuItem:15,MenuText:13", "MenuItem:16,MenuText:14", "MenuItem:17,MenuText:15", "MenuItem:18,MenuText:16",
	"MenuItem:19,MenuText:17", "MenuItem:20,MenuText:18", "MenuItem:21,MenuText:19", "MenuItem:22,MenuText:20", "MenuItem:23,MenuText:21",
	"MenuItem:24,MenuText:22", "MenuItem:25,MenuText:23", "MenuItem:26,MenuText:24", "MenuItem:27,MenuText:25", "MenuItem:28,MenuText:26",
	"MenuItem:29,MenuText:27", "MenuItem:30,MenuText:28", "MenuText:29,HScroll", "MenuText:30,Scroll", "None,HScroll" ];

	// list of kinds of names - these are used to calculate the next prim position
	// Note - the above primNames have to all be on this list so that we know how to vertically adjust and the
	//        adjustment will be in the verticalIncNumbers
list nameIndex = ["Top", "Mode", "Numbers", "Menu prim", "MenuItem", "MenuText", "Scroll", "None", "Half"];
	
	// list of increment for vertical/horozontal so we can calculate where the prim should go
list verticalIncNumbers = [1.0, 1.0, 1.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.5];
	// List of adjustments for horozontal of a prim - mostly only the mode, menu#'s and admin as they are not full width...


	// List of the things we expect to find inside the building cube :-)
	// One we need to leave inside, the other to cleanup when we are done
list inventoryItems = [ "~FS Theme Basic" ];
list cleanupInventoryItems = ["Cube" ];
integer cubeIndex = 0;	// Where is the cube we rez in the cleanup list


string texture = "~FS Theme Basic";
	// Name of the basic black and white themed texture


default
{
    state_entry()
    {
        llSetText("Click me to build the DanceHUD prims...", white, 1.);        
    }
 
    touch_start(integer num)
    {
    	integer i;
 
        if (gWorking)
            return;
 
        if (llDetectedKey(0) != llGetOwner())
            return;
 
 		for (i = 0; i<llGetListLength(inventoryItems); ++i)
 		{
	 		if (INVENTORY_NONE == llGetInventoryType(llList2String(inventoryItems, i)))
 			{
 				llOwnerSay("Error: I should contain an item called:"+llList2String(inventoryItems, i)+" - add it and try again...");
 				return;
 			}
 		}
 		for (i = 0; i<llGetListLength(cleanupInventoryItems); ++i)
 		{
	 		if (INVENTORY_NONE == llGetInventoryType(llList2String(cleanupInventoryItems, i)))
 			{
 				llOwnerSay("Error: I should contain an item called:"+llList2String(cleanupInventoryItems, i)+" - add it and try again...");
 				return;
 			}
 		}
 
        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
    }
 
    run_time_permissions(integer perm)
    {
        if (gWorking)
            return;
 
        if (perm & PERMISSION_CHANGE_LINKS)
        {
            gWorking = TRUE;
            llSetText("", white, 1.);
            llOwnerSay("Working on putting together the DanceHUD prims...");
            
            // Ok - start with us - the root prim... no hover text - texture on front and top
            //  And set the same texture on the top as the front (for rotating to show the lil prim)
            //  We set ALL sides black/transparent then the front/top - so we can see through them
            llSetLinkPrimitiveParamsFast(LINK_THIS, [
                PRIM_ROTATION, ZERO_ROTATION,
                PRIM_SIZE, gPrimSize,
                PRIM_FULLBRIGHT, ALL_SIDES, FALSE,
	            PRIM_COLOR, ALL_SIDES, black, 0.0,
                PRIM_COLOR, frontSide, white, 1.0,
				PRIM_TEXTURE, frontSide, texture, <1.0, 0.025, 0.0>, <0.0, -0.454, 0.0>, 0,
                PRIM_COLOR, topSide, white, 1.0,
				PRIM_TEXTURE, topSide, texture, <1.0, 0.025, 0.0>, <0.0, -0.454, 0.0>, -PI_BY_TWO
            ]);

            llSetObjectName("Fleursoft DanceHUD OpenSource");
            llSetObjectDesc("");	// Could set a rev number here - but it'll stay forever and we don't like that idea at all

			gPrimNumber++;
			gVerticalIndex = llList2Float(verticalIncNumbers, 0);
			llRezObject(llList2String(cleanupInventoryItems, cubeIndex), llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 0);
        }
    }
 
    object_rez(key id)
    {
    	string primName = llList2String(primNames, gPrimNumber);
    	list names = llParseString2List(primName, [":",","], []);
    	integer i;
    	vector adjustPos = <0.0, 0.0, 0.0>;
	
		integer index = llListFindList(nameIndex, [llList2String(names, 0)]);
		if (index == -1)
		{
			llOwnerSay("Programming error - the first prim name of prim "+(string)gPrimNumber+" isn't on my list - sigh - add it. I found:'"+primName+"'");
		}
		adjustPos.z = (-1.0) * gVerticalIndex * gPrimSize.z;
		float zChange = llList2Float(verticalIncNumbers, index);
		gVerticalIndex += zChange;

		// Generic handling gets us a good position and default size and color of black
		// BUT we make the front solid (alpha 1) and the other sides completely transparent (alpha 0)
		// this is so that when we rotate, if the theme sets an alpha texture, then it will shine through
		// all of the rest of the prims (it'll look a lil weird from the back - but no one looks there)
        llCreateLink(id, LINK_ROOT);
        llSetLinkPrimitiveParamsFast(2, [
            PRIM_POSITION, adjustPos,
            PRIM_ROTATION, ZERO_ROTATION,
            PRIM_SIZE, gPrimSize,
            PRIM_FULLBRIGHT, ALL_SIDES, FALSE,
            PRIM_COLOR, ALL_SIDES, black, 0.0,
            PRIM_COLOR, frontSide, black, 1.0
            ]);


        // Now for each special type of prim - we may resize, recolor and possibly add a texture
        // For the scroll prim - set a texture
        if (-1 != llListFindList(names, ["Scroll"]))
        {
        	// It seems to me that the color has effect on the texture - need to set to white to see it
        	//   black makes the texture disappear... seems related to alpha almost...
        	//   If we don't set it to white - no texture appears...  1.0,0.025,0.0,-0.422
	        llSetLinkPrimitiveParamsFast(2, [ PRIM_TEXTURE, frontSide, texture, <1.0, 0.025, 0.0>, <0.0, -0.422, 0.0>, 0,
	        								  PRIM_COLOR, frontSide, white, 1.0 ]);
        }
        // For the menu # prim - set a texture and the height
        if (-1 != llListFindList(names, ["Numbers"]))
        {	// Offset/scale from above - calculated/set in sl (sigh)
	        llSetLinkPrimitiveParamsFast(2, [ PRIM_TEXTURE, frontSide, texture, <1.0, 0.05, 0.0>, <0.0, 0.47, 0.0>, 0,
	        								  PRIM_COLOR, frontSide, white, 1.0, 
											  PRIM_SIZE, gPrimMenus ] );
        }
        // For mode prim - set texture
        if (-1 != llListFindList(names, ["Mode"]))
        {
	        llSetLinkPrimitiveParamsFast(2, [ PRIM_TEXTURE, frontSide, texture, <1.0, 0.025, 0>, <0.0, -0.328, 0>, 0,
	        								  PRIM_COLOR, frontSide, white, 1.0 ]);
        }


        // Send a linked message to the new object so it's object name gets set
        //  Newly linked prim is link # 2!
	    llMessageLinked(2, 123, primName, "");


		// Is there another prim we should rez?
		gPrimNumber++;
        if (gPrimNumber < llGetListLength(primNames))
        {
			llRezObject(llList2String(cleanupInventoryItems, cubeIndex), llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 0);
        }
        else
        {
        	llOwnerSay("Cleaning up inventory...");
        	for (i=0; i<llGetListLength(cleanupInventoryItems); ++i)
	            llRemoveInventory(llList2String(cleanupInventoryItems, i));
            llRemoveInventory(llGetScriptName());

            llOwnerSay("Created DanceHUD prims - ready to have scripts added :-)");
        }
    }
}
