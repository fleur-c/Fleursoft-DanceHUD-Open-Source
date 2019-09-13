// This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)

// Older versions of opensim have a couple of bugs that show up in the dancehud (sigh)
// So here is a routine that checks the version of opensim you are on and determines
// if the revision is old and needs work arounds or new and works correctly.
//
// Interestingly there are two bugs that matter and both were fixed in the same revision...
// Let's see the two bugs in detail...
//
//----- ROTATE BUG ------
// The problem is that older opensim revs handle rotations
// with a relative value instead of an absolute value
// which means on opensim - we have to check the simulation
// version to determine what value we use to rotate down the
// dancehud when it's on an older sim version - or it will NOT
// rotate down at all.
//
// We'll assume it's a nice new version of opensim... but it may not be
//
// The string returned is in this format (bug was fixed in this range)
//  OpenSim 0.8.2.1 Post_Fixes        (Unix/Mono)
//  OpenSim 0.9.1.0 Snail Dev  f835960d17: 2019-09-05 00:23:47 +0100 (Unix/Mono)
//
// The bug was fixed in this commit:
// commit 397aa74777bc0c54ecd9e1b286e59e9de0a4f3c2
// Author: teravus <teravus@gmail.com>
// Date:   Tue Jan 1 23:07:37 2013 -0500
//
// * Fixes the attachment scripted rotation bug.   The problem is the code was relying on m_host.ParentId = 0 to determine if the attachment should be rotated against root prim offset.   To fix it for attachments, we also need to check if the host's localID == RootPart's localID. otherwise we are cumulatively rotating against the host's root part rotation offset (which in this case, is it's own rotation)
//
// Which release is that in for opensim?
// % git branch --contains 397aa74777bc0c54ecd9e1b286e59e9de0a4f3c2
// * 0.9.0.1-postfixes
// master
//
// So any release later than 0.9.0.1 Post_Fixes is a good release
// for the rotate fix
//
//
//----- llGiveInventoryList BUG ------
// Update script caused a crash... and seemed to be llGiveInventoryList...
// Error was:
// [14:08] System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.NullReferenceException: Object reference not set to an instance of an object
//  at (wrapper managed-to-native) System.Reflection.MonoMethod.InternalInvoke(System.Reflection.MonoMethod,object,object[],System.Exception&)
//  at System.Reflection.MonoMethod.Invoke (System.Object obj, System.Reflection.BindingFlags invokeAttr, System.Reflection.Binder binder, System.Object[] parameters, System.Globalization.CultureInfo culture) [0x0006a] in <6649516e5b3542319fb262b421af0adb>:0 
//   --- End of inner exception stack trace ---
//  at System.Reflection.MonoMethod.Invoke (System.Object obj, System.Reflection.BindingFlags invokeAttr, System.Reflection.Binder binder, System.Object[] parameters, System.Globalization.CultureInfo culture) [0x00083] in <6649516e5b3542319fb262b421af0adb>:0 
//  at System.Reflection.MethodBase.Invoke (System.Object obj, System.Object[] parameters) [0x00000] in <66
//
// Only happened with the first attempt to use the Update script on kitely
// And checking the sources for a change related to llGiveInventoryList we find:
//
// commit ab0294f0109416da0546e25797e7747b23071d33
// Author: Justin Clark-Casey (justincc) <jjustincc@googlemail.com >
// Date:   Tue Oct 16 01:33:35 2012 +0100
//
//    Add missing category paremeter to llGiveInventoryList grid IM construction.
//
//    This was a regression from 16c9c1df Sat Oct 6 02:34:49 2012 +0100.
//    Should resolve http://opensimulator.org/mantis/view.php?id=6360
//
// git branch --contains ab0294f0109416da0546e25797e7747b23071d33
// * 0.9.0.1-postfixes
//  master
//
// This is highly likely to be the bug that caused Update to crash.
//
//
//----- End of the odd OpenSim bugs ------
//
//
// The idea here is that only on opensim this include is pulled in to
// define a function that simply gets the simulation version - which is the
// version of opensim that is running and checks if it is from before
// revision "0.9.0.1 Post_Fixes" - which is where the bug exists.
//
// Returns: TRUE - rotate and inventory list give work
//          FALSE - nope - bugs - gotta work around these problems

integer DoesOpenSimRevWork()
{
    integer workingOpenSimRev = TRUE;
    string simVersion;
    list versionList;
    list revList;
    string parseStr;

    simVersion = llGetEnv("sim_version");
    versionList = llParseString2List(simVersion, [" "], []);
    parseStr = llList2String(versionList, 1);    // Get rev #'s, skip the OpenSim part
    revList = llParseString2List(parseStr, ["."], []);

    // We're checking if the release is at less than 0.9.0.1 Post_Fixes
    // Anything before that has to not have the fix so we do the workaround
    if (llList2Integer(revList,0) == 0)
    {
        if (llList2Integer(revList,1) < 9)
        {
            workingOpenSimRev = FALSE;
        }
        else
        {
            if (llList2Integer(revList,2) == 0)
            {
                if (llList2Integer(revList,3) < 1)
                {
                    workingOpenSimRev = FALSE;
                }
                else
                {
                    if (llList2Integer(revList,3) == 1)
                    {
                        // Now we know we are on 0.9.0.1 - do we have the postfixes that has the fix?
                        parseStr = llList2String(versionList,2);
                        if (parseStr != "Post_Fixes")
                        {
                            workingOpenSimRev = FALSE;
                        }
                    }
                }
            }
        }
    }

    // Cleanup memory usage (unclear that this actually matters...)
    simVersion = "";
    versionList = [];
    parseStr = "";
    revList = [];
    return workingOpenSimRev;
}
