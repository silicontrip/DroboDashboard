
#import "ESATMUpdate.h"

@implementation ESATMUpdate 

-(id)initWithString:(NSString *)update
{
    self = [self init];
	xmlDoc = [[NSXMLDocument alloc] initWithXMLString:update
											  options:0
												error:&errorString];
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
