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


const char *humanString ( long long number, NSNumber *human, NSNumber *si);
void disks (ESATMUpdate *esa, NSNumber *human, NSNumber *si);
void df (ESATMUpdate *esa, NSNumber *human, NSNumber *si);
void esaVersion(ESATMUpdate *esa);
void usage();
void listDrobo(NSDistantObject *proxy, DDServer *dd);
