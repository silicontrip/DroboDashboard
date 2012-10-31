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

int main(int argc, char *argv[])
{
	
	NSSocketPort *port;
	NSConnection *connection;
	DDServer *dd;	
	const int ddservicedPort = 50005;
	
	pool = [[NSAutoreleasePool alloc] init];
	
	NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
	if([args boolForKey:@"help"])
	{
		printf ("-df df style capacity output\n");
		printf("-v version information\n");
		printf("-list list connected drobos\n");
			   exit(0);
	}

	
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
		
		int droboCount = [dd getESACount:proxy];
		if([args boolForKey:@"list"]) {

			printf ("Number of drobos connected: %d\n", droboCount );
			int index;
			NSString *esaid;
			for (index=0; index < droboCount; index++) 
			{
				if ([dd getESAId:proxy ESAAtIndex:0 ESAID:&esaid]>0) {
					
					//	NSLog(@"getESAId: %d",rVal);
						printf("%d: ID: %s\n",index,[esaid UTF8String]);
				}
			}
			exit(0);
		}
		if (droboCount > 0) {
			NSString *esaid = [[NSString alloc] init];
			NSString *esaupdate = [[NSString alloc] init];
			NSString *command = [[NSData alloc] init];
			
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

				int riVal;

				do {
					// should probably sleep
					riVal = [dd getNextESAEventType:proxy];
				} while (riVal != 1);
				
				NSString *update;			
				
				if ([dd getNextESAUpdateEvent:proxy ESAID:&esaid ESAUpdate:&update]>0) 
				{

						ESATMUpdate *esa;
						
						esa = [[ESATMUpdate alloc] initWithString:update];
						
					if ([args boolForKey:@"version"]) {
						printf("ID:           %s\n",[[esa getESAID] UTF8String]);
						printf("Serial:       %s\n",[[esa getSerial] UTF8String]);
						printf("Name:         %s\n",[[esa getName] UTF8String]);
						printf("Version:      %s\n",[[esa getVersion] UTF8String]);
						printf("Release Date: %s\n",[[esa getReleaseDate] UTF8String]);

						printf("Architecture: %s\n",[[esa getArch] UTF8String]);
						printf("Features:     %d\n",[esa getFirmwareFeatures]);

						exit(0);
					}
					
					if([args boolForKey:@"df"]) {

					
						printf ("%s\t%lld\t%lld\t%lld\t%lld%%\n",[[esa getName] UTF8String],
								[esa getTotalCapacityProtected],
								[esa getUsedCapacityProtected],
								[esa getFreeCapacityProtected],

								100*[esa getUsedCapacityProtected]/[esa getTotalCapacityProtected]);
						exit(0);
					}
					
					if ([args boolForKey:@"disks"])
					{
					
						int disks = [esa getSlotCountExp];
						printf("Number of Disks: %d\n",disks);
						int slot;
						for (slot=0; slot < disks; slot++)
						{
						
							printf("Disk: %d size: %lld status: %d\n",slot,[esa getPhysicalCapacityAtSlot:slot], [esa getStatusAtSlot:slot]);
							
						}

						
					}
					
					if([args boolForKey:@"xpath"]) {
						NSError *errorString;

						NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithXMLString:update
																				 options:0
																				   error:&errorString];
						NSXMLNode *aNode = [xmlDoc rootElement];
						while (aNode = [aNode nextNode]) {
							NSLog(@"Name: %@=%@",[aNode XPath],[aNode objectValue]);
						}
					}
						
						
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
	return 0;
}
