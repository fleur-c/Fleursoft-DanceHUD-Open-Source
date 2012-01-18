Here are some dancing hints of what you can do in the Fleursoft DanceHUD...

1) Setup dance sequences - organize them however you want to... but
do something to organize them. I tend to use dance sequences a lot.

Here's what my notecard for dance sequences looks like:
(fill in notecard here - FIXME)

There are several things to notice:
a) I grouped my dance sequences by speed (slow, medium, fast) and
these three speeds are the first three menus (menu 1 is the slow
dances, menu 2 is the medium dances, menu 3 is the fast ones).
I put the unique and special dances on menu 4.

b) The notecard specifies the menu where dance sequences will go
along with the name that shows up on the menu when you display it.
This is handy - click 1 - see the 'Slow dances' over the sequence
names and I know I'm on the right menu.

c) Some lines are continued down on the next line (that '\' at
the end of the [menu] keyword). This lets you continue a dance
sequence for about as long as you want. I think you can probably
go up to about 8000 characters or so for a dance sequence - maybe
more. I've never tried to find the upper limit of how big just one
dance sequence could be. Definitely longer that 255 characters :)

d) Blank lines and comments - I like being able to look at my
notecard of dance sequences and be able to read it. There are
also spaces between things. This just makes it easier to read
for me - since I need to be able to add more dance sequences
later on... making it not difficult to read is a good idea.

-------------------------

2) Setup a menu of dance sequences for when you wait between dances.

You probably noticed in my dance sequences up above that
there is a set of sequences for waiting between dances.
I like these a lot - very handy. You need to do something
with the 'Administrative menu' - so click 'A' and
'Set wait sequence menu' then click 'Menu 10'. This is
not fun - but I only do it when I upgrade/reset my DanceHUD.

The nice part is now that I have set the wait sequence menu...
every time you click on the stop button (bottom right square
button), it will stop the current dance (or dance sequence)
and start a waiting sequence. It will just go from one to the
next. This makes the interval between music look much more
natural - you stand around and wait for the next song.

-------------------------

3) Set the settings you want on the administrative menu.
There are eight settings - so let's do over them quickly.
The administative menu settings are:

   #19 Dance selection:Manual|  All   Random
   #20 Default dance duration:N/A  #
   #21 Missing dance warnings:On load notecard  While dancing
   #22 Keep blank lines:No
   #23 Keep comment lines:No
   #24 Repeat sequences:Enabled
   #25 Freestyle recording:Off
   #26 Time animations:Off
   #27 Active menu:1

What do these mean?

Dance select - is about how dances are selected. There are
three settings:
   Manual - you click to select a dance sequence or animation
   All - You click the first dance to start - and after that
         one ends, the next one on the menu will be selected
         automatically.
   Random - You click the first dance to start - and after that
         one ends, a random dance from the menu will be selected
         automatically.

There is an interesting phrase in there - when the dance ends.
This means either the dance sequence ends (for example:
[name]ShortDance|dance1|30 ) will only dance for 30 seconds then
end. Or we could have a repeating dance sequence like this:
[name]RepeatDance|dance1|30|[repeat] - this dance sequence
does not 'end' automatically... but the next setting does
cause it to possibly end. You can set a default dance duration
which could be 3 minutes - doing that the RepeatDance sequence
will go on for 3 minutes then end and another dance will be
selected.


Default dance duration - by default dance sequences have whatever
duration you want them to have. If you have a dance sequence that
lasts ten minutes - then it is ten minutes long. You can set a
default dance duration to whatever you want - but this means that
all dances will stop automatically after this long. The settings
for this option are:
   N/A - Not applicable - basically no default duration
   # of seconds - you have to type a command to set the duration.
      Example: /98defaultduration 30
      Example: /98dd 30
These two examples will set the default dance duration to 30 seconds.


Missing dance warnings - when would you like to know about a
problem with your dance sequence? When you load a notecard or
while you are dancing? Essentially - that is what this setting
is all about. The settings are:
  On load notecard - you get information in local chat (sent only
     to the owner of the DanceHUD) that indicates a problem and
     what the DanceHUD did about that problem.
  While dancing - you get informatuo about a missing dance only
     when you dance the dance sequence (the information is also
     in local chat and only sent to the owner of the DanceHUD).
