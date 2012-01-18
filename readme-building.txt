Hi!

Welcome to the open source version of the Fleursoft DanceHUD.

Open source? Yes - I'm glad to share just about all of the secrets
from behind the scenes on how I created the dancehud and what all
it does.

I'm using a Creative Commons Attribution 3.0 Unported License
(http://creativecommons.org/licenses/by/3.0/). Basically this means
that the sources are all available (soon on githud) and you can
use them for whatever you would like. Build a product, sell it,
whatever. The idea is that you will contribute back in the end...
hopefully.

First things first - What is this DanceHUD thing and what is going
on within it? Essentially - the dancehud helps people dance in
virtual worlds. Add some animations, maybe a dance sequence that
uses the animations and tada - nice dancing. That's just part
of the story - the intent was that the Fleursoft DanceHUD would
work on multiple virtual worlds.

OpenSim LSL scripting is 'in theory' 'exactly the same' as LSL
scripting within Secondlife (copyright - trademark and wave of
queen's hand over the terms of service, as appropriate). Theory
is not the same as reality. Memory management in SL is important
(clear those lists and strings in assignments all the time, like:
   somelist = ([] + somelist + "new thing for list");
In OpenSim - this does NOT work at all... which means a lot of
fundamental scripting operations are not going to work. I resolved
this by creating an include file that will generate the appropriate
code for either OpenSim or SL - depending on what you are generating.

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
I build on a MacBook Pro with Mac OS X Lion - I'll take a guess
at the same types of tools for Windows... but I don't do Windows...
Tools you'll need for Mac OS X:
- XCode - for cpp (C PreProcessor) and make
- perl - Used to generate some LSL code and cleanup generated code
- Eclipse - Graphical integrated development environment
- LSLPlus - LSL development out of world for Eclipse
- Photoshop - or some other graphics editor

On Windows - you'll need similar parts - just different is all...
- cygwin - unix environment for Windows - has a cpp, make and perl
           in the development tools
- Eclipse - The windows version of Eclipse and...
- LSLPlus - LSL development out of world for Eclipse
- Photoshop - or some other graphics editor

How do you build the scripts for the dancehud?
1) Create a project in Eclipse (with the LSLPlus addon) and
   make it a LSLPlus project. I created one called:
      DanceHUDOpenSource
   On my system this folder showed up at:
       /Users/fleur/Documents/workspace/DanceHUDOS
   It's just an empty LSLPlus project for now.

2) Clone a copy of the sources from the git repository to
    (add some github detail here - Fleur)
     Something like:
         cd Documents/workspace 
         git clone (something)
   This will create a DanceHUDOpenSource directory - move
   all of the contents to the project directory for Eclipse:
         move * ../DanceHUDOS
         move .git ../DanceHUDOS
   You can delete the empty directory now:
         cd ..
         rmdir DanceHUDOpenSource
   Go back to eclipse and you should see all the sources
   in the project now. If not - refresh the project
   (right click -> Refresh)

   What is nice now is that you have the sources under source
   control (git) and in the Eclipse project in the same place.\
   I believe there is a git plugin for Eclipse... I haven't
   tried it out at all...

3) Now let's get stared on generating some LSLPlus input.
   Type 'make' in the DanceHUDOS directory.
   This will cause the make program to read the Makefile
   and decide to take the input files and generate some
   input files for LSLPlus. The beginning of the output
   of make looks like this:

Fleurs-MacBookPro:DanceHUDOS fleur$ make
./GenerateKeywords
cpp -nostdinc -P -I. -Iinclude FSChat | ./StripComments > FSChat.lslp
cpp -nostdinc -P -I. -Iinclude FSDanceControl | ./StripComments > FSDanceControl.lslp

   The './GenerateKeywords' command generates two files in
   the 'include' directory: Keywords and KeywordSearch

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

   The 'cpp...' command simply uses the C PreProcessor in
   a way that tells it that there are no standard include
   files (C would like to have standard include files, we
   are not programming in C - so no sense in using them :)
   and that the place to find include files is in the 'include'
   directory. This transforms the macros into code, and there
   are some control structures of what macros to use. Take a
   peek at the include/Utility input file - it's a good example.
   The Utility file has a part that looks like this:
