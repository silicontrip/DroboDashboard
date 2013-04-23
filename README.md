DroboDashboard
==============

Command line tools to communicate with the DDService Daemon for monitoring a directly connected Drobo

This version only works with Drobo Dashboard 1. Not Drobo Dashboard 2.

    Drobo dashboard Utility
    Utility to manage connected Drobos
    Usage: dash <command> [options]

    COMMANDS:
    df              df style capacity output
    version         display version and status information
    list            list connected drobos
    disks           list disks and status
    identify        Flash all leds red-green for identification
    standby         powerdown drobo.
    restart         restart drobo.
    --red [threshold]       Display or set the red threshold.
    --yellow [threshold]    Display or set the yellow threshold.

    OPTIONS:
    --esaid <ESAID> Specify which Drobo to use
    -h      Human readable number format
    --si    Use 1000 rather than 1024 for human readable display.

df output (with -h and --si)
----------------------------
    ./dash df -h --si
    Drobo selected: 0db104xxxxxx_000
                    Name          Total           Used           Free Percent
         Drobo disk pack        6.97 TB        4.34 TB        2.62 TB 62%

There is about 7TB of total space and I have used 4.3TB of space, leaving 2.6TB free or 62% used.

disks output (with -h)
----------------------
    ./dash disks -h
    Drobo selected: 0db104xxxxxx_000
    Number of Disks: 4
    Disk: 0 size: 1.82 TiB status: Flashing Yellow-Green
    Disk: 1 size: 2.73 TiB status: Flashing Yellow-Green
    Disk: 2 size: 2.73 TiB status: Flashing Yellow-Green
    Disk: 3 size: 1.82 TiB status: Flashing Yellow-Green

This shows I have 4 disks, 2x 2TB disks and 2x 3TB disks.

This can be seen more easily using the si (--si) units option.  Manufacturers use SI units for reporting size of their disks
rather than the computer units.

    ./dash disks -h --si
    Drobo selected: 0db104xxxxxx_000
    Number of Disks: 4
    Disk: 0 size: 2 TB status: Flashing Yellow-Green
    Disk: 1 size: 3 TB status: Flashing Yellow-Green
    Disk: 2 size: 3 TB status: Flashing Yellow-Green
    Disk: 3 size: 2 TB status: Flashing Yellow-Green

This also shows that the Drobo is in a state of Relayout hence the Flashing Yellow-Green

version output
--------------
    ./dash version
    Drobo selected: 0db104xxxxxx_000
    ID:           0db104xxxxxx
    Serial:       0DB104xxxxxx
    Name:         Drobo disk pack
    Version:      1.4.2 [1.254.50341]
    Release Date: May 18 2012,16:01:50
    Architecture: ArmMarvell
    Features:     4468735
    Status:       No Redundancy, Relayout In Progress
    Relayout Remaining: 2260

This showing the Drobo currently has no redundancy and cannot protect against disk failures.  It is currently
performing a relayout on the parity data and has 2260 units to go.

I do not know what a unit is, only that my drobo can process between 46 and 47 an hour.  It will take another 2 days to complete relayout.

The Remaining report was a newly added feature and I do not know if the time taken to process is dependent on the size of the disks or model of the drobo. Feedback would be appreciated.

report yellow threshold
-----------------------
    ./dash --yellow
    Drobo selected: 0db104xxxxxx_000
    Yellow Threshold: 8500
    
This shows 85% (multiplied by 100).  Can be set by specifying a similar value.

set yellow threshold
--------------------
    ./dash --yellow 7500
    Drobo selected: 0db104xxxxxx_000
    Yellow Threshold old: 8500 new: 7500

Have set the Yellow threshold to 75%

same can be done with the --red command line option

report red threshold
--------------------
    ./dash --red
    Drobo selected: 0db104xxxxxx_000
    Red Threshold: 9500

Red threshold showing 95%

Identify Drobo
--------------
    ./dash identify
    Drobo selected: 0db104xxxxxx_000
    2013-03-22 14:48:23.835 dash[37108:10b] Drobo 0db104xxxxxx_000 identified.

If a disk status is run immediately after you can see that the leds are showing identify status.

    ./dash disks
    Drobo selected: 0db104xxxxxx_000
    Number of Disks: 4
    Disk: 0 size: 2000398934016 status: Flashing Red-Green
    Disk: 1 size: 3000592982016 status: Flashing Red-Green
    Disk: 2 size: 3000592982016 status: Flashing Red-Green
    Disk: 3 size: 2000398934016 status: Flashing Red-Green

