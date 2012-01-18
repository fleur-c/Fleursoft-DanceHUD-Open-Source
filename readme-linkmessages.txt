Link messages - the DanceHUD uses them all over the place...
so let's cover a couple of basics.

First of all - the calls to llMessageLinked are all in the include/*
files. This was to make it look like a function call to me and so that I
would provide a clean interface between what the caller needed and what
the receiving script would get.

I use the first integer parameter almost always to define the kind
of thing the message is directed at. If I need to read a notecard, then
I send a message to the 'FSRead' module. Seems like a string would have
worked - but I used the first integer instead. This means that all of the
scripts have a 'link_message' routine in the default state.

The link_message routine first filters out any messages not for this particular
script and returns right away. How come? Because all link messages are sent
to ALL of the scripts in the containing object (the LINK_THIS parameter).
I need multiple scripts because the scripts get too long in just one script
all by itself... so dropping messages not needed for a script has to happen
quickly (leads to less lag this way).

This is why most of the scripts look like this (more or less):

 	...
	if (-1 == llListFindList([Define_UILINKID, 0], [num]))
	{
		return; // Not our message - poof - go away quickly
	}
	...

There are variations on this in a number of the scripts - but most behave
this way.

What is special about message link id 0? I used it for RESET of all of
the scripts - so all of them have a way to be reset nice and simple.


Ok - the second integer parameter generally is a command to tell the script
what I want to get done. I use strings once in a rare while - but mostly
a nice integer will do the trick. Some of my older scripts still look for
a string - like FSRead. But most of them will use an integer.

FSDancer for example takes a number of different commands (straight from
the include/Dancer.h file):

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
 
The next parameter is usually the things that are needed for the command
to do something interesting. Like with the FSDancer script - the DanceIM
command for example just takes a string and has the dancer receive it as
an IM. The different types of commands take different types of parameters
and I generally seperate out parameters in the string with a '|' character.

So basic communications between scripts - pretty straight forward - send a
message to a specific id and command and the parameters (more or less).

Where do the id's for the scripts come from? I made them up. In the
include/LinkIds.h file you will find ALL of the id's that I made up for
each of the 'kinds' of things that needed to be done in the DanceHUD.
I'll caution you - there are a LOT of them in there. But each one of
them is basically nice and simple to understand.

Let's take a look at these messages in a live DanceHUD. Included as part
of the DanceHUD is a script called FSDebug. It has a couple of jobs in the
world - but one of it's jobs is to listen for every link message and then
just plain old print it - you need to enable this feature... so - let's try
it out. You need to type two commands (need to be in world, DanceHUD attached
and ready to go):

    /98debug on
    /98debug print

Now just click on the DanceHUD - anywhere will work. What you will see are
the link messages (made into text to see them) as they go between the various
scripts in the DanceHUD. The output is only sent to the owner of the DanceHUD
and there is LOTS and LOTS of output. Click the 'A' for the administrative menu
and you'll see what I mean. It looks a lot like this:

--- put in an example here FIXME ---
134.123@FSD:12123412:103|0|30|12123408:

Let's turn off the debug printing so you don't go blind:

    /98debug off

Now let's take this apart a little bit at a time - so you can see why these
messages show up and how you can use them to debug your changes/additions.

The message printed starts with a timestamp (seconds of running of the ~FSDebug
script and parts of a second), followed by a 'FSD:' (to identify the debug output).
Next we see the link id where a messages was being sent to - look up where
they are going in the include/LinkIds.h. The next two parts are the strings
that come in on the link message. The second string is documented as a 'key'
but a 'key' can be a string - so I use it as a way to pass around a string
between scripts.

In this example - when we clicked, the ~FSUI script noticed the click and
saw that it was on the 'A' part of the menus part of the user interface.
This means that we want to go to the administrative menu. The admin menu
link id is defined as:

#define Define_ADMINLINKID 12123412

Fortunately - we see a message going to link: 12123412.

Eeps - why use 121234? Because I liked a song by The T's called
1,2,1,2,3,4... :) I needed some numbers and these were as good as
any other numbers. I saw them as the same as 'I love you' from the
song.

Where would we find the code that translated the click into a message?
~FSUI script - look in FSUI for the 'touch_end' routine and you will see
that about on line 658 we found out that the click was on the menus prim
and we then calculate the horozontal offset and find out which menu that
we need to go to - so we call GoToMenu() and that routine takes the menu
number and translates it into a linkid of where to go and we send out a
link message for? A menu range? That's odd - but we'll go with it. In
fact - what you see is really a menu range. The FSUI script is asking
for the link id of the administrative menu (12123412) which we looked up
in the touch_end routine. The parameters for the 'get a menu range' happen
to be 103 (List_GetMenuRange) - followed by the parameters for the menu
range: 0 (start at the start of the menu), 30 (for the # of lines to display
on the user interface), and the link id of where to return the results of
the menu range... the user interface (12123408).

We'll get to what that means when I explain how the menu system works... we're
here to learn what the message system is all about first.

And the rest of the FSD messages are all of the same kind of flavor.

But that's not quite all of the kinds of messages you will see in the
DanceHUD. These simple messages are just one way - go do something and
send the results somewhere. These are really just a fancy way to call
a function - over there instead of in 'this' script'.


The second kind of messages that you'll see are what I call multicast
messages. These are messages that are directed to ALL of the dancers
of a particular group - or maybe just ALL of the dancers. Instead of
sending each dancer a message 'please dance now' - it is much easier
to send one message to 'all' of them. And it has the nice property that
if each of the dancer scripts wake up on the message at the same time...
then the dancers will continue to stay in sync. Very nice feature.

How do we do these multicast kinds of messages? They are really the same
kind of linked message - just that the link id is a slightly different
kind of number. Let's look at the base number that we start out with
for dancers:

#define Define_DANCEGROUPS 303181824

This is a weird looking number. It happens to be the same as the hexadecimal
number: 0x12123000 - I reserved the low order 3*4 (12 bits) so that it was
possible to multicast to different groups. The 'All' group of dancers is
simple the number '0x12123001'. The ~FS Dancer 01 to 20 (or more) look
for this magical value as a link id and if they find it - they know that
whatever command is sent to them - that ALL of the dancers should do it.

The same basic math applies for all of the other 11 groups that are defined
in the include/GlobalDefinitions file:

list Define_GroupNames=  ["ALL", "FEMALE","MALE","LEAD", "LEFT","CENTER","RIGHT","GROUP1","GROUP2","GROUP3","GROUP4","GROUP5"  ];
list Define_GroupBits=   [ 1,     2,       4,     8,     16,      32,     64,      128,     256,     512,     1024,     2048   ];
list Define_GroupAliases=[ "|",   "|",     "|",   "|",   "|",     "|",    "|",     "|",     "|",     "|",     "|",      "|"    ];

To send a message to all of the 'FEMALE' dancers - we send a message to the
link id of: 0x12123002. All the way up the groups this works wonderful.

It's interesting - as this is how each of the [group] keywords is handled
by the FSDanceControl script. But even more interesting is that FSDanceControl
doesn't much know who it is sending commands to - it is only following the
directions of a time ordered sequence from the FSPrepare script. These are
details that don't matter to many folks - but kind of interesting to see how
the basic parts of LSL can be used to do things in interesting ways.


There is sort of one last exception to the above rules of how I do link
messages. For the '/98n sequence name' command - we send a multicast message
out to all of the '~FS Menu 01' to '~FS Menu 10' scripts. The hope is that
the 'sequence name' will exist in one place and only that one script will
reply. If none of the other scripts reply - then we will have found the
'sequence name' faster than serially checking on each menu for it.


That's really how all of the messaging happens within the Fleursoft DanceHUD.
More specific details as to what each message means and their parameters or
what is a menu range and such - those are beyond the description of just
messages themselves. :)


The following was my internal documentation on how the specific link messages
would be handled. Some of the calls are missing and some are even incomplete.
With this mapping - it was much easier for me to know what I should expect
to see as messages would flow around between scripts.


These are ALL of the linked messages that we use in these scripts:

ReadNotecard:
	Input:
		load|<notecard name>|menu link id
		<menu #> is a number in the range of 1 to N - where we will send the
			appropriate messages for adding sequences (ADDSEQUENCE) and setting
			the menu name (SETMENUNAME) - and that's all we send to it.
	RESET - reset everything
	
	Output: LOADED|<notecard name> (key)user-defined-aliases-last-set - sent to the UI link id

ReadNotecard will take any dance sequence notecard and read it and parse it into tokens which are
the tokens as defined in the Keywords file. We parse the keywords and dances into a list and send
the whole sequence to the menu list item.

Let's cover the keyword conversion first - note - the keyword #'s may change in the future!
(Using %% as the filler for the keyword # - which is in include/Keywords)
[ALIAS grp1]grp2	-> %%|grp1|group-index|grp2 (adds an alias of grp2 to the grp1 group name - handy for how you see a group of dancers named)
Dance1   or
[DANCE]Dance1		-> %%|Dance1		(play this animation)
					-> %%|Dance1|<multicast setting>|<1=start,2=stop>|<dance index> 
					- for prepared dances we added a multicast setting (which group of dancers does this animation go to) AND
					- the start/stop bit (1=start, 2=stop) AND
					- <dance index> = dance # for the dance controller
##.# or
[DELAY ##.#]		-> %%|###		(sleep for ##.# seconds - # multiplied by ten and turned into an integer)
									Note: Delay of 0 for forever,  -1 for when the dance is NOT followed by a delay
[DIALOG]str,buttn*,##	-> %%|str,buttn*,##	(put up a dialog box- may have many buttons - up to a dozen)
[END]				-> %%			(end a loop)
[GROUP <SAME|DIFFERENT>]groupname	-> %%|<SAME|DIFFERENT>|groupbit|groupname|starting-name -	Start a dance segment for a group of dancers in groupname
                                       SAME is an option to indicate same selections as previous group, default is SAME
                                       - unclear that the option is SAME or DIFFERENT
[IM]string			-> %%|string		(send an IM to all the dancers)
[LOOP <#>]			-> %%|#  (or  9|2  when no #)  (starts a loop of # for some dances)
[MENU <#>]str		-> %%|#|str		(sets menu name to str for menu # - default is the menu we started with)
[MENUSTYLE <#>]style ->%%|style		(sets the style for that menu # (or default menu we are on))
[MESSAGE <#>]str	-> %%|#|string	(sends a message to channel # - default is 0)
[MIX #]				-> %%|#			(start a mix of # dance routines from following set of dances until the [end])
[NAME]string		-> %%|str		(set the sequence name - defaults to first dance name if not set)
[NEXTSEQUENCE]str	-> %%|str		(stops current sequence, starts str sequence of current menu)
[OWNER_SAY]str		-> %%|str		(send a string to the owner of the item)
[RAND ##.#< ##.#>]	-> %%|### ###	(randomly delay for first ### then delay for ### - numbers times 10 to integer)
[RANDOM <#>]		-> %%|#			(randomly select # dance(s) from following sequence, default of 1)
[REGION_SAY <#>]str	-> %%|#|str		(say something to region on channel #) - defaults to channel 0
[REPEAT]			-> %%			(repeat sequence from beginning)
[SAY <#>]str		-> %%|#|str		(say something to channel #) - defaults to channel 0
[SETNAME]str		-> %%|str		(set the name of the HUD to str)
[SHOUT <#>]str		-> %%|#|str		(shout something on channel #) - defaults to channel 0
[STOP]				-> %%			(stops current dance sequence)
[STYLE]style		-> %%|string	(remember current dance style)
[WHISPER <#>]str	-> %%|#|str		(whisper to channel # something) - default to channel 0

There is an order to several of these keywords in the resulting list:
- The first keyword is always a [name] - it could be the name of the first dance or simply the first tag or the user defined name

These all are strung together in a list for the completed sequence. The idea is that everything
is reduced to a keyword # and easily parsed data so that there is no basic parsing error handling
in the execution of dance sequences at all - may encounter errors in missing dances, but that'll
be because the user deleted it from the HUD after loading the notecard.

We encode the sequence with seperators of "|||" between each keyword - so:
	Dance1|30|Dance2|20
Translates into:
	%%(name)|Dance1 ||| %%(dance)|Dance1||| %%(delay)|300||| %%(dance)|Dance2||| %%(delay)|200 (avoiding the #'s of the keywords here...)
Which will easily become a list of: ["%%|Dance1", "%%|Dance1","%%|300","%%|Dance2","%%|200"]

With the change to add start/stop bits (this is what the FSPrepare script will do):
	%%(name)|Dance1 ||| %%(dance)|Dance1|1<grp>|1<start>|0<index>  ||| %%(delay)|300||| %%(dance)|Dance1|1<grp>|2<stop>|0<index> 
	%%(dance)|Dance2|1<grp>|1<start>|0<index> ||| %%(delay)|200 ||| %%(dance)|Dance2|1<grp>|2<stop>|0<index> 

Last phase - optimize the time sequence - so remove the un-needed dance stops (also in FSPrepare):
	%%(name)|Dance1 ||| %%(dance)|Dance1|1<grp>|1<start>|0<index>  ||| %%(delay)|300|||
	%%(dance)|Dance2|1<grp>|1<start>|0<index> ||| %%(delay)|200 ||| %%(dance)|Dance2|1<grp>|2<stop>|0<index> 
This is the directions needed for the dance control and dancer - the start of Dance2 will replace Dance1
in the dance controller - which is why we could remove the stop of Dance1.


MenuList/Inventory related menu commands:
	Input: (changed to integers in global definitions and cleaned up order of parameters)
		(List_AddSequence)|<sequence name>  (key)sequence-with-|||-as-seperators of list entries - add a dance sequence
		(List_RemoveSeq)|<sequence name>   - remove a specific dance sequence (returns a FORGOTSEQ to UI link #)
		(List_SetWait)|<sequence name>|<indicator>|<direction> - sets the default wait sequence or menu - seqname may NOT be here!
				  <indicator> = 1 for setting a default wait sequence, sequence name is the default wait sequence
				  <indicator> = 2 for setting default wait sequence menu and then direction is passed in
				       <direction> is an enum (1=top to bottom, 2=bottom to top, 3=random)
				  Default is that the wait sequences are top to bottom - can change at any time.
		(List_ShowSequence)|sequence-name - display to the owner the specified sequence
		(List_Select)|<#>|linkid#- select an item and do what it requires - this is really GetSequence for non-dance menus - handy for administrative
			menus - like add dancer and such - this was GetSeqNumber...
				  The select number is based on what was on the menu item (from the range - link id then # - this #). Same as GETSEQUENCE otherwise.
		(List_SelectString)|'string'|linkid# - same as Select - but with a string instead - this is for unconstrained menus when the user is allowed
			to type a '/99#43' or '/99something' - which could be that something is on the current menu for unconstrained menus and we look it up
		(List_GetMenuRange)|<start #>|<return link id>|<# entries to return> - get a block of sequence names - Returns ITEMS
						Start # CAN be 0! As we know that each list starts at 0! (UI starts lists at 1, but NOT ANYTHING ELSE!)
		(List_ClearMenu)  - clear all entries for this particular menu (returns a CLEAREDMENU to UI link #)
		(List_GetWaitSeq)|link#  - returns a wait sequence that is already prepared - ALWAYS returns a WAITSEQUENCE
						(may be a stand_1 built in animation... but always returns one) - and we bounce it through PREPARE!
		(List_SetMenuName)|menu name  - sets the menu name to whatever the user said in '[MENU #]name' - default name of 'Menu #' (1 to N)
		(List_AddFreestyle) (key)sequence-with-|||-as-seperators (only dances and delays) - must add the sequence as a freestyle AND add a name.
		(List_ShowSequences) - display ALL of the sequences of this menu
		RESET - resets the menulist to defaults (no sequences, menu name back to default, all variables cleared)

	Output:
		ITEMS|menu name|total # entries for menu|starting #|<constrained menu flag>|<menu linkid>[|<hightlight #>]  (key)item name|menu link id|menu item #[|optional stuff] with ||| seperators - or ""
							(key) "" if we do NOT have that that many names (start bound)
							<flag> = 0 for constrained to menu items (admin menus), 1 for not constrained (menulist)
				Optional stuff catagory - actually menu item# and beyond - these are used to decide in the select routines
					for dancer - we reuse the same select for generating an ITEMS list AND for setting a flag - so we use
						the optional fields - menu item# =0 - means generate an ITEMS list of flags - we send the whole list always (expecting it will fit in the GUI)
						menu item# > 0 - is selection from the ITEMS list which is always +1 (so 1=back, 2=first flag, etc) and option=bit to set
					WHEN an item is selected - we send the 'Select'|<menu item #> to the specified <menu linkid>
					Hightlight# is optional - only sent for admin menus that have things that are pre-selected - like the
						admin menu for selecting the wait sequence menu - it's highlighted when you get to that menu for
						the menu that has setting (wait sequence menu)

		SEQUENCE|sequenceName|<menu link#>  (key)sequence (with ||| for list seperators)  or (key)NULL_KEY (for not found)
			Note: A prepared sequence will have transformed the [DANCE] keywords (see keywords above)
		WAITSEQUENCE|sequenceName    (key)prepared sequence
		WAITMENU|sequenceName        (key)prepared sequence
			The dance control script uses this to decide if the wait sequence has changed or not..
		CLEAREDMENU - for when we forget the complete menu - sent to UI link #
		FREESTYLEADDED (key)seqname - when we added a freestyle sequence - sent to UI link #

This is the menu storage scripts - there are 10 of them, the link # is calculated for the script based on
the name of the script (Name = menu 1, Name 1 = menu 2, etc).


InventoryList: Same interface as MenuList, except it operates only on inventory. All MenuList input
are received, and the output (GETSEQNAMES, GETSEQUENCE, GETMENUNAME) are all sent correctly based on
the inventory. The sequence returned is: "2|Dance|||4|0" - so dance of item to lookup, delay of 0 (forever)
This is indistinguishable from what MenuList does - so the GUI can call either and not care at all.



MenuList - lite - basically admin menus - is a subset of MenuList
	Input:
		MenuLite_GetMenuRange|<start item #>|<return linkid>|<# of items to return> - returns an ITEMS list
		MenuLite_Select|<item #> - from the getrange results


PrepareSequence - simply takes a sequence in and prepares it and sends it to where the link id directs...
	Input:
		(prepare)1|sequence_name|linkid-to-return-results|reply-string  (key)sequence  (output of Prepared)
	Output:
		(prepared)reply-string|sequence_name (key)prepared_sequence


Debug capture script
		(showsequence)#|sequence_name (key)sequence - show the sequence to the user


FSDancer:
	Input:
		(START)  (key)dance index#|animation name|<stop others>   - starts an animation at index# or an animation name
				<stop others> = 0 do not stop other animations, 1 do stop ALL secondary animations (and possibly just replace index # animation)
				2 = sync the animations(??) - right now using TRUE/FALSE
		(STOP)    (key)dance index# (or) (key)1024   - stops a (or all (for 1024)) dances
		(ADD)      (key)Avatar name|avatar-key|animation-to-start|channel-number-to-listen-on - does not send a response, just talks to owner
					 - requests animation control - waits up to 60 seconds, also starts a wait animation name as dance #0
					   This request bounces through the dance master to get the animation to start... :-)
					 - Channel-number-to-listen-on - is the channel for non-owners to send chat commands to us. It is
					   calculated from the base channel # of the hud + dancer # (which is dancer linkid - base dancer link id)
		(SETFLAGS)  - (key) bits - sets the flags for this script (used to filter requests) (range of 0-4096 - use bits)
		(GETFLAGS)  (key)Link# to return to - Sends back a: cmd=GFLAGS|<avatar name>  id=flags
		(GETDANCER)   - (key)link# - requests all dance controllers to return the name of their dancer (if any)
		(IM)|(from)  - (key)msg - send an IM to the dancer in the group - for owner (from) is not set
		(DANCETIMER)  - (key)ON or OFF - enables/disables showing the duration of every dance - for the FIRST dancer only (owner)

	Output:
		DANCERNAME  (key)Dancer name | controller link # (to be able to send requests to that dancer)
		MCFLAGS|Dancer name  (key)multicast flags

The FSDancer is the script which we make N copies of - one for each possible dancer. We can have any number of dances active for
a given dancer. Also have the ability to send a specific dancer a dance, or a group broadcast of dance this dance. Each script has
a flag for multicast - so we can set up to 12 bits of dancer flags - which is more than we need. This can be used for different
dancer attributes - but when we add them - this is how you get female/male dancers seperated by dance.

Interesting - the dancers each get their own channel - Chat doesn't know about it at all. Each dancer
has their own channel 98 which the dancer can '/98stop' to stop dancing. The dancer script filters
only for the specific dancer and no one else - so very little overhead for this feature.


DanceControl:
	Input:
		(STOP)  ##   - stop dancing (all dancers stop)
		(SETACCURATETIMER) ## (key)ON or OFF - enables/disables accurate timing - so dances will be timed more accurately (or not) - adds to LAG some
		(ADDDANCER) ## (key)Avatar name|avatar-key|link#-to-respond - passes through an add dancer
		    request to the correct controller and also adds the dance last started. When dancing - we always have a current animation
		    - if they start dancing - we are sent a SEQUENCE before anything happens - default is "stand_1"
		(REMOVEDANCER) ## (key)Avatar name|<flag>  - flag=0 for not releasing from Dance, 1=send msg to release from Dance script
		(REMEMBERDANCES) ## (key)Menu# to receive sequence  - starts recording all animations danced/delays too. When we get a STOP or SEQUENCE, then we send
		 	the list to the appropriate dance controller as a freestyle to add (i.e. no name) - we keep recording till another rememberdances or STOP comes in
		(SYNCDANCERS) ## - sync all dancers to start of previous index 0 dance (cancel all other animations)
		(IM) ##|<name of sender> (key)IM to send- send an IM to all the dancers
		(Set active dancers) ##  (key)<# of active scripts> - sets the number of active dancer scripts
		(Set channel #) ## (key)<# of channel> - sets the HUD channel number (avoids dancers channels)
		RESET - need to reset everything to defaults
	Output: WAIT - sent to services to get a wait sequence (we never remember it at all - always ask and a SEQUENCE will come back to us)
		(UI)StartedSequence# (key)sequence name | menu link id - indicates that we started a particular sequence (so the UI can know)
		      we do this so that we can highlight the sequence or item on the menu that we are dancing.

On starting dance mode - the UI will send a 'get wait' to services which sends it to dancemaster. We start the sequence - even if there are
no dancers - the next message will be to add the owner which will be sent the 'link 0' message as a sync - and that will be a wait to get started.

		
Language - does substitutions for error messages and prints them
Input:
	(str)Message-String (key)list of parameters seperated with "|"


Chat - only handles parsing of chat commands and sends requests all over the place


User interface:
Input:
	(Return to user menu) - sends us back to menu # 1-N or Inventory
	(Go to menu #) (key)<menu #> - sends us to user menu #
	(started sequence)  (key)<sequence name>|<menu link id>  - for indicating we started/stopped a sequence
	(Load notecard) (key)notecard - UI knows the current user menu (no one else does) - so tell the UI
		to look it up and send the Read request over with the correct user menu linkid
