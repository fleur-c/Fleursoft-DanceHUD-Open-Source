// Interface details for the FSLists module
//
// This module does:
//     - full MenuList for Inventory (animations) (basically get range, select and select by string)
//     - mini-menulist (admin menu related - constrained menus) for: - essentially get range and select only
//      - Administrative menu
//      - AO menu
//      - Admin menu - for notecards to load notecard
//		- Admin menu of user menu to clear
//      - Admin menu for Clicker Training (menu resize commands)


// Generic menu list details:
//
// The common menulist options are Get menu range and Select (SelectString is used for unconstrained menus)
//  - these are the same for ALL MenuList-like interfaces - these 'menulist'-lite interfaces
//  are the various admin menus for things. We have aliases for the same names so that the lite
//  interfaces are simple to identify.
//
// Note: MenuList.h depends on these definitions being here! There is a numbering scheme and
//  see MenuList.h for the details...

#define MenuLite_GetMenuRange 103
	// Get a range of the items from this interface - <start #>|<return link id>|<# entries to return> - comes back with a 'ITEMS'
#define Define_FlagRangeConstrainedMenu 0
#define Define_FlagRangeUnconstrainedMenu 1
	// Define the range flag values (constrained = admin menu, unconstrained = user menu/inventory lists)


#define MenuLite_Select 51
	// Select this item - <select>|<return link id>|<id #>[|optional stuff] - sent to the menu link id
	// Two cases:
	//  1) Item # is on the menu - and we it up and send the data
	//  2) Item # is beyond the menu - and we need to look it up... ha - not doing it
#define MenuLight_SelectString 52
	// For unconstrained menu (Inventory, user menus) we allow the user to type '/## 72' - and have 72 selected regardless of what is on the screen
	//  They can also type '/## something' and if 'something' is in inventory or in that menu, then it is selected.
// If it isn't shown - then you can't pick it from the admin menu!
// Seems to me that the lookup is going to have to happen at the menulist lite routine - as the beyond the
//  edge of the menu takes us there...

// ITEMS returned: ITEMS|menu name|# entries for menu|start #|<flag>  (key)seqname|menu link id|id # (of some flavor)[|optional stuff]
//					May also return (key) of "" - indicates request was beyond our range
//					<flag> 0=constrained to the items here, 1=not constrained (select # and name - has a lookup option)






// Admin submenu settings flag bits for one integer (we are not burning more than one int for these bits)
#define AOSitFlag   1
#define AORandomStands  2
#define AOSitAnywhereFlag 4
#define AOStandFlag 8
#define AdminRecordDances 16
#define AdminTimeAnimations 32
#define AdminErrorsOnLoad 64
#define AdminKeepBlankLines 128
#define AdminKeepCommentLines 256
#define AdminKeepRepeats 512
	// Errors on load is all about do we show error messages while we load dance sequences OR while we dance
	//  (i.e. missing animations - when we do tell the user?) The default will be to tell them when they dance.
	// I like them when you load the notecard - as it tells me I got something wrong.
#define AdminDanceSelectionAuto 1024
	// FALSE=Manual, TRUE=Automatic (click one to get started) (default manual)
#define AdminDanceSelectAutomaticRandom 2048
	// FALSE=All (top to bottom), TRUE=Random (default doesn't matter - false)  -


// Administrative menu items... (ordered as will be displayed)
#define AdminMenuPrevMenu 0
#define AdminMenuSync 1
#define AdminMenuAddDancer 2
#define AdminMenuRemoveDancer 3
#define AdminMenuChangeDancerGroups 4
#define AdminMenuLoadNotecard 5
#define AdminMenuSetWaitMenu 6
#define AdminMenuCopyDances 7
#define AdminMenuClearMenu 8
#define AdminMenuSetTheme 9
#define AdminMenuChangeHeight 10
#define AdminMenuChangeWidth 11
#define AdminMenuReset 13
#define AdminMenuReadMe 14
#define AdminMenuNoOp 15

// #define AdminMenuClearDanceSequence 7 - unimplemented for now
#define AdminMenuDanceSelection 16
#define AdminMenuDanceDuration 17
#define AdminMenuMissingDanceWarning 18
#define AdminMenuKeepBlankLines 19
#define AdminMenuKeepCommentLines 20
#define AdminMenuKeepRepeats 21
#define AdminMenuRecordFreestyleSequences 22
#define AdminMenuTimeAnimations 23
#define AdminMenuSetUserMenu 24
#define AdminMenuPreloadAnims 25
#define AdminMenuMaxCommand AdminMenuPreloadAnims


#define AdminMenuNumbers [AdminMenuPrevMenu, AdminMenuSync, AdminMenuAddDancer, AdminMenuRemoveDancer, \
                          AdminMenuChangeDancerGroups, AdminMenuLoadNotecard, AdminMenuSetWaitMenu, \
                          AdminMenuCopyDances, AdminMenuClearMenu, \
                          AdminMenuSetTheme, AdminMenuChangeHeight, AdminMenuChangeWidth, \
                          AdminMenuPreloadAnims, AdminMenuReset, AdminMenuReadMe, \
                          AdminMenuNoOp, AdminMenuNoOp, \
						  AdminMenuDanceSelection, AdminMenuDanceDuration, \
						  AdminMenuMissingDanceWarning, \
                          AdminMenuKeepBlankLines, AdminMenuKeepCommentLines, \
                          AdminMenuKeepRepeats, \
                          AdminMenuRecordFreestyleSequences, AdminMenuTimeAnimations, AdminMenuSetUserMenu ]


