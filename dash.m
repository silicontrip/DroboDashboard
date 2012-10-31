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
	
	struct statusInfo { 
		unsigned int v1;
		unsigned int v2;
		unsigned int v3;
	};
	
	struct capacityInfo {
		unsigned long long v1;
		unsigned long long v2;
		unsigned long long v3;
		unsigned long long v4;		
	};
	
	struct statusInfo sInfo;
	struct capacityInfo cInfo;
	
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

	NSLog(@"%@",[proxy description]);
	
	rVal = [dd subscribeClient:proxy];  // apears to be first 
	
	if (rVal == 1) {
		
		int riVal;
		
		//printSelectorString(@"subscribeClient:");
		//printSelectorString(@"getESACount:");
		//printSelectorString(@"getESAId:ESAAtIndex:ESAID:");
		//printSelectorString(@"dumpStatusInfo:ESAID:statusInfo:");
		//printSelectorString(@"dumpCapacityInfo:ESAID:capacityInfo:");
		//printSelectorString(@"dumpSlotInfo:ESAID:arraySlotData:");
		//printSelectorString(@"dumpLUNInfo:ESAID:arrayLUNData:");
		
		//printSelectorString(@"TMInit:simulationMode:PollingInterval:VerboseLevel:FileMode:StartNetMonitorThread:");
		//printSelectorString(@"SendCommand:ESAID:cmd:");
		//printSelectorString(@"registerESAEventListener:");
		//printSelectorString(@"getNextESAEventType:");
		//printSelectorString(@"getNextESAUpdateEvent:ESAID:ESAUpdate:");
		
		
		droboCount = [dd getESACount:proxy];
	//	printf ("Number of drobos connected: %d\n", droboCount );
		
		if (droboCount > 0) {
			esaid = [[NSString alloc] init];
			esaupdate = [[NSString alloc] init];
			command = [[NSData alloc] init];
			
			if ([dd getESAId:proxy ESAAtIndex:0 ESAID:&esaid]>0) {
				
			//	NSLog(@"getESAId: %d",rVal);
		//		NSLog(@"Drobo ID: %@",esaid);
				
				
				[dd TMInit:proxy 
			   simulationMode:0 
			  PollingInterval:5 
				 VerboseLevel:0 
					 FileMode:0 
		StartNetMonitorThread:0];
				
				[dd registerESAEventListener:proxy];
				
				do {
					// should probably sleep
					riVal = [dd getNextESAEventType:proxy];
				} while (riVal != 1);
				
				NSString *update;			
				
				if ([dd getNextESAUpdateEvent:proxy ESAID:&esaid ESAUpdate:&update]>0) 
				{

						ESATMUpdate *esa;
						
						esa = [[ESATMUpdate alloc] initWithString:update];
						
						printf ("%s\t%lld\t%lld\t%lld\t%lld%%\n",[[esa getName] UTF8String],
								[esa getTotalCapacityProtected],
								[esa getUsedCapacityProtected],
								[esa getFreeCapacityProtected],

								100*[esa getUsedCapacityProtected]/[esa getTotalCapacityProtected]);
						/*
						while (aNode = [aNode nextNode]) {
							NSLog(@"Name: %@=%@",[aNode XPath],[aNode objectValue]);
						}
						*/
						
						
					} else {
						NSLog(@"Error Parsing response");
					}
					
					
					//	NSLog(@"getNextESAUpdateEvent: %d",riVal);
					//	NSLog (@"getNextESAUpdateEvent:%@",update);
				}
			}
		}
		//		[proxy unsubscribeClient:@"drobodash"];
	
	
	[pool release];
	
}
