Menus in the DanceHUD - how do they work?

Seems like such an easy thing - but it doesn't turn out that
it easy at all.

First of all - to make things update extra fast - we only use
one texture. That's it - just one. Different parts of the texture
are put on different prims. But once the one texture is loaded then
all of the buttons on prims are painted correctly. Lots of little
bits of code in here that find the right parts and repaint the prims
when we change themes - but just remember one texture and that is
all there is for the appearance.

For menus - we have a couple of details that are kind of interesting.
Each menu basically has two link messages that it has to support:

   Get Range - to get a range of options for the menu.
   Select - to select and do something for a particular menu item.

What? This seems almost too easy... well... it took a while to get to
this simple model. Take a look at the FSLists2 script and specificially
the routine HandleHUDVerticalSize. It looks kind of like this:

...
HandleHUDVerticalSize()
{
...

	if (cmd == MenuLite_GetMenuRange)
	{
		integer startIndex = llList2Integer(tmpList,1);
		integer linkid = llList2Integer(tmpList, 2);
		integer number = llList2Integer(tmpList,3);
...
		tmpStr = llDumpList2String(tmpList, "|||");
		MessageSendMenuRangeSelected(linkid, VERTICAL_CHANGE_MENU_NAME, length, startIndex, Define_FlagRangeConstrainedMenu, Define_LISTCHANGEHEIGHTLINKID, tmpStr, defaultMenuItem);
...
	}

	if (cmd == MenuLite_Select)
	{
		// The menu returned to the user was: Back, Height(0),Height(1)...
		cmd = llList2Integer(tmpList,1);	// Get the selected item from the list...
		if ((cmd >= ClickerMenuHeight1) && (cmd <= ClickerMenuHeight8))
		{
			length = llGetNumberOfPrims();
...
			MessageRecenterHUD();
			MessageGoToMenu(Define_LISTCHANGEHEIGHTLINKID);
			return;
		}
	}
...

The GetMenuRange command is all about getting the menu. There are two kinds
of menus in the DanceHUD - constrained menus (limited number of items and
always 30 or less) or unconstrained menus (as many items on the menu as we
can possibly fit).

Constrained menus are easier - so this example is all about just a few
items - the vertical size changing menu. There are eight vertical sizes
and a 'Back' menu item - so a total of nine items. This makes the vertical
size menu a constrained menu - it will NOT scroll. The response to a
GetMenuRange is always a 'SendMenuRangeSelected' - we send back the
response to whatever linkid asked for the menu (usually the FSUI script).
The name of the menu is next, followed by the size of the menu (nine in this
case) an a start index (we start counting at 0, I think). The next field
returned tells the FSUI script that the menu is constrained or not (i.e. do
we have to be able to scroll or not). The link id that follows is where
the FSUI script will send a 'Select' command when the user clicks or types
something to select a menu item. Then we stuff in a whole list of items
that are the menu items that can be selected.

This list of items looks like:
1) A string - this is what shows up on the menu as an item to click. It has
   a funny format to it:
     #3 Something
2) A link id - where to send the Select item - I thought the first link id
   would be enough... but included one here for going to other menus from a click.
3) A command number that means something to the menu select routine only.

And the very last thing is... an integer of what the default value should
be when the menu is shown (it will be highlighted or selected automatically).

For an unconstrained menu - the same kinds of things show up - but the item
for menu type is unconstrained.

Constrained menus only need to have one kind of select - just plain old
MenuSelect - like you see above. The FSUI and FSCHAT scripts will make sure
that when an item is selected - the item # (that last command #) will be sent
back to the appropriate link id. The select routine has to know what to do
with the selected item. It could send back another menu or do something
different - all depends on what needs to be done.

Now the unconstrained menus have a couple of other types of select routines
that they need to support. The chat or fsui scripts may send back a select with
a string (someone types: /98#DanceSequence). The DanceSequence may not be on
the currently displayed menu - so there is a SelectString command that each
of the unconstrained menus have to support. Fortunately this is really only
related to dance sequence menus (FSMenu) and inventory handling (FSList or
FSList2). Just about all of the administrative menus are all constrained menus.
Which is why it is very easy to add an administrative menu with not a lot of
code.


An interesting aspect of menus is that the FSChat script does not know what
is on the menu at all. It doesn't even try to know. Instead - any command
that is typed - we try to figure out. If we can't figure it out - we simply
send the string to the FSUI script (which happens to have a copy of the
menu that was displayed) and try to match the typed command to something
that is on the menu. If FSUI can't find a match - then we resort to sending
a 'selectString' to the appropriate menu and hope for the best.


There is one menu that is a bit abnormal for all of the menus included in
the DanceHUD. The help menu is a dialog box. The reasoning here is that if
the DanceHUD got attached but moved off the screen - the user will NOT be
able to click anything. A dialog box is simple and only has four options
for how to provide help. I wanted to have help that actually would help
instead of a confusing dialog box that no one would understand. The dialog
box is simply supported with a listen routine.