// AO Menu items

// AO menu items - same as menu order to user - also applies so that select works!
#define AOMenuAOName 1
#define AOMenuNextStand 2
#define AOMenuStandSequence 3
#define AOMenuSit 4
#define AOMenuSitAnywhere 5
#define AOMenuStand 6
#define AOMenuLoadNotecard 7
#define AOMenuSelectSit 8
#define AOMenuSelectWalk 9
#define AOMenuSelectGroundSit 10

#define AOMenuMaxValue AOMenuSelectGroundSit

#define aoMenuNames [ "AO:", "Next stand", "Stand order:", "Sit:", "Sit anywhere:", "Stand:", "Load Notecard", "Select sit", "Select walk", "Select ground sit" ]
#define aoMenuCmds [ AOMenuAOName, AOMenuNextStand, AOMenuStandSequence, AOMenuSit, AOMenuSitAnywhere, AOMenuStand, AOMenuLoadNotecard, AOMenuSelectSit, AOMenuSelectWalk, AOMenuSelectGroundSit ]

#define MessageAONextStand()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_NEXTSTAND", (key) "")
#define MessageAOSitOn()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SITON", (key) "")
#define MessageAOSitOff()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SITOFF", (key) "")
#define MessageAORandomStands()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_RANDOMSTANDS", (key) "")
#define MessageAOSequentialStands()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SEQUENTIALSTANDS", (key) "")
#define MessageAOSitAnywhereOn()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SITANYWHERE_ON", (key) "")
#define MessageAOSitAnywhereOff()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SITANYWHERE_OFF", (key) "")
#define MessageAOStandOn()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_STANDON", (key) "")
#define MessageAOStandOff()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_STANDOFF", (key) "")
#define MessageAOSelectSit()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_SITS", (key) "")
#define MessageAOSelectWalk()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_WALKS", (key) "")
#define MessageAOSelectGroundSit()	llMessageLinked(LINK_THIS, Define_AOLINKID, "ZHAO_GROUNDSITS", (key) "")


// Adjust height Menu items
#define ClickerMenuPrevMenu 0
#define ClickerMenuHeight1 1
#define ClickerMenuHeight2 2
#define ClickerMenuHeight3 3
#define ClickerMenuHeight4 4
#define ClickerMenuHeight5 5
#define ClickerMenuHeight6 6
#define ClickerMenuHeight7 7
#define ClickerMenuHeight8 8


// Adjust widgth menu items
#define ClickerMenuWidth1 1
#define ClickerMenuWidth2 2
#define ClickerMenuWidth3 3
#define ClickerMenuWidth4 4
#define ClickerMenuWidth5 5
#define ClickerMenuWidth6 6
#define ClickerMenuWidth7 7
#define ClickerMenuWidth8 8

#define clickerHeightMenu [ "Back", "▁▁▁", "▂▂▂", "▃▃▃", "▄▄▄", "▅▅▅", "▆▆▆", "▇▇▇", "███"]
#define clickerHeightCmds [ ClickerMenuPrevMenu, ClickerMenuHeight1, ClickerMenuHeight2, ClickerMenuHeight3, ClickerMenuHeight4, ClickerMenuHeight5, \
                             ClickerMenuHeight6, ClickerMenuHeight7, ClickerMenuHeight8 ]

#define hudHeightSettings [ 144, 158, 172, 186, 200, 214, 228, 242 ]
	// Default height is 0.0144 (or the 1st one) - divide these by 10,000

#define clickerWidthMenu [ "Back", "▏", "▎", "▍", "▌", "▋", "▊", "▉", "█"]
#define clickerWidthCmds [ ClickerMenuPrevMenu, ClickerMenuWidth1, ClickerMenuWidth2, ClickerMenuWidth3, ClickerMenuWidth4, ClickerMenuWidth5, \
                           ClickerMenuWidth6, ClickerMenuWidth7, ClickerMenuWidth8 ]

#define hudWidthSettings [ 184, 214, 246, 276, 308, 338, 370, 400 ]
	// Default width is 0.308 (or the 5th one) - divide these by 1,000
	// No ODD numbers here - we will divide by 2 and that'll only cause trouble

#ifdef BUILD_FOR_SL
#define clickPositions [ 68, 56, 55, 46, 40, 36, 24, 24 ]
#endif
#ifdef BUILD_FOR_OPENSIM
#define clickPositions [ 63, 42, 50, 37, 25, 25, 25, 20 ]
#endif
	// These are the percentages of where you click - above this and it's the prim above that 'we clicked'
	// Below this value - and we clicked the correct prim. Why do this? Because the hovertext is NOT exactly
	// centered.

