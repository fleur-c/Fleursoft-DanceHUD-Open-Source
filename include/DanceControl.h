// Interfaces implemented in FSDanceControl script
//
// This script is all about playing back the sequence correctly - that's all it does. We do NOT
//  know about any dancers - we just send message to the dancing groups (i.e. multicast sends)
//  We do NOT know about the dancers at all in this script.


// Dance Control command set
#define DanceControlStop 1
	// Stop all dancing

#define DanceControlAccurateTimer 2
	// Enable/disable accurate timing (flag TRUE for accurate, FALSE=normal) - can be slightly laggy as it burns CPU - default is TRUE(on)

#define DanceControlStartRecording 3
	// Start recording all animations (sent to all dancers) and their delays - recording for freestyle - on Stop or Wait, we send the sequence to the menu to add

#define DanceControlSyncDancers 4
	// Sync all of the dancers to a sync point

#define DanceControlIM 5
	// Send IM to dance master so that we can send the message out to all of the active dancers
	// Starting a sequence is handled by sending it the time ordered sequence - same for wait sequences

#define DanceControlMissingAnimWarning 6
	// Message to indicate if we tell the user about missing animations during dancing or not
	// flag==0 means warn during dancing, flag==1 means warn during loading notecard - default is warn during dancing

#define DanceControlDisableRepeat 7
	// Turn off the [repeat] keyword - useful for freestyle dance mode

#define DanceControlSetDurationFlag 8
	// Set flag indicating default duration matters or not

#define DanceControlSetDurationValue 9
	// Set the default dance duration (only used when the default duration flag is set)

#define DanceControlLastDanceStartForDancer 10
	// This lets the Dancers admin add a dancer, then come here and get the last animation started and send it to the new dancer


// Messages to Dance Control (unused messages have xxx on the front)
#define MessageStopAllDancing(releaseAllFlag)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlStop, (key)((string) releaseAllFlag))
	// ReleaseAllFlag == TRUE - releases all dancers, FALSE - just stops and does NOT release dancers
#define xxxMessageSetAccurateTimer(flag)  llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlAccurateTimer, (key)((string) flag))
#define MessageSyncAllDancers()	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlSyncDancers, (key) "")
#define MessageSendIM(msg)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlIM, (key) msg)
#define MessageDCSetRecordingSequences(menuLinkid,flag)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlStartRecording, (key) llDumpList2String([menuLinkid,flag],"|"))
#define MessageDCMissingAnimFlag(flag)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlMissingAnimWarning, (key)((string) flag))
#define MessageDCDisableRepeatFlag(flag)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlDisableRepeat, (key)((string) flag))
	// 0 = [repeat] works, 1 = [repeat] does NOT work
#define MessageDCSetDurationFlag(flag)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlSetDurationFlag, (key)((string)flag))
	// flag = 0 for no default duration (this is the default for dance control), 1 = use default duration
#define MessageDCSetDurationValue(duration)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlSetDurationValue, (key)((string)duration))
#define MessageDCStartNewDancer(dancerLinkId, avname, avkey, chatchannel, autoinvite)	llMessageLinked(LINK_THIS, Define_DANCECONTROLLINKID, (string)DanceControlLastDanceStartForDancer, (key) llDumpList2String([dancerLinkId, avname, avkey, chatchannel, autoinvite], "|"))

