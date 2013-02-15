/*
 ** Very basic drobo tool
 ** communicates with DDServiced via Objective-C Distributed objects.
 ** 
 ** Methods for the DDServer Class found using strings on the DDServiced binary
 ** 
 gcc  -framework Foundation dash.m
 */

#import <Foundation/NSConnection.h>
#import <Foundation/NSPortNameServer.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>
#import <objc/runtime.h>

#import "DDServer.h"
#import "ESATMUpdate.h"
#import "HumanReadableDataSizeHelper.h"
#import "Arguments.h"

enum VerboseLevel
{
	vl_NONE = 1,		///< No logging message will be displayed
	vl_VERBOSE = 2,		///< Informational message will be displayed
	vl_DEBUG = 3		///< Informational and debugging message will be displayed
};

/// Defines the Slot status constants

enum SlotStatus
{
	/// LED off
	LEDOff						= 0,
	/// Red LED on
	LEDRedOn					= 1,
	/// Yellow LED on
	LEDYellowOn				= 2,
	/// Green LED on
	LEDGreenOn					= 3,
	/// LED flashing between yellow and green
	LEDFlashYellowGreen		= 4,
	/// LED flashing between red and green
	LEDFlashRedGreen			= 5,
	/// LED flashing red
	LEDFlashRed				= 6,
	/// LED flashing between red and yellow
	LEDFlashRedYellow			= 7,
	/// If the slot is empty (programatically or from startup, this bit will be set)
	LEDSlotEmpty				= 0x80,
};
/// Defines the ESA status constants
enum ESAStatus
{
	/// Normal
	Normal						= 0x00,		// Generic nominal status
	/// Exceed red alert threshold
	RedThresholdExceeded		= 0x02,
	/// Exceed yellow alert threshold
	YellowThresholdExceeded	= 0x04,
	/// No disks avaialble
	NoDisks					= 0x08,		// SlotStatus suggests expansion slot
	/// Bad disk detected
	BadDisk					= 0x10,		// SlotStatus indicates which disk
	/// Multiple disks are removed
	TooManyMissingDisks		= 0x20,		// packStatus::TOO_MANY_MISSING_DISKS,
	// packStatus::CRITICAL_DISK_MISSING
	/// No redundancy
	NoRedundancy				= 0x40,		// SlotStatus suggests expansion slot
	/// No maigc hot spare available
	NoMagicHotspare			= 0x80,		// SlotStatus suggests expansion slot
	/// System is full
	SystemFull					= 0x100,	// SlotStatus suggests expansion slot
	/// Re-layout in progress
	RelayoutInProgress			= 0x200,
	/// Format in progress
	FormatInProgress			= 0x400,
	/// Mismatched disk sets
	MismatchedDisks			= 0x800,	// packStatus::MISMATCHED_DISKS
	/// Metatdata not understood
	UnknownVersion				= 0x1000,	// packStatus::UNKNOWN_VERSION
	/// Firmware upgrade done, reboot required.
	NewFirmwareInstalled		= 0x2000,
	/// New LUN available but not yet visible outside the ESA
	NewLunAvailableAfterReboot = 0x4000,
	/// Something is very wrong
	UnknownStatus				= 0x10000000,	// packStatus::NOT_LOADED_NO_ERROR, et. al.
};

const char *humanString ( long long number, NSNumber *human, NSNumber *si);
void disks (ESATMUpdate *esa, NSNumber *human, NSNumber *si);
void df (ESATMUpdate *esa, NSNumber *human, NSNumber *si);
void esaVersion(ESATMUpdate *esa);
void usage();
void listDrobo(NSDistantObject *proxy, DDServer *dd);
