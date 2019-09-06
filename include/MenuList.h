// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

// MenuList commands - most common requests are menulist requests... we use them for every menu!
//    Commands from 1-50 have the option of a sequence name, 51-100 have a sequence #, 101-150 has no sequence name specified
//  we use this to be able to parse the name/item # all the time and not have to look at the command to decide.
//  ALL commands that have sequence names and numbers - have them right after the command - so: 1|sequence - for ShowSequence with name sequence
//  This makes the parsing smaller - only generic parsing at the start...
#define List_MinHasSeqName 1
#define List_MaxHasSeqName 50

#define List_ShowSequence 1
#define List_RemoveSeq 2

#define List_MinHasSeqNum 51
#define List_MaxHasSeqNum 101
// 51 is used by list for Select
// 52 is used by list for SelectString

#define List_AddSequence 101
#define List_AddSequenceDance 102
// 103 is used by List.h for select range
#define List_AddFreestyle 104
#define List_ShowAllSequences 105
#define List_SetWait 106
#define List_ClearMenu 107
#define List_SetMenuName 108
#define List_CopyDances 109
#define List_AddBlankLine 110
#define List_AddComment 111
#define List_LoadedAO 112
    // id = name of loaded AO notecard (just for AO menu to display the name)
#define List_NextSequence 113
#define List_SetDefaultDuration 114
    // This is only for the Lists routine so that the admin menu can show what got set
#define List_SetCurrentMenu 115
    // This is only for the Lists routine so that the admin menu can show the currently active menu
    // (which is where we load sequences, it's also where we will record a freestyle sequence)

// Subclassed items from mini-menu lists
#define List_SelectString    MenuLight_SelectString
#define List_Select            MenuLite_Select
#define List_GetMenuRange    MenuLite_GetMenuRange

#define SelectOptionNone 0
#define SelectOptionDeferred 1
#define SelectOptionWaitseq 2
    // Select options - none, deferred or wait sequence start


// Messages to generic MenuList interface
#define MessageSelect(linkid, item)    llMessageLinked(LINK_THIS, linkid, (string)List_SelectString + "|" + (string)item, (string)SelectOptionNone)
#define MessageSelectNumber(linkid, number)    llMessageLinked(LINK_THIS, linkid, (string)List_Select + "|" + (string)number, (string)SelectOptionNone)
#define MessageSelectNumberDeferred(linkid, number)    llMessageLinked(LINK_THIS, linkid, (string)List_Select + "|" + (string)number, (string)SelectOptionDeferred)
#define MessageSelectNumberWaitseq(linkid, number)    llMessageLinked(LINK_THIS, linkid, (string)List_Select + "|" + (string)number, (string)SelectOptionWaitseq)
#define MessageAddSequence(linkid, name, sequence)    llMessageLinked(LINK_THIS, linkid, (string)List_AddSequence + "|" + name, sequence)
#define MessageAddSequenceDance(linkid, name, sequence)    llMessageLinked(LINK_THIS, linkid, (string)List_AddSequenceDance + "|" + name, sequence)
#define MessageAddBlankLine(linkid)    llMessageLinked(LINK_THIS, linkid, (string) List_AddBlankLine, "")
#define MessageAddComment(linkid,comment)    llMessageLinked(LINK_THIS, linkid, (string) List_AddComment, comment)
#define MessageSetMenuName(linkid, name)    llMessageLinked(LINK_THIS, linkid, (string) List_SetMenuName + "|" + name, "")
#define MessageGetMenuRange(linkid, startIndex, numberEntries, returnLinkid)   llMessageLinked(LINK_THIS, linkid, llDumpList2String([List_GetMenuRange,startIndex,returnLinkid,numberEntries],"|"), "")
#define MessageClearMenu(linkid)    llMessageLinked(LINK_THIS, linkid, (string)List_ClearMenu, "")
#define MessageCopyDances(linkid,toLinkid)    llMessageLinked(LINK_THIS, linkid, (string)List_CopyDances, (string)toLinkid)
#define MessageMenuShowSequence(linkid, name)    llMessageLinked(LINK_THIS, linkid, (string)List_ShowSequence + "|" + name, "")
#define MessageMenuShowAllSequences(linkid)    llMessageLinked(LINK_THIS, linkid, (string)List_ShowAllSequences, "")
#define MessageMenuRememberAO(name)    llMessageLinked(LINK_THIS, Define_AOMENULINKID, (string)List_LoadedAO + "|" + name, "")
#define MessageSelectNextDance(linkid, flag, prevDanceIndex)    llMessageLinked(LINK_THIS, linkid, (string)List_NextSequence, (string)flag + "|" + (string)prevDanceIndex)
#define MessageListSetDefaultDuration(duration)    llMessageLinked(LINK_THIS, Define_ADMINLINKID, (string)List_SetDefaultDuration + "|" + (string)duration, "")
#define MessageListSetCurrentMenu(linkid)    llMessageLinked(LINK_THIS, Define_ADMINLINKID, (string)List_SetCurrentMenu + "|" + (string)linkid, "")


// Message from generic MenuList interface
#define MessageSendMenuRange(linkid, menuName, numberItems, startNumber, rangeFlag, fromLinkid, names)    llMessageLinked(LINK_THIS, linkid, llDumpList2String(["ITEMS",menuName,numberItems,startNumber,rangeFlag,fromLinkid],"|"), names)
#define MessageSendMenuRangeSelected(linkid, menuName, numberItems, startNumber, rangeFlag, fromLinkid, names, selected)    llMessageLinked(LINK_THIS, linkid, llDumpList2String(["ITEMS",menuName,numberItems,startNumber,rangeFlag,fromLinkid,selected],"|"), names)
#define MessageSendSequence(linkid, name, sequence, fromMenuLinkid)    llMessageLinked(LINK_THIS, linkid, "SEQUENCE" + "|" + name + "|" + (string)fromMenuLinkid, sequence)
#define MessageSendSequenceWaitseq(linkid, name, sequence, fromMenuLinkid)    llMessageLinked(LINK_THIS, linkid, "WAITSEQ" + "|" + name + "|" + (string)fromMenuLinkid, sequence)
#define MessageSendFreestyleAdded(name, fromLinkid)    llMessageLinked(LINK_THIS, Define_UILINKID, "FREESTYLEADDED", name + "|" + (string)fromLinkid)
#define MessageSendForgotSequence()    llMessageLinked(LINK_THIS, Define_UILINKID, "FORGOTSEQ", "")
#define MessageSendClearedMenu()    llMessageLinked(LINK_THIS, Define_UILINKID, "CLEAREDMENU", "")
