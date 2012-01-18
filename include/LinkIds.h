// Simple global definition of all of our link ids

// Dancer link ids and group mask link ids
#define Define_DANCERSLINKID 121234200
	// Dance Control link id # (for individual dance scripts)
#define Define_DANCERCHANGEGROUPSOFFSET 200
	// Add this to the dancers linkid to get the change group link id for each dancer (keeps the command # handling completely seperated)
#define Define_DANCEGROUPS 303181824
	// (0x12123000) Dance Control link id # (for group dance scripts) with 12 bits for flag words (1-2048)
	// This is 0x4842e000 - a nice value that we can bitmask and get 12 bits of flag words from
#define Define_DANCEGROUPMASK 2147479552
	// This is the mask value for our groups broadcast (0x7ffff000) - dropping high bit
#define Define_DANCEGROUPBITMASK 4095
	// Inverse of mask (0xfff) so we can get the flag bits from the broadcast messages


// List of the link numbers for other scripts to receive messages
#define Define_READNOTECARDLINKID 12123401
	// To Read a configuration notecard
#define Define_DANCECONTROLLINKID 12123402
	// Dance Master id# - used for controlling ALL sequence activities in the HUD
#define Define_PREPARELINKID 12123403
	// Send messages for the preparing of a dance sequence into a time sequence
#define Define_DEBUGMSGLINKID 12123404
	// Send messages for the debugging of link messages to this link id
#define Define_LANGUAGELINKID 12123405
	// Send messages for the international language printing routine to this link id
#define Define_CHATONLYLINKID 12123406
	// Send messages chatting only to this link id (also takes in input from the user as chat commands)
#define Define_SERVICESLINKID 12123407
	// Send messages for services to this link id
#define Define_UILINKID 12123408
	// User Interface id# - user interface script for the HUD - display for prims or text
#define Define_AOLINKID 12123409
	// Send messages to this link ID for ZHAO II kinds of requests - only exception is RESET (we do NOT test the ZHAO II interface yet...  this MAY change)
#define Define_AOMENULINKID 12123410
	// Send messages for the AO menu
#define Define_INVENTORYANIMLINKID 12123411
	// Inventory for animations - minimenu list + unconstrained (can run any inventory animation) and also searches by name/number because of the non-constraint
#define Define_ADMINLINKID 12123412
	// Send messages to this link ID for admin menu requests
#define Define_ADDDANCERLINKID 12123413
	// Send messages for the adding of dancers (get a list of new AVs to be added)
#define Define_REMOVEDANCERSLINKID 12123414
	// Send messages for the removing of any of the current dancers (get a list of dancing AVs to be removed)
#define Define_LISTDANCERSLINKID 12123415
	// Send messages for the getting list of dancers for changing the group flags (get a list of AVs to select who will have their groups changed)
#define Define_LISTNOTECARDLINKID 12123416
	// Send messages for the loading of a notecard
#define Define_LISTMENUSTOCLEARLINKID 12123417
	// Send messages for the listing of user menus to clear
#define Define_LISTMENUSFORWAITLINKID 12123418
	// Send messages for the listing of user menus to select for wait menu sequences
#define Define_AOSELECTLINKID 12123419
	// Select from a list of animations for a particular type of motion
#define Define_INVENTORYTHEMELINKID 12123420
	// Select from a list of theme names (textures with special names that include color information)
#define Define_TRANSFERLINKID 12123421
	// Menu for transfer items (reserved - not used in open source version)
#define Define_LISTMENUSFORCOPYFROMLINKID 12123422
	// Menu for copying from menu - to copy animation names/delays to a different menu
#define Define_LISTMENUSFORCOPYTOLINKID 12123423
	// Menu for copying TO menu - receives animation names/delays
#define Define_LISTCHANGEHEIGHTLINKID 12123424
	// Menu for changing the height of the HUD
#define Define_LISTCHANGEWIDTHLINKID 12123425
	// Menu for changing the height of the HUD
#define Define_COMMENTBLANKLINKID 12123426
	// Linkid that isn't used for anything - except for blank lines in the menu and comments
	//  We're using it as a placeholder - but interestingly - the FSUI will send to it - it just never gets a response
#define Define_LISTMENUSTOSELECTMENU 12123427
	// Send messages for the selecting of the user menu (i.e. which user menu is going to be active?) - so admin menu can know...
	// We send this from a click on the admin menu to select the active menu -which sends the response to the UI AND the admin
	// menu - right before we go back to the admin menu. Tada (bleck - I really dislike this - but it'll work)
#define Define_DANCERSADMINLINKID 12123428
	// All dancer list handling (add, remove, change dancers, auto invite, etc)


#define ExtraAdminMenus [ Define_ADDDANCERLINKID, Define_REMOVEDANCERSLINKID, Define_LISTDANCERSLINKID, Define_LISTNOTECARDLINKID, \
									Define_LISTMENUSTOCLEARLINKID, Define_LISTMENUSFORWAITLINKID, Define_INVENTORYTHEMELINKID, \
									Define_LISTCHANGEHEIGHTLINKID, Define_LISTCHANGEWIDTHLINKID, Define_LISTMENUSTOSELECTMENU ]

#define Define_LOADANIMSMENU 12123428
	// This menu is a little different - it is refreshed as we load dance animations quickly so that the user
	//  can see where we are on the list of animations and how long it's taken so far - each new group of animations
	//  causes a refresh. The user can cancel the operation at anytime...


// Group menu related link id's so we can detect a menu link id easily (just mask and check)
#define MenuBaseNumber 305410560
	// This is 0x12343200
#define MenuBaseMask 2147483392
	// Same as 0x7fffff00
	// So the check for a menu link id is ((linkid&mask) == basenumber)
#define Define_MENULISTLINKID 305410560
	// Menu list id# (unique by menu # - starts at 1 up to N menus, save room for 256 of them - unlikely to ever need that many)
#define IsUserMenu(linkid) ((linkid & MenuBaseMask) == MenuBaseNumber)



// Below this is NOT implemented/unit tested/hardened yet...


// Unclear if these link id's will be used at all...
#define Define_HELPLINKID 12123418
	// Send messages to this link ID for help menu requests
