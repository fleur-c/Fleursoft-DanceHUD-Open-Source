// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

// Implementation interface for Services module

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

    // What commands do we have on the transfer menu?
#define Define_MenuXferBack 0
#define Define_MenuXferAnimations 1        // Bit 1
#define Define_MenuXferNotecards 2        // Bit 2
#define Define_MenuXferTextures 3        // Bit 4
#define Define_MenuXferClothing 4        // Bit 8
#define Define_MenuXferShapes 5            // Bit 16
#define Define_MenuXferGestures 6        // Bit 32
#define Define_MenuXferSounds 7            // Bit 64
#define Define_MenuXferLandmarks 8        // Bit 128
#define Define_MenuXferObjects 9        // Bit 256
#define Define_MenuXferScripts 10        // Bit 512
#define Define_MenuRemoveAfterXfer 11    // Bit 1024
#define Define_MenuXferDuplicates 12    // Bit 2048
#define Define_MenuXferStart 13            // Bit 4096
#define Define_MenuXferBlankLine 14        // Bit 8192
#define Define_MenuXferCancel 15        // Bit 16384 
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
#define MessageGetWait(linkid)    llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_GetWaitSequence, (string) linkid)
#define MessageRecenterHUD()    llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_RecenterHUD, "")
#define MessageServiceSetActiveMenu(linkid)    llMessageLinked(LINK_THIS, Define_SERVICESLINKID, (string)Service_SetActiveMenu, (string) linkid)
