// Interface file for FSRead script
#define MessageGetGroupAliases(returnLinkid)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "ALIASES", (key)((string)returnLinkid))


// Messages from ReadNotecard
#define MessageLoadSequenceNotecard(notecard, menuLinkid)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, llDumpList2String(["LOAD",notecard,menuLinkid],"|"), (key) "")
#define MessageSendGroupAliases(returnLinkid, aliases)	llMessageLinked(LINK_THIS, returnLinkid, "ALIASES", (key)aliases)
#define MessageSendSequencesHere(menuLinkid)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "REDIRECT|"+(string)(menuLinkid), (key)"")
#define MessageLoadMissingAnimFlag(flag)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "MISSING|"+(string)(flag), (key)"")
	// 1 == warn on loading, 0 == do not warn about missing animations while loading notecards (sigh)
#define MessageKeepBlankLinesFlag(flag)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "BLANK|"+(string)(flag), (key)"")
	// 1 == keep blank lines, 0 == do not keep blank lines
#define MessageKeepCommentLinesFlag(flag)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, "COMMENT|"+(string)(flag), (key)"")
	// 1 == keep comment lines, 0 == do not keep comment lines
#define MessageRememberSequence(sequence, menuLinkid)	llMessageLinked(LINK_THIS, Define_READNOTECARDLINKID, llDumpList2String(["REMEMBER",menuLinkid],"|"), (key) sequence)
