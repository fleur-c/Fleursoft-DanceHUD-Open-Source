Hi!

Welcome to the open source version of the Fleursoft DanceHUD.

Open source? Yes - I'm glad to share just about all of the secrets
from behind the scenes on how I created the dancehud and what all
it does.

I'm using a Creative Commons Attribution 3.0 Unported License
(http://creativecommons.org/licenses/by/3.0/). Basically this means
that the sources are all available on githud at:
   https://github.com/fleur-c/Fleursoft-DanceHUD-Open-Source
The idea of this license is that you can use them for whatever you
would like. Build a product, sell it, whatever.

First things first - What is this DanceHUD thing and what is going
on within it? Essentially - the dancehud helps people dance in
virtual worlds. Add some animations, maybe a dance sequence that
uses the animations and tada - nice dancing. That's just part
of the story - the intent was that the Fleursoft DanceHUD would
work on multiple virtual worlds.

OpenSim LSL scripting is 'in theory' 'exactly the same' as LSL
scripting within Secondlife (copyright - trademark and wave of
queen's hand over the terms of service, as appropriate). Theory
is not the same as reality. I have a few places which are different
based on the platform - this is controlled by setting a definition
in the include/GlobalDefinitions - define either BUILD_FOR_SL
or BUILD_FOR_OPENSIM in that file.

Generating - that's an interesting word. A lot of scripts are
completely self contained - every line, comment, indent are all
included in the script in world. The problem with this is that
you can't do some things at all - like have a set of constant
values that you 'share' across different scripts. How about trying
to share subroutines even? Hard to do this in world. It would
be easier to 'include' some constants and subroutines and have
the 'right' thing happen... well - I like the 'right' thing so
I built my environment up out of several pieces... we'll get to
the details in a little bit.  The scripts in this archive are
all input files - including comments and include commands and
even some commands to generate some include files and cleanup
the output. Once the input scripts are run through a building
process - we end up with plain old, cleaned up (no comments or
indents) LSL code that works in different virtual worlds. Slick.

To do this magical thing - you need some software to help out.
I build on a MacBook Pro with Mac OS X High Sierra - I'll take a guess
at the same types of tools for Windows... but I don't do Windows...
Tools you'll need for Mac OS X:
- XCode - for make
- mcpp - this is a C pre-processor (http://mcpp.sourceforge.net)
- perl - Used to generate some LSL code, cleanup/optimize the
  python generated code (built in with XCode/MacOS)
- lslint - LSL Lint (https://github.com/Makopo/lslint) - lets you
  check if the lsl code you have is 'correctly formed'. This is
  a very paranoid syntax checker - caught a couple of errors for
  me.
- LSL-PyOptimizer - an LSL code optimizer in python 2.
  (https://github.com/Sei-Lisa/LSL-PyOptimizer.git) I use this
  to help optimize my LSL code. Handy - it's not completely
  finished - but does a very nice job.
- Photoshop - or some other graphics editor (I'm using Affinity Photo)

I have not tried to build on other platforms. The same tools are available
pretty much anywhere so it shouldn't be a problem.

I've installed the lslint and LSL-PyOptimizer into /usr/local/bin so
that they are on my PATH which just means that I can use them from
anywhere on my system. The LSL-PyOptimizer needed links for all of
it's top level directory to work.

How do you build the scripts for the dancehud?
1) Clone a copy of the sources from the git repository to a local repo:
     Something like:
         cd Documents/workspace 
         git clone https://github.com/fleur-c/Fleursoft-DanceHUD-Open-Source

   This will download the DanceHUD source into a new local directory
   named: Fleursoft-DanceHUD-Open-Source

3) The Makefile has all of the logical to build the DanceHUD - it should
   be as simple as get into a shell in the source directory and type 'make'.
   This will build all of the lsl scripts which are to be uploaded.

Fleurs-MBP:Fleursoft-DanceHUD-Open-Source fleur$ make
./GenerateKeywords
mcpp -I- -P -I. -Iinclude FSChat | python ../LSL-PyOptimizer/main.py -O -ListAdd,+AddStrings,-OptSigns,-OptFloats - | ./FSOptimize > FSChat.lsl
lslint -m FSChat.lsl
TOTAL:: Errors: 0  Warnings: 0

   The './GenerateKeywords' command generates two files in
   the 'include' directory: Keywords and KeywordSearch

   There are two commands for each script. The first set of
   commands creates the lsl script to be uploaded. The steps
   are to use the C PreProcessor first which expands any macros
   which I have to create some lsl code.

   These are simple include files which are '#include'd where
   they are needed - so all over the place the input source
   files will reference keywords by a symbol - for example:
   the [DANCE] keyword in a sequence - has a value for the
   token when it's in a sequence - the value is substituted
   all over the place where I wrote 'keywordDance' - the value
   of '2' shows up. Very handy - so if I add keywords - the
   token values can all change - and the input scripts do NOT
   need to be changed at all. I'll skip over more details right
   now - we'll get to the more details in a while.

   
   The python command is to use the LSL-PyOptimizer which help
   optimize the code... this step does a lot - think of it as
   making the code faster and a bit harder to read lsl, but not
   so bad. I really like a lot of what this optimizer does.
   
   The last part of the first command line is FSOptimize which
   is my own really simple minded lsl optimizer. It does a number
   of things that I thought would help my lsl code. The code for
   my optimizer is only in FSOptimize - which is written in perl.
   Lots of details there - the effect of the script is to squash
   the whole lsl script down - remove extra spaces, rename variables
   and routine names to one or two characters and a bunch of other
   things. It's not perfect... far from it... but it helps to make
   the dancehud scripts here squished way down in size. The lsl
   code becomes much harder to read... but it's a lot smaller too.

   The second command line is a lslint which checks the syntax of
   the scripts to see if they appear to be valid lsl. The idea
   is that lslint can find syntax errors - problems with the
   generated lsl script before I ever attempt to upload it.
   I found a number of bugs with lsllint and also corrected
   a number of my bugs in my FSOptimize script. Handy for me.
   If you don't want to install lslint - then simply remove all
   of the lsllint commands from the Makefile :)

4) Login to SL/OpenSim and now you need to use a couple of scripts which
   will build the pile of prims that will become the DanceHUD Open Source.

   Go into Build mode in your viewer - and create a cube on the ground.
   Edit the cube and copy/paste in the contents of PrimScript
   into a 'New Script' in the 'Contents' tab of the cube. The PrimScript
   script simply lets the building script set the names of the prims
   once they rez. Also change the permissions of the object so that
   'Next owner' has modify, Copy and Transfer set. Close the edit window
   and 'Take' the object (right click 'Take') into your inventory.
   It will show up in your inventory in the Objects folder.
   
   Rename the cube (which is named 'Object') in your 'Inventory/Objects'
   folder to be: Cube
   
   Create another cube on the ground. Edit this one and go to the
   contents tab.
   
   Drag in a copy of the 'Cube' object to the contents of the new 
   
   Create a 'new script' there and edit the script and copy/paste in
   the contents of the 'BuildHUD' script.
   
   Upload the textures for use in the DanceHUD - these are in the
   Themes directory - upload and rename them as follows:
   
    Themes/~FS Theme Basic.png -> ~FS Theme Basic
    Themes/~FS Theme Aqua.png -> ~FS Theme Aqua
    Themes/~FS Theme Blue.png -> ~FS Theme Blue
    Themes/~FS Theme Green.png -> ~FS Theme Green
    Themes/~FS Theme Pink.png -> ~FS Theme Pink
    Themes/~FS Theme Red.png -> ~FS Theme Red
    Themes/~FS Theme Transparent.png -> ~FS Theme Transparent
    Themes/~FS Theme Yellow.png -> ~FS Theme Yellow

   Copy the eight textures you uploaded into the contents of the cube
   on the ground.
   
   While you are there - create a notecard (in your inventory) - name
   it ~FSErrors and put the contents of 'Errors-English' (skip the ''s)
   into that notecard and put the notecard in the contents of the cube.
   
   One more thing to copy in is the contents of the appropriate readme file
   (for SL: readme-getting-started-SL-OpenSource.txt).
   Copy the contents of the readme file into a new notecard in your inventory and
   name the notecard '~FS Readme - DanceHUD - Getting started' (skip the ''s).
   
   Check the General tab and look at the Next Owner check boxes.
   Make sure to turn on Modify, Copy and Transfer.
   
   Close the edit window for the cube on the ground.
   
   Take a copy of the cube on the ground (just in case - very handy to
   have  a copy in case of problems). You might want to rename it to something
   that is rememberable - like: Cube to build DanceHUD prims - your choice :)

   Now click on the cube on the ground - it will ask you for
   permission to link/de-link from other objects - click Yes and then wait a
   little bit. You'll see a cube appear - then shrink and get added to the
   bottom of the top most prim. Each cube will start with a plywood texture
   and change to a black prim... just wait and soon enough - it'll stop and
   see a little message that says something like:
   
      Created DanceHUD prims - ready to have scripts added :-)
      
   A nice part of the BuildHUD script is that it cleans up after itself.
   In the contents of this set of prims - you will not find the 'Cube'
   object or the 'New Script' that built the set of prims.
   
   The texture (~FS Theme Basic) is not quite applied correctly - it's
   a bug in the BuildHUD script. We'll fix this in just a little bit...
   the scripts that we generate and put in then reset will get the
   theme correctly setup for you - so don't pay much attention to it
   as the texture will be fixed in a few more steps... (sigh).
   
   You might want to edit the object and move it up a little bit - to
   see all of the prims. If you look at it from the front - it'll be
   mostly black with strange textures here and there. Rotating around
   it you will see it disappear. This is because the transparent themes
   need to be able to show 'through' the back and top/bottom of the
   prims. We'll fix this when we add some scripts... :) For now,
   just be careful and only look at it from the front.
      
   Take a copy of the new pile of prims from on the ground into your inventory.
   (mostly because it may come in handy if you want to have a completely empty
   set of prims for experiments). You will probably notice that the object
   is now named: Fleursoft DanceHUD OpenSource
   I would recommend renaming the empty one in your inventory to something
   different - how about: Fleursoft DanceHUD OpenSource - empty
   Then you know what this object is all about.

   You have the prims all ready - just need to get the scripts added to it.

