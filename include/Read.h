// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

// Interface file for FSRead script
#define MessageGetGroupAliases(returnLinkid)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "ALIASES", (string)returnLinkid)


// Messages from ReadNotecard
#define MessageLoadSequenceNotecard(notecard, menuLinkid)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "LOAD" + "|" + notecard + "|" + (string)menuLinkid, "")
#define MessageSendGroupAliases(returnLinkid, aliases)    llMessageLinked(LINK_THIS, returnLinkid, "ALIASES", (key)aliases)
#define MessageSendSequencesHere(menuLinkid)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "REDIRECT" + "|" + (string)(menuLinkid), "")
#define MessageLoadMissingAnimFlag(flag)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "MISSING" + "|" + (string)(flag), "")
    // 1 == warn on loading, 0 == do not warn about missing animations while loading notecards (sigh)
#define MessageKeepBlankLinesFlag(flag)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "BLANK" + "|" + (string)(flag), "")
    // 1 == keep blank lines, 0 == do not keep blank lines
#define MessageKeepCommentLinesFlag(flag)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "COMMENT" + "|" + (string)(flag), "")
    // 1 == keep comment lines, 0 == do not keep comment lines
#define MessageRememberSequence(sequence, menuLinkid)    llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "REMEMBER" + "|" + (string)menuLinkid, sequence)