Personally - I like getting told about problems as early as possible.
So I always set this to 'On load notecard'. If you have a dance
sequence notecard from a different dancehud and it has some problems
or some dances are missing... this could cause a lot of interesting
messages. I tried very hard to make the messages as informative as
possible - but you'll have to read what it says and probably do
something.

I was sort of forced to add the 'While dancing' option... I don't
like it much at all. The reason is that you only get told about a
missing dance when you are dancing a sequence and the dance
animation needed is not in the dancehud. It substitutes in a boring
'stand_1' animation for any missing animation. When you are performing
and this happens - it looks weird.

I like knowing when I load the notecard - but that's me :)


Keep blank lines - when loading the notecard, you can have blank
lines to seperate dance sequences. This can be handy in the notecard
and you might want them on the dance sequence menu. The settings
for this option are:
   No - don't show the blank lines on the menu
   Yes - show the blank lines on the menu
An example will help. Let's say you have this notecard:
--- notecard start ---
[name]A dance|dance1|30

[name]B dance|  dance2  | 30
--- notecard end ---

If you set the Keep blank lines to No - and load this notecard, the
menu will look like this:
--- menu start ---
#1 A dance
#2 B dance
--- menu end ---

If you set the Keep blank lines to Yes - and load this notecard, the
menu will look like this:
--- menu start ---
#1 A dance

#3 B dance
--- menu end ---


Keep comment lines - is similar to the blank lines setting, except
that it keeps comments (or not) for the menu. What's a comment?
On your notecard - just start a line with '#' and write whatever
you want after it. Let's do an example:
--- notecard start ---
[name]A dance|dance1|30
# This is a comment
[name]B dance|  dance2  | 30
--- notecard end ---

If you set the Keep comment lines to No - and load this notecard, the
menu will look like this:
--- menu start ---
#1 A dance
#2 B dance
--- menu end ---

If you set the Keep comment lines to Yes - and load this notecard, the
menu will look like this:
--- menu start ---
#1 A dance
This is a comment
#3 B dance
--- menu end ---


Repeat sequences - should the [repeat] keyword work or not? This
seems like an easy question... but it is somewhat subtle in how it
really does things. When you are dancing from the inventory menu,
what actually happens is that for each animation that you click
the dancehud will transform that into a little dance sequence that
looks like this (example of dance animation named Dance1):
[name]Dance1 | Dance1 | 300 | [repeat]
The 300 is the default duration for dancing from the inventory.
If repeat sequences is enabled and you click this animation and
wait for the next dance (assuming the default dance duration is
set to N/A), you will wait forever.
If the repeate sequences is disabled, then we will dance the
Dance1 animation for 300 seconds (or the default dance duration
which ever one is smaller). And then the dancing will select
either a wait sequence (when dance selection is set to manual)
or a different animation (any other dance selection).

Seems complex - but think of repeat sequences as really a way for
dancing from your inventory to change dances easily - depending on
the other settings.


Freestyle recording - is about recording a dance sequence while
freestyle dancing. I'll skip this subject for now - it will take
more to explain it than just a couple of sentences.


Time animations - is all about how long a specific animation was
danced. Most dance animations are 'looped' - or they automatically
restart at the beginning once they finish. Many of the animation
creators will have some way to indicate the duration of a dance
animation - mostly through using the description field for the
animation.

This setting is for how long the dancehud was dancing an animation.
You can use it to time an animation when it loops... can be handy
for that. I've used it to check how the dancehud performs while I
dance and compare the duration of an animation to how long I told
the dance sequence to dance the animation.

Handy feature - not as wonderful as possible... but the scripting
is limited when it comes to what it can do with an animation.


Active menu isn't really so much a setting as showing you the
currently active dance sequence menu.

-------------------------

4) Customizing the DanceHUD

I tried especially hard to make it possible to customize the
dancehud however you want to use it. I'll touch on how to do
this quickly - each of these ideas could take a while to explain
in great detail...  I'll just quickly explain... there will be
more detail in another readme document.

a) The messages used throughout the dancehud are all in the
notecard named: ~FSErrors
Why would I do that? Because you can change the messages to
whatever you would like them to be. When you invite someone
to dance and they accept - there are a couple of instant messages
sent to them. You can customize those messages to what you want
them to say. It's just a notecard and if you look you will see
that each line looks kind of like this:

IM001 Welcome to our dancing group - glad you could dance with us.
IM002 To stop dancing, type: '/&1stop'
IM003 Reminder: You may want to turn off your AO.

