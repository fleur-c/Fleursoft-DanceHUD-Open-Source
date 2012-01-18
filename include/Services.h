// Implementation interface for Services module

#define CompanyName "Fleursoft"
#define DanceHUDDocumentation "http://fleursoft.com/"

// Define the product revision number
#define DanceHUD_Revision "1.3"
	// This has to be changed on every update

// MenuList options for getting a wait sequence
#define Define_MenuListWaitSequence 1
	// We have a default wait sequence
#define Define_MenuListWaitMenu 2
	// We have a default wait menu
#define Define_MenuListWaitUnknown 3
	// We don't have a wait set at all - use built in animation of 'stand_1' (sigh)
#define Define_DefaultWaitAnimation "stand_1"

	// How do we handle the default wait menu? (i.e. what order?)
#define Define_MenuListWaitMenuSequentialTopToBottom 1
#define Define_MenuListWaitMenuSequentialBottomToTop 2
#define Define_MenuListWaitMenuRandom 3


// Services commands
#define Service_GetWaitSequence 1
	// Get the wait sequence - returns as a SEQUENCE to the caller
#define Service_RecenterHUD 2
	// Get the HUD back onto the screen based on the HUD attachment location
#define Service_SetActiveMenu 3
	// Set the active menu # - so we can highlight it when selecting the user menu from a list...


// Messages to Services
#define MessageGetWait(linkid)	llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_GetWaitSequence, (key)((string) linkid))
#define MessageRecenterHUD()	llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_RecenterHUD, (key) "")
#define MessageServiceSetActiveMenu(linkid)	llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_SetActiveMenu, (key)((string) linkid))
