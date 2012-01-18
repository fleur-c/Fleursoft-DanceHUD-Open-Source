
What are all the scripts?

There are a LOT of script in the dancehud - so what does each of them do?

~FSChat - mostly this script it is all about handling the typed commands
          (for example: /98whatever). This includes the fkey command which
          you can bind to a function key to toggle a set of commands.
          The handling of typed commands is basically very simple - parse
          the command a little bit and try to get other scripts to do the
          hard work. If we can't figure out the command - we guess that it
          is the name of a sequence and send it over to the ~FSUI script.
          
          The help dialog box is in this script. I tried hard to make
          the /98help command generate a dialog box that would help - so it
          doesn't do much - but the things it does are what you may need
          for when you need help.
          
          This script also has the 'Load all the animations' functions here
          (it was a script that had some space so I put that menu in this
          script). We talk with the ~FSDancers and ~FSDancer scripts to
          be able to do this.

~FSDance Control - this is the script that does the dance sequence commands
          that you would see in any dance sequence. It's basically playing
          back the time ordered sequence that came out of ~FSPrepare. Any
          keyword that has something to do - we do a binary search for the
          command and call a little support function (well... we use the
          LSLPlus pragma inline option to not call a function at all). 
          - This module also handles the timing of a sequence - the timer we
            use tries to get the script running a little bit early (as the
            timer has some latency built in) and we loop a little bit for the
            timer to be as accurate as possible. Generally the timer is within
            about 1/100th of a second or so. This can vary up to 1/2 of a second
            (depends on the sim and lag and more).
          - This is the script that sends out the dance requests to the various
            groups (using the multicast linkid's that are talked about in
            readme-linkmessages.txt).
          - The freestyle recording is mostly done here. We remember each
            dance animation and the delay between then - when we get a
            'stop dancing' request, the new freestyle sequence is sent along
            to be remembered.
          - This script also asks for a wait sequence - once the current
            sequence has finished (or the default delay expires).

~FSDancer - there are as many copies of this script as you have want to have
          for dancers on the dancehud. Each dancer is associated with one
          of these scripts. Each dancer can have a list of active animations
          (depends on the groups in the sequence) and so we can stop/start
          animations based on index or all of them.
          - The 'sync' option for getting dancers all in sync again is in
            this script (we stop, play a stand animation for .5 seconds, stop
            the stand animation and then start the animation we want to be
            synchronized on).
          - This script handles the asking the avatar for permission to dance
            and handles if they say yes or no or the request times out.
          - The group setting for each dancer has a menu that is in this
            script - so you can set a dancer in any of the groups.
          - Support for a couple other things - giving a dancer an item,
            loading animations quickly (each dancer is given a list of ten
            animations to start/play for 0.1 seconds/stop) and a little bit more.
          - We also handle the case where the dancer teleports away or crashes.
            The cheap way to detect this is to call llGetAgentSize() - so we
            can easily/cheaply detect the avatar is still present or not.
          - The ~FSLanguage script will send instant message strings to a new
            ~FSDance ## script when someone is added - so that we can tell them
            how to stop, that their AO is still on and welcome to the group.

~FSDancers - this script essentially is for handling the collection of dancers.
           - We remember who is dancing, was added or removed
           - Also handle the automatic invite here
           - There are a couple of menus here - adding and removing dancers,
             menu for selecting which dancer to change dancing groups on
           - Selecting which script a dancer will get and managing the active
             ~FSDancer ## scripts (stopping or starting them - as needed)
           - This is THE script that has a sensor for 50 meters around the
             owner of the dancehud and picks up the closest 16 avatars.
           - We also look for changes in inventory here - so new ~FSDancer ##
             scripts get added to the possible 'controllers' (I used that name
             for a list of the link ids of each ~FSDancer ## script). If you
             delete an ~FSDancer ## script that has someone dancing on it - that
             person will stop dancing and we'll remove them from the list
             of dancers.

~FSDebug - has one major purpose in life - capture and print the link messages
		     as they go floating by.
		   - secondary aspect - be able to print out what a dance sequence
		     looks like.

~FSLanguage - I waffled a bit on this script. This script is here to simply
             make printing messages (or sending a few IMs to dancers as they
             are added) independent of the scripts.
           - It starts up and reads the ~FSErrors notecard to get a list of
             the possible messages that it could print.
           - When it gets a message - we look up the 'special code' for the
             messages, perform any substitutions for strings in the output
             string and then - either send it to the owner only or send it
             to the specific ~FSDancer ## script (by linkid).
           - This means that if the messages in Errors-English were translated
             into another language (or a dozen) that we could have the messages
             show up in whatever language you would like. I have not pursued
             this at all - but thought that we're an international virtual
             world - we should be able to have different languages.
             If/when this happens - I'll add an administrative menu to help
             select which language would you like to use.
           - Meanwhile - you can change this file however you want and whatever
             you put in it will show up when the script wants that message
             to be printed or sent to a new dancer.

~FSLists - 

(still adding more information here...)
