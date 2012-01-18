// Interfaces implemented in FSDances script
//
// This script knows who is dancing with us (names, link id's and even scripts that are available)
// It also does the add/remove of a dancer and starts the group flag changing (cause it knows the dancers)
// Additionally - it is picking up the automatic invitation feature for adding dancers

#define DanceScanThisFar 50.0
	// How far should we scan on radar?
#define DanceScanInterval 10.0
	// How often should we scan for a dancer to disappear? (the dancer scripts scan for the individual dancers - lowest lag item we can do to avoid an error)


#define DancersAddDancer 1
	// Pass through message to a dance controller, but we add the animation to start and chat channel #...

#define DancersRemoveDancer 2
	// Pass through message to a dance controller - but we need to forget the dancer too...

#define DancersSetActiveDancers 3
	// CHange the number of active dance controller scripts

#define DancersSetChatChannel 4
	// Change the owner chat number - which will impact the new dancers and won't change existing dancers - but may cause an error if the channel is already in use

#define DancersShowAll 5
	// Help message for all of the active dancers

#define DancersLoadAllAnims 6
	// Load all animations in the HUD to each dancer (quickly) - the real work is in Chat (we had script space there)

#define DancersAutoInvite 7
	// Start autoinvite - this gathers up the dancers/links and sends them to Chat via a Chat message

#define DancersReleaseAll 8
	// Release all of the dancers


// Messages to Dance Control (unused messages have xxx on the front)
#define MessageAddDancer(avname, avkey)	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersAddDancer, (key) llDumpList2String([avname,avkey],"|"))
#define MessageRemoveDancer(avkey,releaseFlag)	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersRemoveDancer, (key) llDumpList2String([avkey,releaseFlag],"|"))
#define MessageSetActiveDancers(number)	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersSetActiveDancers, (key) ((string)number))
#define MessageSetChatChannel(number)	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersSetChatChannel, (key) ((string)number))
#define MessageDCShowAll()	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersShowAll, (key) "")
#define MessageDCLoadAllAnims()	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersLoadAllAnims, "")
#define MessageDCAutoInvite(startFlag)	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersAutoInvite, (key)((string)startFlag))
#define MessageDCReleaseAllDancers()	llMessageLinked(LINK_THIS, Define_DANCERSADMINLINKID, (string)DancersReleaseAll, "")


