
Hi!

Thank you for trying the Fleursoft DanceHUD OpenSource edition!

What did you get?
- Fleursoft OpenSource DanceHUD (wear this) - This is the DanceHUD
  It should start as a everything as full permission items. I wouldn't recommend changing prims or scripts yet - but you can see and poke at everything.

I should note - I do not provide any support at all for the OpenSource edition. I am interested in hearing about any problems, but I won't be in a hurry to resolve them.

I will do anything possible to support anyone who buys the Fleursoft DanceHUD.

If you want support, then buy the Fleursoft DanceHUD product. You'll also get the ability to easily upgrade to newer versions and the ability to easily transfer contents from any object into your DanceHUD. You can also upgrade an open source DanceHUD to a product DanceHUD - so any experiments you do will work in the product :)

How to contact me:
e-mail: fleur@fleursoft.com
Second Life: Fleur Cooperstone
OsGrid: Fleur Cooperstone


Note: The DanceHUD comes empty - there are no dance animations or animation overrides preloaded. You will need to add your own.

For directions on how to get started - visit:  http://fleursoft.com/how-does-work/getting-started/


The open source sources have been updated and are available at: https://github.com/fleur-c/Fleursoft-DanceHUD-Open-Source  You will also find the 'generated' sources all available on the same github site in a subdirectory appropriately named (SecondLife or OpenSim).

There are some product sources that I have not released - this should be understandable :)


Update notes - what changed in this update?

First of all I have to apologize - it's been years since I've made any updates at all. I have several reasons - a dear SL DJ friend of mine died of lung cancer. I had left SL for a few years and couldn't really bring myself to dance after the loss of DJ Ray Trafalger. I've been fighting Multiple Myeloma for the last couple years - treatment has gone well and I'm in maintenance - which could last for 20+ years.

Another part of the delay was rebuilding parts of the dancehud from my existing hud. I'd somehow lost the original git repo of sources over the years. This is hard to imagine... but... over several generations of computers, failed disk drives, without a good backup saved in a safe place always... guess what? You can lose things. Photos, documents and even source code... eek! It took me quite a while to rebuild various pieces of the dancehud...

There are lots of internal updates to the dancehud - things you probably won't notice - other than it's somewhat faster and works on opensim too. I've cleaned up and optimized the code, used an LSL code optimizer and even wrote my own little perl script for yet more optimizations (variables and routine names reduced to one or two characters and more). I've also put in a fair amount of time on opensim(OSgrid specifically) to get the dancehud working there.


Changes and enhancements (you can skip this part if you want... lots of technical details):

- The DanceHUD comes with a maximum of ten active dancers. For every dancer there has to be a script - which is what scripts ~FSDancer 01 through ~FSDancer 10 scripts do. The scripts are all the same LSL/mono code - just a different name. You can add more or delete some of these scripts to change the limit for the number of concurrent dancers. To add more dancer scripts - just open any of the existing ~FSDancer ## scripts - copy the LSL code and create a new script and name it ~FSDancer ## (where the ## is a new number after the end of the existing scripts) and save the new script. You will want to increase the number of possible dancers using a command: /98sd 11 (set the number of active dancers to whatever number you would like).

- Updates are included only with the new version of the DanceHUD. You can also update an open source version of the DanceHUD to a product version of the DanceHUD :)  Experiment all you want with the open source version - and upgrade if you want to have support. Nothing you do will be lost :)

- The default was changed for showing errors to happen while a dance sequence notecard is loaded. I had set this to show errors when you try to dance the dance sequence. I think you should know about errors as early as possible. You can change your admin menu by clicking on the 'Missing dance warnings' option to change from 'On load notecard' to 'While dancing'.

