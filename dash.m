/*
 ** Very basic drobo tool
 ** communicates with DDServiced via Objective-C Distributed objects.
 ** 
 ** Methods for the DDServer Class found using strings on the DDServiced binary
 ** 
 gcc  -framework Foundation dash.m
 */

#import "dash.h"

NSAutoreleasePool  *pool;

ESATMUpdate * getNextESAEvent (DDServer *dd, NSDistantObject *proxy) 
{
	NSString *update;			
	NSString *esaidUpdate;			

	if ([dd getNextESAUpdateEvent:proxy ESAID:&esaidUpdate ESAUpdate:&update]>0) 
		return [[ESATMUpdate alloc] initWithString:update];

	return nil;
}			

NSString *getESAID (DDServer *dd, NSDistantObject *proxy) 
{
	NSString *esaid;

	esaid = [[NSString alloc] init];
	// get the first drobo
	[dd getESAId:proxy ESAAtIndex:0 ESAID:&esaid];
	return esaid;
}

void initESAEvent (DDServer *dd, NSDistantObject *proxy) {

	if ([dd getESACount:proxy] > 0) {
					
		[dd TMInit:proxy 
			simulationMode:0 
			PollingInterval:1 
			VerboseLevel:3 
			FileMode:0 
			StartNetMonitorThread:0];
				
		[dd registerESAEventListener:proxy];
				
		int riVal;
				
		do {
			// should probably sleep
			riVal = [dd getNextESAEventType:proxy];
		} while (riVal != 1);
				
	}
}

NSDistantObject * ddserverConnect (NSString *host,int ddservicedPort ) {

	NSSocketPort *port;
	NSConnection *connection;

	port = [[NSSocketPort alloc] initRemoteWithTCPPort:ddservicedPort host:host];
	
	if (port == nil) {
		// this is actually a programming error
		NSLog(@"could not setup port");
		return nil;
	}
	
	connection = [NSConnection connectionWithReceivePort:nil sendPort:port];
	return [[connection rootProxy] retain];
	// NSLog(@"%@",[proxy description]);
	
	
}	

const char *humanString ( long long number, NSNumber *human, NSNumber *si) 
{
	if ([human boolValue]) {
	 return [[HumanReadableDataSizeHelper humanReadableSizeFromBytes:[NSNumber numberWithLongLong:number] useSiPrefixes:[si boolValue]  useSiMultiplier:[si boolValue]] UTF8String];
	} else {
		return [[[NSNumber numberWithLongLong:number] stringValue] UTF8String];
	}
}

void disks (ESATMUpdate *esa, NSNumber *human, NSNumber *si)
{
	int disks = [esa getSlotCountExp];
	printf("Number of Disks: %d\n",disks);
	int slot;
	for (slot=0; slot < disks; slot++)
	{
		printf("Disk: %d size: %s status: %d\n",slot,humanString([esa getPhysicalCapacityAtSlot:slot],human,si), [esa getStatusAtSlot:slot]);
	}	
}

void df (ESATMUpdate *esa, NSNumber *human, NSNumber *si) {

		printf("%20s\t%s\t%s\t%s\t%s\n","Name","Total","Used","Free","Percent");	
		printf ("%20s\t%s\t%s\t%s\t%lld%%\n",[[esa getName] UTF8String],
			humanString([esa getTotalCapacityProtected],human,si),
			humanString([esa getUsedCapacityProtected],human,si),
			humanString([esa getFreeCapacityProtected],human,si),
			100*[esa getUsedCapacityProtected]/[esa getTotalCapacityProtected]);
}

void esaVersion(ESATMUpdate *esa) {
	printf("ID:           %s\n",[[esa getESAID] UTF8String]);
	printf("Serial:       %s\n",[[esa getSerial] UTF8String]);
	printf("Name:         %s\n",[[esa getName] UTF8String]);
	printf("Version:      %s\n",[[esa getVersion] UTF8String]);
	printf("Release Date: %s\n",[[esa getReleaseDate] UTF8String]);
	
	printf("Architecture: %s\n",[[esa getArch] UTF8String]);
	printf("Features:     %d\n",[esa getFirmwareFeatures]);
}	

void usage() {
	printf("Drobo dashboard Utility\nUtility to manage connected Drobos\n");
	printf("Usage: dash <command> [options]\nCOMMANDS:");
	printf ("\tdf df style capacity output\n");
	printf("\tversion information\n");
	printf("\tlist list connected drobos\n");
	printf("\tdisks list disks and status\n");

	printf("\t-esaid <ESAID> Specify which Drobo to use\n");
	printf("\t-h Human readable number format\n");
	printf("\t-si Use 1000 rather than 1024 for human readable display.\n");
}

void listDrobo(NSDistantObject *proxy, DDServer *dd)
{

	int droboCount = [dd getESACount:proxy];
	
	printf ("Number of drobos connected: %d\n", droboCount );
	int index;
	NSString *esaid;
	for (index=0; index < droboCount; index++) 
	{
		if ([dd getESAId:proxy ESAAtIndex:index ESAID:&esaid]>0) {
			
			//	NSLog(@"getESAId: %d",rVal);
			printf("%d: ID: %s\n",index,[esaid UTF8String]);
		}
	}
	
	
}


int main(int argc, char *argv[])
{
	
	NSDistantObject *proxy;
	DDServer *dd;	
	
	pool = [[NSAutoreleasePool alloc] init];
	

        Arguments *newargs = [[Arguments alloc]  initWithNSProcessInfoArguments:[[NSProcessInfo processInfo] arguments]];
	
	if([newargs containsArgument:@"help"] || [newargs optionForKey:@"help"])
	{
		usage();
		exit(0);
	}

	proxy = ddserverConnect (@"localhost",50005);

	dd = (DDServer *)proxy;
	
	if ([dd subscribeClient:proxy] == 1) {
		
		if([newargs containsArgument:@"list"]) {
			listDrobo(proxy,dd);
			exit(0);
		}
		

		NSString *esaid = [newargs optionForKey:@"esaid"];

		if (esaid == nil) 
			esaid = getESAID(dd,proxy);

		initESAEvent(dd,proxy);

		ESATMUpdate *esa = getNextESAEvent(dd,proxy);

		if ([newargs containsArgument:@"version"]) {
			esaVersion(esa);
			exit(0);
		}
					
		if([newargs containsArgument:@"df"]) {
			df (esa,[newargs optionForKey:@"h"],[newargs optionForKey:@"si"]);
			exit(0);
		}
					
		if ([newargs containsArgument:@"disks"])
		{
			disks(esa,[newargs optionForKey:@"h"],[newargs optionForKey:@"si"]);	
			exit(0);	
		}
					
/*

// this should be moved to a debug method of ESATMUpdate class.
		if([newargs containsArgument:@"xpath"]) {
			NSError *errorString;
					
			NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithXMLString:update
				options:0
				error:&errorString];
			NSXMLNode *aNode = [xmlDoc rootElement];

			while (aNode = [aNode nextNode]) {
				NSLog(@"Name: %@=%@",[aNode XPath],[aNode objectValue]);
			}
		}
*/		
		[dd unregisterESAEventListener:proxy];
		[dd TMExit:proxy];
				
	} else {
		NSLog(@"No Drobos Detected.");
	}
	[dd unsubscribeClient:proxy];
	
	[pool release];
	return 0;
}
