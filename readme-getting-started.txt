
Thank you for trying the Fleursoft DanceHUD OpenSource edition!

Hi!

Dancing in SL is hard. But we love to dance and especially dance well... and nothing in SL is wonderful at dancing. I've looked and tried and putzed and - well... nothing is all that wonderful. Some gadgets are very good at one thing, but not so much of others.

I'm tired of it being so very hard to dance. I created this DanceHUD to make dancing easier and more capable and faster and with more options than ever before. My goal is to make the best possible DanceHUD.

I will need your help in making the DanceHUD even better. If you would like to see something added or changed, please tell me. I'm very glad to hear suggestions and even about problems. I want to help you the best I possibly can.

What are some of the features?
- Support for really long dance sequences (like REALLY long and on lots of lines - way past 255 characters)
- Support for couples and multiple groups within a dance sequence
- Ten menus of dance sequences
- Dance sequences can be easily organized by dance style
- You can load multiple notecards with different dance sequences
- Most of the keywords from another HUD configuration notecard work (i.e. Dance Queens dance sequences will almost always just workd)
- You can be told about anything that isn't quite right on your notecard AS it is being read.
- Very low lag while you are dancing - the absolute minimum is done while dancing so that on a very laggy sim, you will probably be able to dance wonderfully well (I've tried it on a sim with 70 avatars and could easily dance).
- Easy to add custom themes to change how the DanceHUD looks
- Documentation - I'm working hard to document everything, every keyword, every message - what they mean and what you can do about every one of them.
- And lots and lots more...

What did you get?
- Fleursoft DanceHUD OpenSource (wear this) - This is the DanceHUD - and that's it
  It should start as a completely full permission item - you can click/edit anything. I wouldn'recommend changing prims or scripts yet - but you can see and poke everything.

What do you NOT get?
- Support - if you have a problem, send me e-mail and I will try to help. But no promises.
- Part of the lack of support is - no automatic updates. There will be bug fixes - bet on it. But anyone using the OpenSource version will have to update the DanceHUD OpenSource - manually. It's not hard - just tedious.
- A second part of the lack of support is - no easy way to get animations and other things into the DanceHUD in the first place. I have a Transfer script that works wonderfully - makes copies of copy items that are inside an object very easy peasy.


How to contact me: Send e-mail to: fleur@fleursoft.com subject line MUST start with: DanceHUD OpenSource: (then whatever you need help with)

I may or may not respond quickly (or at all) to e-mail for help or support. If you want help - I highly recommend buying the Fleursoft DanceHUD for L$500.  I will do anything possible to support anyone who buys the Fleursoft DanceHUD and as quickly as I can possibly help too.

Note: The DanceHUD comes empty - there are no dance animations or animation overrides preloaded. You will need to add your own.

----------------------------

Getting started with the DanceHUD

The first thing you want to do is copy the DanceHUD and probably rename it. I put my copy of the DanceHUD into my Animations folder - just so I know where it is. Then wear the DanceHUD - by default it will attach to the top left corner as a heads up display (HUD). You can change this by selecting any other place to attach the HUD. The DanceHUD will automatically position itself so that it is all displayed.

When you attach the DanceHUD - it will start with a nice little welcome message that will try to explain what the buttons on the screen are all about. You can get back to this set of quick directions by typing '/98reset'  (without the quotes) into local chat and the DanceHUD will reset - and show you this screen again.

The next thing to do is get your animations and configuration notecard(s) into the DanceHUD. There is one way with the OpenSource edition:

1) Detach the DanceHUD, drag it from your inventory to the ground (make sure you can rez items first) and then right click it, select edit and select the 'Content' tab of the edit window.
2) Drag items from your inventory into the contents of the DanceHUD (animations, configuration notecards)
3) Once you've got all of the items you want into the DanceHUD, close the edit window and take the DanceHUD back into your inventory. Wait a minute for the asset server to remember.
4) Wear the DanceHUD and tada - ready to go.

Let's try out a dance - there are several ways to dance. The easiest is simply to dance the animations from the inventory of the DanceHUD. Click 'Dance' - and you will see that the 'Dance' world will get highlighted (to show you are in Dance mode). Click 'I' for the Inventory of the DanceHUD. If you loaded some dance animations into the DanceHUD - you will see them listed now. Click any of the dance animations and.... there may be a slight pause as the animation is loaded by SL, then you will be dancing that dance animation. Click another dance and tada - changes as soon as SL loads the animation.

A nicer way to dance is to configure a dance sequence. A dance sequence is simply a list of dances and times that you want to dance in a specific order. Let's make one up - I'll pretend to have two dances: Dance1 and Dance2. Each of them is 23 seconds long. A dance sequence of both dances would look like this:

    Dance1|23|Dance2|23
 
If you create a notecard that says exactly that - copy the notecard into the contents of the DanceHUD, then load the notecard (Click  A for Administrative menu, then Load notecard, then the notecard name that has that sequence), you will see that the DanceHUD will load the notecard on to the current menu - which is almost always menu 1. If you click a different number (1 through 10) then load a notecard, the notecard will go to the menu number that you had showing before the notecard was loaded. In any event, after you load the notecard - click the menu number 1 (or which ever you selected earlier) and you will see one entry on that menu with the name of: Dance1

If you click 'Dance1' - it will dance Dance1 for 23 seconds then Dance2 for 23 seconds then you will stop dancing and just stand there.

You can add some keywords to make this dance sequence a little more unique - like let's add a name to this sequence and make it repeat over and over. If you edit the notecard (that is inside the DanceHUD - right click DanceHUD - Edit - Content - double click the notecard...) and change it to look more like this:

    [name]My Dance |Dance1|23|Dance2|23 | [repeat]

Save the notecard, then close the edit window. Now reset the DanceHUD (type: /98reset) - and we go back to the Administrative menu and load the notecard again. This time - we will see that menu 1 has the dance sequence named: My Dance

If you click 'Dance' at the top - and then 'My Dance' you will start with Dance1 for 23 seconds, then Dance2 for 23 seconds, then Dance1 for 23 seconds and so on... You can click the Stop button (bottom right corner - looks like a little square) and you will just stop dancing and stand there.


Let's try an AO instead of a dance - Loading an AO is very similar to a dance - it just has more parts is all. You need to get the AO animations into the DanceHUD (Transfer or copy them from your inventory), and a notecard which is ZHAO II format (the website will describe this in more detail). The AO notecard has to start with the special character '~' - this indicates the notecard is an AO notecard. Once you have these parts in the DanceHUD - you simply click on 'AO' at the top of the screen to activate AO mode. You will get a little menu - which is for the animation override. On that screen - you will see a 'Load notecard' - click that and then load your AO notecard (starts with a '~'). Wait a little bit and tada the AO should be working.

If you click the top of the DanceHUD (where it says Fleursoft DanceHUD OpenSource) - you will be sent to the Fleursoft website for more details.

The little line at the top right side of the DanceHUD is there for you to use to make the DanceHUD small on the screen.
 
I hope these directions get you started well.

- Fleur Cooperstone

