/*
 ** Very basic drobo tool
 ** communicates with DDServiced via Objective-C Distributed objects.
 ** 
 ** Methods for the DDServer Class found using strings on the DDServiced binary
 ** and ftp://updates.drobo.com/drobohacks/TransportManager/dll/TransportManager.h
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
		return [[[ESATMUpdate alloc] initWithString:update] autorelease];

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

NSDistantObject * ddserverConnect (NSString *host, int ddservicedPort ) {

	NSSocketPort *port;
	NSConnection *connection;
	NSDistantObject *proxy;
	
   // NSLog(@"Connecting to: %@ %d",host,ddservicedPort);
    
	port = [[[NSSocketPort alloc] initRemoteWithTCPPort:ddservicedPort host:host] autorelease];
	
	if (port == nil) {
		// this is actually a programming error
		NSLog(@"could not setup port");
		return nil;
	}
	
	connection = [NSConnection connectionWithReceivePort:nil sendPort:port];
	if (connection == nil)
		return nil;
	proxy = [connection rootProxy];
	return [proxy retain];
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

time_t timeOfChange(NSDistantObject *proxy, DDServer *dd)
{
    ESATMUpdate *esa = getNextESAEvent(dd,proxy);

    printf ("Rebuild remaining: %d\n",[esa getRelayoutCount]);

    int relayout = [esa getRelayoutCount];
    while ([esa getRelayoutCount] == relayout && relayout != 0)
    {
        printf ("Rebuild remaining: %d\n",[esa getRelayoutCount]);
        sleep (1);
        esa = getNextESAEvent(dd,proxy);
    }

    return time(NULL);
}

void rebuildProgress(NSDistantObject *proxy, DDServer *dd,NSNumber *repeats)
{
    time_t s1;
    time_t s2;
    
    ESATMUpdate *esa;
    
    s1 = timeOfChange(proxy,dd);
    
    do {
        s2=timeOfChange(proxy,dd);

        esa = getNextESAEvent(dd,proxy);

        time_t spc = s2 - s1;
        printf ("seconds per stripe: %ld\n",spc);
        printf ("seconds remain: %ld\n", [esa getRelayoutCount] * spc );
        s1=s2;
        
    } while ([repeats boolValue] && [esa getRelayoutCount]!=0 );
   
}
void disks (ESATMUpdate *esa, NSNumber *human, NSNumber *si)
{
	int disks = [esa getSlotCountExp];
	printf("Number of Disks: %d\n",disks);
	int slot;
	for (slot=0; slot < disks; slot++)
	{
		printf("Disk: %d size: %s status: %s\n",slot,humanString([esa getPhysicalCapacityAtSlot:slot],human,si), [[esa getStatusAtSlotAsString:slot] UTF8String]);
	}	
}

void df (ESATMUpdate *esa, NSNumber *human, NSNumber *si) {

		printf("%20s %14s %14s %14s %s\n","Name","Total","Used","Free","Percent");	
		printf ("%20s %14s %14s %14s %lld%%\n",[[esa getName] UTF8String],
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
	printf("Status:       %s\n",[[esa getStatusAsString] UTF8String]);
	printf("Relayout Remaining: %d\n",[esa getRelayoutCount]);

}	

void usage() {
	printf("Drobo dashboard Utility\nUtility to manage connected Drobos\n");
	printf("Usage: dash <command> [options]\n\nCOMMANDS:\n");
	printf ("df\t\tdf style capacity output\n");
	printf("version\t\tdisplay version and status information\n");
	printf("list\t\tlist connected drobos\n");
	printf("disks\t\tlist disks and status\n");
	printf("identify\tFlash all leds red-green for identification\n");
	printf("standby\t\tpowerdown drobo.\n");
	printf("restart\t\trestart drobo.\n");
	printf("--red [threshold]\tDisplay or set the red threshold.\n");
	printf("--yellow [threshold]\tDisplay or set the yellow threshold.\n");
	printf("\nOPTIONS:\n");

	printf("--esaid\t<ESAID> Specify which Drobo to use\n");
	printf("-h\tHuman readable number format\n");
	printf("--si\tUse 1000 rather than 1024 for human readable display.\n");
}

BOOL checkDrobo(NSDistantObject *proxy, DDServer *dd, NSString *esa)
{
        int droboCount = [dd getESACount:proxy];

        int index;
        NSString *esaid;
        for (index=0; index < droboCount; index++)
        {
                if ([dd getESAId:proxy ESAAtIndex:index ESAID:&esaid]>0) {

                        //      NSLog(@"getESAId: %d",rVal);
			if ([esaid compare:esa] == NSOrderedSame)
				return TRUE;
                }
        }
	return FALSE;
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
	
    int port;
	
	pool = [[NSAutoreleasePool alloc] init];
	

    Arguments *newargs = [[Arguments alloc]  initWithNSProcessInfoArguments:[[NSProcessInfo processInfo] arguments]];
	
	if([newargs containsArgument:@"help"] || [newargs optionForKey:@"help"])
	{
		usage();
		exit(0);
	}

	NSString *host;
	
    // Drobo Dashboard 2 uses new port and appears to be a new protocol.
    
    if ([newargs optionForKey:@"port"])
	{
		port = [[newargs optionForKey:@"port"] intValue];
	} else {
		port = 50005;
	}

    
	if ([newargs containsArgument:@"host"])
	{
		host = [newargs optionForKey:@"host"];
	} else {
		host = @"localhost";
	}
	
	@try {
		proxy = ddserverConnect (host,port);

		dd = (DDServer *)proxy;
	
		if ([dd subscribeClient:proxy] == 1) {
		
			if([newargs containsArgument:@"list"]) {
				listDrobo(proxy,dd);
				exit(0);
			}
		
			NSString *esaid = [newargs optionForKey:@"esaid"];

			if (esaid == nil) 
				esaid = getESAID(dd,proxy);


			if (checkDrobo(proxy,dd,esaid)) {

				printf ("Drobo selected: %s\n",[esaid UTF8String]);

				initESAEvent(dd,proxy);

				ESATMUpdate *esa = getNextESAEvent(dd,proxy);

				if ([newargs containsArgument:@"version"]) 
				{
					esaVersion(esa);
				}
				else if([newargs containsArgument:@"df"]) 
				{
					df (esa,[newargs optionForKey:@"h"],[newargs optionForKey:@"si"]);
				}
				else if ([newargs containsArgument:@"disks"])
				{
					disks(esa,[newargs optionForKey:@"h"],[newargs optionForKey:@"si"]);	
				} 
				else if([newargs containsArgument:@"identify"]) 
				{
					if([dd Identify:proxy ESAID:esaid])
					{
						NSLog(@"Drobo %@ identified.",esaid);
					}
				}
				else if([newargs containsArgument:@"standby"]) 
				{
					NSString *unmount;
					[dd Standby:proxy ESAID:esaid dissentingVolume:&unmount];
					NSLog(@"Dissenting Volume: %@",unmount);
				}
				else if([newargs containsArgument:@"restart"]) 
				{
					[dd Restart:proxy ESAID:esaid];
				}
				else if([newargs containsArgument:@"xpath"]) 
				{
					[esa xpath];
				}

				else if([newargs optionForKey:@"yellow"]) 

				{
					unsigned int pValue;
					[dd GetOption_YellowThreshold:proxy ESAID:esaid threshold:&pValue];
					if ([newargs hasOption:@"yellow"])
					{
						[dd SetOption_YellowThreshold:proxy ESAID:esaid threshold:[[newargs optionForKey:@"yellow"] intValue]];
						printf ("Yellow Threshold old: %d new: %d\n",pValue, [[newargs optionForKey:@"yellow"] intValue]);
					} else {
						printf ("Yellow Threshold: %d\n",pValue);
					}
				}
				else if([newargs optionForKey:@"red"]) 

				{
					unsigned int pValue;
					[dd GetOption_RedThreshold:proxy ESAID:esaid threshold:&pValue];
					if ([newargs hasOption:@"red"])
					{
						[dd SetOption_RedThreshold:proxy ESAID:esaid threshold:[[newargs optionForKey:@"red"] intValue]];
						printf ("Red Threshold old: %d new: %d\n",pValue, [[newargs optionForKey:@"red"] intValue]);
					} else {
						printf ("Red Threshold: %d\n",pValue);
					}
				}
                else if ([newargs containsArgument:@"rebuildProgress"])
                {
                    rebuildProgress(proxy,dd,[newargs optionForKey:@"r"]);
                }
				else
				{
					printf ("Nothing to do. (try help --help)\n");
				}
					
			} else {
				NSLog(@"Cannot find drobo ID: %@",esaid);
			}
		
			[dd unregisterESAEventListener:proxy];
			[dd TMExit:proxy];
				
		} else {
			NSLog(@"No Drobos Detected.");
		}
        
		[dd unsubscribeClient:proxy];
	
	}@catch ( NSException *e ) {
		
		if ([[e name] compare:@"NSPortTimeoutException"] == 0) {
			printf("Couldn't connect to Drobo server.\n");
		} else {
			NSLog(@"An exception occured: name: %@ reason: %@ user: %@",[e name],[e reason],[e userInfo]);
		}
	}

	[pool release];
	return 0;
}