That first part (IM001, IM002 or IM003 for example) is used in the
dancehud to indicate which message to send. The rest of the line can
be changed to whatever you would like. The &1 is replaced with whatever
the dancehud would like it to be replaced with - in this case it will
be the number '98' which is the channel the user can send a message
to in order to stop dancing. Let's change these to something else:

IM001 Hugs - oh, it's so nice to be dancing with you now!
IM002 When you want to leave us... type: '/&1stop'
IM003 Reminder: Your animation override seems to be on, you may want to turn it off - eep!

Different messages - so that when you invite someone - they will see
these new messages instead of my boring old messages.


b) Themes - you can set the theme of the dancehud to different
themes. It comes with four themes and the most boring one is the
default one which is only black and white. Click on the administrative
menu 'Set theme' and you can easily change the theme.

Creating a new theme - that takes some explaining and I'll do that
in another readme document. You can create a theme. The themes are
just one texture and a funny name and that's it.

-------------------------

5) Cleanly changing from one dance sequence to another...

I noticed this while I was dancing one day. I had two dance sequences
where there was only one difference between them. They looked
something like this:

[name]Dance & fall | dance1|30 | dance2|30 | slip-and-fall|10 | dance3|20 | [repeat]
[name]Dance | dance1|30 | dance2|30 | dance3|20 | [repeat]

The difference is that the first one will slip and fall and stand up
to resume the dance. Cute little move in the middle there... but what
is interesting is that if I start the 'Dance & fall' sequence - let it
play through once (so dance1, dance2, slip-and-fall and then dance3) and
let it start on dance1 again... if I'm quick (well within 30 seconds)
I can click on 'Dance' and what happens is very interesting.

dance1 doesn't start over - it just keeps on going from where it was.

This is because the dancehud told the sim to start dance1... it was
playing the animation, then quickly got told to stop dance1 and to
start dance1 again. Well - the sim looked at that and said - no reason
to stop dance1 in the first place. This is an interesting thing because
the second sequence starts up - and after dance1 - could be completely
different... but the transition is completely smooth. You don't even
notice that the sequence was changed from what you see of the dancing.

It just changes in mid-stride and keeps the first animation going.
I found this very interesting. Knowing this means that it is possible
to make a completely seamless transition from one sequence to another
as long as you are dancing a particular animation - and the second
sequence happens to start with that animation.

I thought this was a bug at first - but it's not. The sim does this so
that it lowers the load and doesn't flip animations too quickly.

This is why the sync option causes all the dancers to stop the current
animation, start a 'stand_1' animation for 0.5 seconds and then stop the
'stand_1' and start the animation which was the one for the sync point
(this can vary based on different groups of dancers). Any less time than
0.5 causes the simulator to not cause the animation to sync up nicely.
(yes - I had to try experiments on this to find out what would work :)

Interestingly - I can't reproduce this in another dancehud. The Fleursoft
DanceHUD can cause this to happen easily - mostly because the scripts
that control dancing are really doing very little. I suspect this same
kind of transition could work if another dancehud could quickly send out
the dance stop/start requests. I don't know - haven't seen it in others.

-------------------------

6) Remember - you can have multiple notecards loaded!  I have several
different sets of notecards - one notecard for dance sequence dancing,
another couple for freestyle dancing. This way I can load the appropriate
notecard for whatever I am doing. A nice feature is the ability to
clear a menu - so you can clear menu 5 for example and load a notecard
there. You can also load multiple notecards to the same menu. If
try fit (150 dances more or less) then the first dances will show up
and the second set will be added to the bottom of the menu.

-------------------------

7) You can use two dancehuds - having the owner active only in one of
them. Just start both in dance mode and for one of them - go to the
administrative menu and remove yourself from the list of dancers.
The 'other' dancehud will have control of your dancing.

-------------------------

8) If you need to switch between a couple of menus all of the time...
you might want to setup a gesture using the fkey command. fkey is
the shortcut name - it's about defining a function key and having that
function key do something with the dancehud. Let's setup one to toggle
between the first menu of dance sequences and the second menu of dance
sequences:
/98fkey 1 menu 1 | menu 2
Put this in as chat text in a gesture and set the gesture to trigger
when you push function key 2. Now when you push the fkey2 on your
keyboard - the menu switches from menu 1 to menu 2 and back again.

You can have as many chat commands as you like - each push of the
function key will take you to the 'next' command and around to the
start of the list again.

-------------------------

