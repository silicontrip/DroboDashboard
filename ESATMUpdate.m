
#import "ESATMUpdate.h"

@implementation ESATMUpdate 

-(id)initWithString:(NSString *)update
{
    self = [self init];
	xmlDoc = [[NSXMLDocument alloc] initWithXMLString:update
											  options:0
												error:&errorString];
    

	esaStatus =  [[NSDictionary alloc] initWithObjectsAndKeys:

	@"Normal",[NSNumber numberWithInt:Normal],
	@"Red Threshold Exceeded", [NSNumber numberWithInt:RedThresholdExceeded],
	@"Yellow Threshold Exceeded", [NSNumber numberWithInt:YellowThresholdExceeded],
	@"No Disks", [NSNumber numberWithInt:NoDisks],
	@"Bad Disk", [NSNumber numberWithInt:BadDisk],
	@"Too Many Missing Disks", [NSNumber numberWithInt:TooManyMissingDisks],
	@"No Redundancy", [NSNumber numberWithInt:NoRedundancy],
	@"No Magic Hotspare", [NSNumber numberWithInt:NoMagicHotspare],
	@"Relayout In Progress", [NSNumber numberWithInt:RelayoutInProgress],
	@"Format In Progress", [NSNumber numberWithInt:FormatInProgress], 
	@"Mismatched Disks", [NSNumber numberWithInt:MismatchedDisks], 
	@"Unknown Version", [NSNumber numberWithInt:UnknownVersion], 
	@"New Firmware Installed", [NSNumber numberWithInt:NewFirmwareInstalled], 
	@"New Lun Available After Reboot", [NSNumber numberWithInt:NewLunAvailableAfterReboot],
	@"Unknown Status", [NSNumber numberWithInt:UnknownStatus],
	nil];
    

    //ledStatus = [NSMapTable mapTableWithKeyOptions:NSMapTableObjectPointerPersonality valueOptions:NSMapTableStrongMemory];
     
    ledStatus= [[NSDictionary alloc] initWithObjectsAndKeys:
	@"Off", [NSNumber numberWithInt:LEDOff], 
	@"Red", [NSNumber numberWithInt:LEDRedOn], 
	@"Yellow", [NSNumber numberWithInt:LEDYellowOn], 
	@"Green", [NSNumber numberWithInt:LEDGreenOn], 
	@"Flashing Yellow-Green", [NSNumber numberWithInt:LEDFlashYellowGreen], 
	@"Flashing Red-Green", [NSNumber numberWithInt:LEDFlashRedGreen], 
	@"Flashing Red", [NSNumber numberWithInt:LEDFlashRed], 
	@"Flashing Red-Yellow", [NSNumber numberWithInt:LEDFlashRedYellow], 
	@"Empty", [NSNumber numberWithInt:LEDSlotEmpty], 
	nil];
/*
     [ledStatus setObject:(void *)LEDOff forKey:@"Off"];
     [ledStatus setObject:(void *)LEDRedOn forKey:@"Red"];
     [ledStatus setObject:(void *)LEDYellowOn forKey:@"Yellow"];
     [ledStatus setObject:(void *)LEDGreenOn forKey:@"Green"];
     [ledStatus setObject:(void *)LEDFlashYellowGreen forKey:@"Flashing Yellow-Green"];
     [ledStatus setObject:(void *)LEDFlashRedGreen forKey:@"Flashing Red-Green"];
     [ledStatus setObject:(void *)LEDFlashRed forKey:@"Flashing Red"];
     [ledStatus setObject:(void *)LEDFlashRedYellow forKey:@"Flashing Red-Yellow"];
     [ledStatus setObject:(void *)LEDSlotEmpty forKey:@"Empty"];
*/
    
	return self;
}
-(NSString *)getESAID { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mESAID[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getSerial { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSerial[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getName { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mName[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getVersion { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mVersion[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getReleaseDate { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mReleaseDate[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getArch { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mArch[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(int)getFirmwareFeatures { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mFirmwareFeatures[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(NSArray *)getStatusAsArray {
	int status = [self getStatus];
	NSMutableArray *a = [NSMutableArray arrayWithCapacity:2];

	enum ESAStatus t;
        t=1;

        while (t < 0x8000) {

                if ((status & t) == t)
                       [a addObject:[esaStatus objectForKey:[NSNumber numberWithInt:t]]];

                t *=2;
        }

	return a;

}
-(NSString *)getStatusAsString {
	return [[self getStatusAsArray] componentsJoinedByString:@", "];
}
-(int)getRelayoutCount { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mRelayoutCount[1]" error:&errorString] objectAtIndex:0] stringValue] intValue]; }
-(long long)getTotalCapacityProtected{ return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mTotalCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getUsedCapacityProtected { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUsedCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getFreeCapacityProtected { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mFreeCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getUsedCapacityOS { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUsedCapacityOS[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(int)getYellowThreshold { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mYellowThreshold[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getRedThreshold { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mTotalCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getUseUnprotectedCapacity { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUseUnprotectedCapacity[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(NSString *)getDroboName { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mDroboName[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(int)getSlotCountExp { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSlotCountExp[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getStatusAtSlot:(int)slot {
	return [[[[[xmlDoc rootElement] nodesForXPath:[NSString stringWithFormat:@"/ESATMUpdate[1]/mSlotsExp[1]/n%d[1]/mStatus[1]",slot] error:&errorString] objectAtIndex:0] stringValue] longLongValue];	
}
-(NSString *)getStatusAtSlotAsString:(int)slot {
    return [ledStatus objectForKey:[NSNumber numberWithInt:[self getStatusAtSlot:slot]]];
}

-(long long)getPhysicalCapacityAtSlot:(int)slot {
	return [[[[[xmlDoc rootElement] nodesForXPath:[NSString stringWithFormat:@"/ESATMUpdate[1]/mSlotsExp[1]/n%d[1]/mPhysicalCapacity[1]",slot] error:&errorString] objectAtIndex:0] stringValue] longLongValue];	
}
-(int)getLUNCount { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mLUNCount[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getMaxLUNs { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mMaxLUNs[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(long long)getMaximumLUNSizeAtLUN:(int)lun {
	return [[[[[xmlDoc rootElement] 
			   nodesForXPath:[NSString 
							  stringWithFormat:@"/ESATMUpdate[1]/mLUNUpdates[1]/n%d[1]/mMaximumLUNSize[1]",lun] 
			   error:&errorString] 
			  objectAtIndex:0] 
			 stringValue] 
			longLongValue];	
	
}
-(long long)getUsedCapacityOSAtLUN:(int)lun {
	return [[[[[xmlDoc rootElement] 
			   nodesForXPath:[NSString 
							  stringWithFormat:@"/ESATMUpdate[1]/mLUNUpdates[1]/n%d[1]/mUsedCapacityOS[1]",lun] 
			   error:&errorString] 
			  objectAtIndex:0] 
			 stringValue] 
			longLongValue];	
}
-(int)getPartitionCountAtLUN:(int)lun {
	return [[[[[xmlDoc rootElement] 
			   nodesForXPath:[NSString 
							  stringWithFormat:@"/ESATMUpdate[1]/mLUNUpdates[1]/n%d[1]/mPartitionCount[1]",lun] 
			   error:&errorString] 
			  objectAtIndex:0] 
			 stringValue] 
			intValue];	
}
-(int)getPartitionTypeAtLUN:(int)lun {	
	return [[[[[xmlDoc rootElement] 
			   nodesForXPath:[NSString 
							  stringWithFormat:@"/ESATMUpdate[1]/mLUNUpdates[1]/n%d[1]/mPartitionType[1]",lun] 
			   error:&errorString] 
			  objectAtIndex:0] 
			 stringValue] 
			intValue];	
}
-(int)getPartitionFormatAtLUN:(int)lun {
	return [[[[[xmlDoc rootElement] 
			   nodesForXPath:[NSString 
							  stringWithFormat:@"/ESATMUpdate[1]/mLUNUpdates[1]/n%d[1]/mPartitionFormat[1]",lun] 
			   error:&errorString] 
			  objectAtIndex:0] 
			 stringValue] 
			intValue];	
	
}

-(int)getSledStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSledStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getDiskPackStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mDiskPackStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(void)xml
{
  
    NSLog(@"%@",[[NSString alloc] initWithData:[xmlDoc XMLData] encoding:NSASCIIStringEncoding ]);
}    
-(void)xpath
{
    NSXMLNode *aNode = [xmlDoc rootElement];
    
    while ((aNode = [aNode nextNode])) {
        NSLog(@"Name: %@=%@",[aNode XPath],[aNode objectValue]);
    }
}

@end
