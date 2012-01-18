// Interface definitions for Dancer script

#define DancerScriptBasename "~FSDancer"
	// What is the basename of the dancer scripts in the HUD? - it starts with this string
	// All dancer scripts have this as a base and then a # after them (~FSDancer 1 - and so on...)

#define DefaultActiveDancers 10
	// How many dancers can we have? The rest of the dancer scripts are turned off...


// Dancer commands
#define DancerStart 1
	// Start an animation
#define DancerStop 2
	// Stop an/all animations
#define DancerAdd 3
	// Add a dancer (only one per controller)
#define DancerGetFlags 4
	// Get group flags for this dancer script
#define DancerSetFlags 5
	// Set group flags for this dancer script
#define DancerGetInfo 6
	// Get the dancer name from each active dancer
#define DancerIM 7
	// Send an IM to all of the dancers
#define DancerTimer 8
	// Show a duration of every dance we dance (sent only to the first dancer/owner)
	//  key=TRUE (turn on), FALSE (turn off)
#define DancerItem 9
	// Send an item to each dancers (handy for giving out notecards while in a dance & talk)
#define DancerLoadAnims 10
	// Load a list of animations quickly - we do this on each dancer so that it's possible to
	//  get lots of animations started and into the sim/viewer memory quickly.
#define DancerStopAuto 11
	// If we were told to stop auto inviting and this dancer was invited (but did NOT accept yet)
	// this command is to drop the dancer (reset the script)

#define DancerFlagStopAllDances 1024
	// Flag for indicating stop all dances
#define DancerPromptDelay 120.0
	// Number of seconds to wait for user to answer request to dance with us


#define DancerGroupAllFlags Define_GroupAllBits
	// Multicast bit settings - first bit is always set - so generic broadcast


// Define some values for the start dance group (passed in on start group dancing)
#define DanceFlagDoNotStopOtherAnimations 0
#define DanceFlagStopOtherAnimations 1
#define DanceFlagSyncAnimations 2


// Message to Dancer # scripts
#define MessageStartGroupDancing(multicastBits, danceIndex, animationName, startFlag)	llMessageLinked(LINK_THIS, Define_DANCEGROUPS+multicastBits, (string)DancerStart, (key)llDumpList2String([danceIndex,animationName,startFlag],"|"))
#define MessageStopGroupDancing(multicastBits, danceIndex)	llMessageLinked(LINK_THIS, Define_DANCEGROUPS+multicastBits, (string)DancerStop, (key)((string)danceIndex))
#define MessageAddToDanceGroup(dancerLinkId, dancerInfoList)	llMessageLinked(LINK_THIS, dancerLinkId, (string)DancerAdd, (key)llDumpList2String(dancerInfoList,"|"))
	// The list order is: avname, avkey, channel #, animation, autoInviteFlag, animation name to start
#define MessageGetDancerFlags(linkid, returnLinkid)	llMessageLinked(LINK_THIS, linkid, (string)DancerGetFlags, (key)((string) returnLinkid))
#define MessageSetDancerFlags(linkid, flags)	llMessageLinked(LINK_THIS, linkid, (string)DancerSetFlags, (key)((string) flags))
#define xxxMessageGetDancerInfo(linkid, returnLinkid)	llMessageLinked(LINK_THIS, linkid, (string)DancerGetInfo, (key)((string) returnLinkid))
#define MessageSendGroupIM(msg)		llMessageLinked(LINK_THIS, Define_DANCEGROUPS+Define_GroupAllBits, (string)DancerIM, (key) msg)
#define MessageSendGroupItem(item)		llMessageLinked(LINK_THIS, Define_DANCEGROUPS+Define_GroupAllBits, (string)DancerItem, (key) item)
#define MessageSendIMtoDancers(msg)	llMessageLinked(LINK_THIS, Define_DANCEGROUPS+Define_GroupAllBits, (string)DancerIM, (key) msg)
#define MessageShowDanceDurations(flag)	llMessageLinked(LINK_THIS, Define_DANCEGROUPS+Define_GroupAllBits, (string)DancerTimer, (key)((string) flag))
#define MessageStartLoadManyAnims(linkid, lastDancerFlag, anims)	llMessageLinked(LINK_THIS, linkid, (string)DancerLoadAnims, (key)((string)lastDancerFlag+"|"+anims))
#define MessageStopAutoInviteDancers()	llMessageLinked(LINK_THIS, Define_DANCEGROUPS+Define_GroupAllBits, (string)DancerStopAuto, (key) "")


// Message from Dancer # scripts
#define MessageSendDancerInfo(linkid, dancerName, dancerLinkid)	llMessageLinked(LINK_THIS, linkid, "DANCERNAME", (key) llDumpList2String([dancerName,dancerLinkid],"|"))
#define MessageSendDancerFlags(linkid, dancerName, flags)	llMessageLinked(LINK_THIS, linkid, llDumpList2String(["MCFLAGS",dancerName],"|"), (key)((string) flags))
