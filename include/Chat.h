// Interface defintions for the FSChat module - takes in commands from the user (or via linked messages) and does parses/executes them


// Define the commands for the chat script
#define Chat_ChangedChannel 1
#define Chat_ErrorMessage 2
	// Handy for getting an error message with the chat channel # added as the last parameter
#define Chat_LoadAllAnimations 3
	// Start loading all animations on all dancers concurrently
#define Chat_ContinueLoadAllAnims 4
	// Message back from the last dancer script that indicates it has successfully loaded all it's dances

// Define the list menu item selection (cancel) for loading animations
#define Menu_CancelLoadingAnimations 1
	// Only really one command on the load animations menu - cancel


// Command numbers within Chat (never gets outside of FSChat module)
#define Define_CmdDance 10
#define Define_CmdDebug 20
#define Define_CmdDefer 30
#define Chat_DefaultDuration 40
#define Define_CmdFkey 50
#define Define_CmdGive 60
#define Define_CmdStop 70
#define CmdSetActiveDancers 80
#define CmdSetChannel 90
#define Define_CmdHelp 100
#define Define_CmdList 105
#define Define_CmdMenu 110
#define Define_CmdMode 120
#define Define_CmdReset 130
#define Define_CmdRemember 140
#define Define_CmdSync 150
#define Define_CmdWait 160

// Help commands (recenter hud, show everything, stop everything, reset)
#define Define_Help1 1500
#define Define_Help2 1510
#define Define_Help3 1520
#define Define_Help4 1530

#define ListAnimations 1
#define ListDances 2


// Define the globals for the chat user interface
#define Define_DefaultChannel 98
	// Default channel that the dance hud listens on for the owner (dancers get a different channel # that is this+something)


// Messages to Chat module
#define MessageParseChatCmd(command)	llMessageLinked(LINK_THIS, Define_CHATONLYLINKID, (string)"CMD", (key) command)
#define MessageChangedChatChannel(channel)	llMessageLinked(LINK_THIS, Define_CHATONLYLINKID, (string)Chat_ChangedChannel, (key) ((string)channel))
#define MessageChatError(errorcode)	llMessageLinked(LINK_THIS, Define_CHATONLYLINKID, (string)Chat_ErrorMessage, (key)errorcode)
#define MessageChatLoadAllAnims(dancerLinkidsList)	llMessageLinked(LINK_THIS, Define_CHATONLYLINKID, (string)Chat_LoadAllAnimations, (key)llDumpList2String(dancerLinkidsList,"|"))
#define MessageChatContinueLoadAllAnims()	llMessageLinked(LINK_THIS, Define_CHATONLYLINKID, (string)Chat_ContinueLoadAllAnims, (key)"")