...
#ifdef BUILD_FOR_SL
#define AppendToString(input, addition) \
        (input="")+input+addition
...
   The #ifdef is for cpp - and means - if the following 'name'
   is 'defined' - then do what is next. There is an #else and
   a #end. Handy for having different definitions of macros.

   But why different definitions for a macro? SL handles memory
   differently than OpenSim and I did not want to put that in
   most of the scripts. Let's show an example of appending to
   a string...

   In SL - you would normally write somethig like this:

      str = (str="")+str+"something new";

   But in OpenSim - you can't do this - you need to do something
   like this instead:

      str = str + "something new";    or
      str += "something new";

   But if I do that all over the place - then I will have one
   set of scripts for SL and another for OpenSim - bleck.
   By defining a macro to generate some code - instead I wrote:

     str = AppendToString(str, "something new");

   It looks a little weird - and seems strange to do this for
   all of the strings and lists - BUT - the input scripts are
   now nearly virtual world independent. :)

4) Now we go back to Eclipse and refresh the project (right click
   on the project folder and select Refresh). LSLPlus will parse
   the .lslp files and generate .lsl files. Very handy. I'm sure
   there could be an easier way - to be honest - I just never
   even tried to find an easier way.

   You can do a LOT more in LSLPlus - I used it for offline
   debugging and simulation of the DanceHUD a LOT. Helped me
   in so many ways... I'm skipping the details - but this is
   a very very handy out of the world place to develop scripts.
   I would use the LSLPlus/Eclipse editor on my input files and
   when I was ready - fire up a shell and 'make' the input for
   LSLPlus - refresh in Eclipse/LSLPlus and tada - .lsl files.

5) You would think that we were all done with the .lsl files...
   LSLPlus is very handy - removes unused variables/routines and
   optimizes a few other ways too... but the generated .lsl files
   do NOT work outside of SL. And they are still filled with comments
   and lots of indentations and more things that humans will like
   but don't really matter to the computer.

   The next step - fire up make one more time:
   
Fleurs-MacBookPro:DanceHUDOS fleur$ make post
make: *** No rule to make target `FSChat.lsl', needed by `FSChat.plsl'.  Stop.

   Hmm - this means that we didn't have Eclipse/LSLPlus do generate
   the .lsl files for us... (knowing this helps you to know to
   go back a step and try again until LSLPlus is done).