- The inter-script keywords have been enhanced so that they will now take the first parameter as a channel to send. This means that the DanceHUD can send to any other object on whatever channel that object expects. The changed commands are:
    [message ##]message-to-send
    [region_say ##]message-to-send
    [say ##]message-to-send
    [shout ##]message-to-send
    [whisper ##]message to send
Replace ## with whatever channel your dancehud will need to send on for some other scripted object.

- Fixed an error to be clearer. The dance sequence of '[name food] | dance1' - gave you an
error of missing inner parameter. The correct error is that there is a missing outer
parameter. The fix is that the inner parameter should be on the outside - so the
dance sequence should be corrected to: '[name]food | dance1'

- Corrected the default settings for some keywords - the corrected keyword defaults are:
    [loop]   now has a default of 2 loops
        Example: [loop] | dance1|30 | [end]
    [random] now selects 1 of the dances from the available dances in the random grouping
        Example: [random] | dance1|30 | dance2|30 | [end]
    [mix] now select 1 of the dances from the available dances in the mix grouping
        Example: [mix] |  | dance1|30 | dance2|30 | [end]

- Added an older version of ZHAO that works on OpenSim.

- Fixed an interesting interaction - while the dancehud mode was off or dancing, you could
load an AO notecard. On opensim this led you to the AO menu, but not with the AO active
(very confusing). Corrected this so if you load an AO notecard on the admin menu, that
you go back to the admin menu (in off or dance mode).

- Fixed minimizing with the welcome message so that clicking to get the hud back into
place will show you the welcome message again. It seemed strange to me to minimize and
then click to restore and... nothing on the menu at all? Fixed.

- Cleaned up some LSL calls - for example:
  - Changed all llSleep calls (pends the thread on the server)
    (there are other changes like this - see the sources for details on these changes)

- Themes - lots of changes here...
  - Updated the themes to be cleaner than before
    - Most of the theme is using a free font: Bitstream Vera Sans Mono
    - Font Awesome was used for the bottom row of icons and the auto invite (+)
          https://fontawesome.com/icons?c=audio-video to see the characters
          Font Awesome 5 Free-Solid-900.otf - is the name of the free font file
    - The color schemes were started from https://visme.co/blog/color-combinations/
  - Removed the old themes
  - Added updated themes with new colors (basic=black, aqua, blue, green, pink, red,
    yellow and transparent)
  - The Affinity Photo file for the themes was included with the sources (including a Photoshop .psd file) - with layers for all of the parts of the theme.

- Fixed a few bugs - one happened only when using the freestyle dance sequence recorder and having a short default dance animation duration (4 seconds in my testing) - which caused the sequence to have delays of 300 seconds in it.

- Bug in most of the scripts - which didn't reset the script when the owner changed. Fixed - now all the scripts automatically reset when the owner changes :)

- Bug happened where when you were in Dance or AO mode and detached the DanceHUD when you reattached it - the DanceHUD would show you the 'Welcome' message incorrectly and also show the mode set to Off - when it wasn't really. There was also a secondary bug here when you had the DanceHUD minimized and then detached and reattached - the 'Welcome' message would be put on the minimized dancehud - which showed a bunch of white weird pixels above the DanceHUD. Both of these detach/attach bugs have been fixed.

- Improved a few of the error messages. The message sent to a new dancer recommending that they turn off their AO was improved. Now it says: "If you have an Animation Override(AO) on - you may want to turn it off (detected # active animations). It is normal for there to be some active animations - even without an AO. AOs interfere with the synchronized dancing." (replace # with the actual detected number of active animations - usually something like 2 or 3).

It's kind of normal for an animation or three to be active even without an AO. This is because the 'built in animations' are active - can't turn em off... but an AO overrides them so you have much nicer animations instead.

The problem is that there is no easy way to know if an AO is attached and active for sure. The simple answer was to check for number of active animations and if there are none - assume we have no AO on at all.

An improvement to this could be to try to detect if there are any attachments and if they happen to have a name with a string of 'AO' in them somewhere... and if they are attached - and there are active animations - then warn. This is an improvement for a future version.

- Improved the product vs open source separation so that only one script gets replaced and you have a product vs an open source DanceHUD. I used to have code in multiple scripts that were product related. I've consolidated them all into just one script: ~FSProduct. There is an open source version - which is really simple - doesn't do much of anything really. The product version of the script has the complete implementation for update and transfer and a little more.

Fundamentally - the difference between open source DanceHUD and product DanceHUD is this one script. There are a few other things - the themes are all slightly different as they identify the DanceHUD as open source or not. There's also the readme related files - which open source has a simpler version - as you only get just the open source DanceHUD and nothing else. The product comes in a box with more details in the README about what you get and what to do. That's about all there is in differences between them. :) This is really software cleanliness in the end.

- There were other bugs fixed - I don't remember all of them (shrug)


Known bugs to be resolved later:
  - On opensim loading all of your animations may take three or four passes before all of the animations are cached.
  - The load all animations could be improved to not make dancers to no jump all over the place.
