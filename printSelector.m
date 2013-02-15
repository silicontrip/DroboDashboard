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
#import <Foundation/NSXMLElement.h>
#import <objc/runtime.h>

#import "DDServer.h"
#import <objc/runtime.h>

NSAutoreleasePool  *pool;
NSDistantObject *proxy;

char *typeDecoding (const char *code) {
	
	static char decode[1024];
	int index;
	
	decode[0] = '\0';
	
	//	decode = [[String alloc] init];
	
	for (index=0; index < strlen(code); index++) {
		
		if (index > 0)
			strcat(decode," ");
		
		switch (code[index]) {
				
			case 'c':
				strcat(decode,"char");	
				break;
				
			case 'i':
				strcat(decode,"int");	
				break;
				
			case 's':
				strcat(decode,"short");	
				break;
				
			case 'l':
				strcat(decode,"long");	
				break;
				
			case 'q':
				strcat(decode,"longlong");	
				break;
				
			case 'C':
				strcat(decode,"unsignedchar");	
				break;
				
			case 'I':
				strcat(decode,"unsignedint");	
				break;
				
			case 'S':
				strcat(decode,"unsignedshort");	
				break;
			case 'L':
				strcat(decode,"unsignedlong");	
				break;
			case 'Q':
				strcat(decode,"unsignedlonglong");	
				break;
				
			case 'f':
				strcat(decode,"float");
				break;
				
			case 'd':
				strcat(decode,"double");	
				break;
				
			case 'B':
				strcat(decode,"bool");	
				break;
				
			case 'v':
				strcat(decode,"void");	
				break;
				
			case '*':
				strcat(decode,"char*");	
				break;
				
			case '@':
				strcat(decode,"*Object");	
				break;
			case '#':
				strcat(decode,"Class");	
				break;
				
			case ':':
				strcat(decode,"Selector");	
				break;
				
			case '[':
				strcat(decode,"array[");	
				break;
			case ']':
				strcat(decode,"]");	
				break;
				
			case '{':
				strcat(decode,"struct{");	
				break;
			case '}':
				strcat(decode,"}");	
				break;
				
			case '(':
				strcat(decode,"union(");	
				break;
			case ')':
				strcat(decode,")");	
				break;
				
			case 'b':
				strcat(decode,"bits");	
				break;
				
			case '^':
				strcat(decode,"*");	
				break;
				
			case '?':
				strcat(decode,"unknown");	
				break;
				
			case 'r':
				strcat(decode,"const");	
				break;
				
			case 'n':
				strcat(decode,"in");	
				break;
				
			case 'N':
				strcat(decode,"inout");	
				break;
				
			case 'o':
				strcat(decode,"out");	
				break;
				
			case 'O':
				strcat(decode,"bycopy");	
				break;
				
			case 'R':
				strcat(decode,"byref");	
				break;
				
			case 'V':
				strcat(decode,"oneway");	
				break;
				
			default:
				break;
				
		}
	}	
	
	return decode;
	
}

printSelectorString (NSString *selString) {
	int index;
	NSMethodSignature *sig;
	
	NSArray *select  = [selString componentsSeparatedByString:@":"];
	
	sig = [proxy methodSignatureForSelector:NSSelectorFromString(selString)];

	printf ("- (%s)",typeDecoding([sig methodReturnType]));
	
	for (index=2; index < [sig numberOfArguments]; index++) {
		printf ("%s:(%s) ",[[select objectAtIndex:index-2] UTF8String], typeDecoding([sig getArgumentTypeAtIndex:index])); 
	}
	printf("\n");
}

int main(int argc, char *argv[])
{
	
	NSSocketPort *port;
	NSConnection *connection;
	
	
	DDServer *dd ;	
	NSString *esaid;
	NSString *esaupdate;
	NSData *command;
	
	Method * mlist;
	unsigned int mc = 0;
	int index = 0;
	int droboCount;
	
	int ddservicedPort = 50005;
	
	char rVal;
	unsigned long ulVal;
	
	pool = [[NSAutoreleasePool alloc] init];
	
	port = [[NSSocketPort alloc] initRemoteWithTCPPort:ddservicedPort host:@"localhost"];
	
	if (port == nil) {
		// this is actually a programming error
		NSLog(@"could not setup port");
		exit(-1);
	}
	
	connection = [NSConnection connectionWithReceivePort:nil sendPort:port];
	proxy = [[connection rootProxy] retain];
	
	dd = (DDServer *)proxy;

	// NSLog(@"%@",[proxy description]);
	
	if ([dd subscribeClient:proxy] == 1) {
		
		int riVal;
		
		/*
		NSString *fileContents = [NSString stringWithContentsOfFile:@"selector.txt" encoding:NSUTF8StringEncoding error:nil];
		NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];

		for (NSString* o in lines)
		{
			if ([o length] > 0 ) {
			 printSelectorString(o);
			}
		}	
		 */
		if ([dd getESACount:proxy] > 0) {

		NSString *esaid = [[NSString alloc] init];
		NSString *esaupdate = [[NSString alloc] init];
		NSString *command = [[NSData alloc] init];
		
		if ([dd getESAId:proxy ESAAtIndex:0 ESAID:&esaid]>0) {
		
			//[dd Identify:proxy  ESAID:esaid];
			
			NSObject *name = [[NSObject alloc] init];
			
//			[dd getESAId:proxy ESAAtIndex:0 ESAID:&name];
			[dd GetESA_LUNLabels:proxy ESAID:esaid lunLabels:&name];			
			
			NSLog(@"output class: %@",[name class]);
			NSLog(@"output: %@",[name description]);

			unsigned int f;

			[dd GetFirmwareFeatures:proxy ESAID:esaid features:&f];
			
			printf("firmware Features: %x\n",f);

			struct StatusInfo si;

			[dd dumpStatusInfo:proxy ESAID:esaid statusInfo:&si];

			printf ("status s1: %d\ns2: %d\ni1: %d\nf1: %f\nstatus: %d\nrelay count: %d\ndisk pack status: %d\n",si.s1,si.s2,si.i1,si.f1,si.mStatus,si.mRelayoutCount,si.mDiskPackStatus);

			struct CapacityInfo ci;
			[dd dumpCapacityInfo:proxy ESAID:esaid capacityInfo:&name];
		
			NSLog(@"output class: %@",[name class]);
			NSLog(@"output: %@",[name description]);

			//printf ("capacity c1: %d\nc2: %d\ni1: %d\ni2: %d\nf1: %f\nFree: %lld\nused: %lld\ntotal: %lld\nunprotected: %lld\n",ci.c1,ci.c2,ci.i1,ci.i2,ci.f1,ci.mFreeCapacityProtected,ci.mUsedCapacityProtected,ci.mTotalCapacityProtected,ci.mTotalCapacityUnprotected);
		}
		}
	}	
	
	[pool release];
	
}