Fleurs-MacBookPro:DanceHUDOS fleur$ make post
./PostLslPlus < FSChat.lsl > FSChat.plsl

   The 'make post' command will run all of the generated .lsl files
   through a perl filter - PostLslPlus - which is all about cleaning
   up the .lsl files from LSLPlus into a form that both SL and
   OpenSim will accept. This is all about cleaning up the extra
   ('s and )'s and putting a nice little couple of comments at
   the top of the output .plsl file. The first generated line is
   for on OpenSim - where you can specify the type of language
   interpreter (in this case lsl). This first line isn't used
   on SL... so I generally delete it in world. The second line
   is the creative comments attribution license pointer.
   Yes - it's a nice license - use the source, or not - sell
   it if you want to - but include the source.

6) Now we've finally got to the part where we do something in a virtual
   world. Login and now you need to use a couple of scripts which will
   build the pile of prims that will become the DanceHUD Open Source.

   Go into Build mode in your viewer - and create a cube on the ground.
   Edit the cube and copy/paste in the contents of the PrimScript.lslp
   into a 'New Script' in the 'Contents' tab of the cube. The PrimScript
   script simply lets the building script set the names of the prims
   once they rez. Also change the permissions of the object so that
   'Next owner' has modify, Copy and Transfer set. Close the edit window
   and 'Take' the object (right click 'Take') into your inventory.
   It will show up in your inventory in the Objects folder.
   
   Rename the cube (which is named 'Object') in your 'Inventory/Objects'
   folder to be: Cube
   
   Now create another cube on the ground. Edit this one and go to the
   contents tab. Now we need to drag in a copy of the 'Cube' object.
   Create a 'new script' there and edit the script and copy/paste in
   the contents of the 'BuildHUD.lslp' script.
   
   Upload the textures for use in the DanceHUD - these are in the
   Themes directory - upload and rename them as follows:
   
    Themes/FS Theme Basic.png -> ~FS Theme Basic
    Themes/FS Theme Flowers-b=0,0,255.png -> ~FS Theme Flowers/b=0,0,255
    Themes/FS Theme Transparent-b=0,0,0,1.png -> ~FS Theme Transparent/b=0,0,0,1
    Themes/FS Theme Blue-b=0,0,255.png -> ~FS Theme Blue/b=0,0,255

   Copy the four textures you uploaded into the contents of the cube
   on the ground.
   
   While you are there - create a notecard (in your inventory) - name
   it ~FSErrors and put the contents of 'Errors-English' (skip the ''s)
   into that notecard and put the notecard in the contents of the cube.
   I think you'll find a blank line a the end - you can delete that
   line and save the notecard.
   
   One last thing to copy in is the contents of 'readme-getting-started.txt'
   copy the contents of that file into a new notecard in your inventory and
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
   see a little message that says somethink like:
   
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

7) Edit the pile of prims once more - and now we will create a new script
   for each one we need - and rename it to a new name. Once you rename the
   'New Script' to the correct name - then copy/paste in the contents of
   the script on your computer. I find that setting the debug setting for
   'EXTERNAL_EDITOR' works wonderful well - so that if you edit the script
   and then click the 'edit' button - your external editor starts up and
   you can simply read the appropriate script into the editor. Much easier
   than copy/paste. No matter what - it'll still be a tedious task to get
   each of the scripts into place.
   
   One little detail - if you use an external editor - remove the first
   blank line (shows up - don't know why) and you can also remove the
   	//XEngine:lsl
   It is there for OpenSim support - not needed on SL.
   
   As you add more scripts - there will be delays and refreshes of the
   content of the prims... just wait it out... sigh.
   
   I cheat a little bit on Mac OS X and create a symbolic link in my
   home directory via: ln -s `pwd` ~/z/
   Then from the external editor I can just read in the scripts
   easily in GVim: :r ~/z/whatever.plsl
   
   Good luck on this step:

     FSChat.plsl     is ~FSChat
     FSDanceControl.plsl is ~FSDancer Control
     FSDancer.plsl   is  ~FSDancer 01 to ~FSDancer 20 (or
         as many as you want - 20 copies) - can be lsl - so you can
         uncheck the Mono box
     FSDancers.plsl  is ~FSDancers
     FSDebug.plsl    is ~FSDebug
     FSLanguage.plsl is ~FSLanguage
     FSLists.plsl    is ~FSLists
     FSLists2.plsl   is ~FSLists2
     FSMenu.plsl     is ~FSMenu 01 to ~FSMenu 10 (10 copies)
     FSPrepare.plsl  is ~FSPrepare
     FSRead.plsl     is ~FSRead
     FSServices.plsl is ~FSServices
     FSUI.plsl       is ~FSUI
     FSZHAO.plsl     is ~FSZHAO

  To do the scripts where there are multiple copies - it's much easier
  and faster to create the first one in the Contents tab. Then copy it
  to your inventory and then copy/paste more copies and rename them once
  you have enough copies. Then just copy the new ones - all the ones you
  need back into the Contents tab. This is just a quicker way to do it.
  

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