5) I like having the pile of prims attached - so attach it to top left of your BuildHUD
   and reposition it - so you see the front of it and it's all on the screen...

   Edit the pile of prims once more - and now we will create a new script
   for each script we need - and rename it to a new name. Once you rename the
   'New Script' to the correct name - then copy/paste in the contents of
   the script on your computer. This is going to be a tedious task to get
   each of the scripts into place.

   It's easiest to just create 30 new scripts and then for each one we rename
   and upload the script...

   Note: If you happen to create a 'new script' in your inventory then
   you will run into a problem with some of these scripts. Why? Because
   scripts created in the inventory are considered LSO scripts - these
   are NOT created as mono scripts. You will run into an error where some
   scripts will fail to save with a very odd error: Function args: sl
   Local list: (null) Function args i. Create the scripts in the DanceHUD
   prim and you will NOT see this error - as the scripts have to be mono.

   Weirder - copy the ~FSLists script to your inventory, edit it and
   add a space somewhere and attempt to save it. Same error as above.
   Same reason too... can't create mono scripts in your inventory.
   
   As you add more scripts - there will be delays and refreshes of the
   content of the prims... just wait it out... sigh.

   Sometimes you may need to close the contents of the object and detach the prims
   and wait a bit for the content server to get updated... once that happens then
   you can continue... otherwise you will just see nothing happening... sad... but...
   can't do much about this...
   
   Good luck on this step:

     FSChat.lsl     is ~FSChat
     FSDancer.lsl   is  ~FSDancer 01 to ~FSDancer 20 (or
         as many as you want - 20 copies)
         - On SL this script can be lsl - so you can uncheck the Mono box if you want to - saves some memory when doing this...
         - This is NOT work on OpenSim...
         - I also only let the first 10 run, the last 10 can be stopped
     FSDancers.lsl  is ~FSDancers
     FSDancerControl.lsl is ~FSDancerControl
     FSLanguage.lsl is ~FSLanguage
     FSLists.lsl    is ~FSLists
     FSMenu.lsl     is ~FSMenu 01 to ~FSMenu 10 (10 copies)
     FSPrepare.lsl  is ~FSPrepare
     FSRead.lsl     is ~FSRead
     FSServices.lsl is ~FSServices
     FSUI.lsl       is ~FSUI
     FSZHAO.lsl     is ~FSZHAO  

Note: FSZHAO is different - because it came from a GPL license - we have to
keep the GPL license. In the repository - this script starts as the one
that I downloaded - unchanged. The updated flavor is only to integrate
into the DanceHUD - and all of those changes I've included in the updated
version of FSZHAO.

Set all of the scripts in the DanceHUD to be full permission. This is
easy to do - just click 'Permissions' on the content tab and click on
the next owner options (copy, modify, transfer) and click 'Ok' and wait
a little bit. All the permissions are not full permission on each thing.

Time to pick it up - close the edit window and right click 'Take' to get it
into your inventory. I'd suggest making a copy and putter around with the
copy... but you can do whatever you want to do with it now. 


Tada - from input source to scripts in the Fleursoft DanceHUD OpenSource.

Now just attach the DanceHUD to the top left position and you should see
a pretty little menu just waiting to help you dance.

Try a chat command: /98reset

You should see the DanceHUD reset itself and it'll tell you that it got
reset. You should be all set now :)


