
#import "ESATMUpdate.h"

@implementation ESATMUpdate 

-(id)initWithXMLString:(NSString *)update
{
	xmlDoc = [[NSXMLDocument alloc] initWithXMLString:update
											  options:0
												error:&errorString];
}



-(NSString *)getESAID { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mESAID[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getSerial { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSerial[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getName { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mName[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getVersion { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mVersion[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getReleaseDate { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mReleaseDate[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(NSString *)getArch { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mArch[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(int)getFirmwareFeatures { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mFirmwareFeatures[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(long long)getTotalCapacityProtected{ return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mTotalCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getUsedCapacityProtected { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUsedCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getFreeCapacityProtected { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mFreeCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(long long)getUsedCapacityOS { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUsedCapacityOS[1]" error:&errorString] objectAtIndex:0] stringValue] longLongValue];}
-(int)getYellowThreshold { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mYellowThreshold[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getRedThreshold { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mTotalCapacityProtected[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getUseUnprotectedCapacity { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mUseUnprotectedCapacity[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(NSString *)getDroboName { return [[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mDroboName[1]" error:&errorString] objectAtIndex:0] stringValue];}
-(int)getSlotCountExp { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSlotCountExp[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getStatusAtSlot:(int)slot {;}
-(int)getPhysicalCapacityAtSlot:(int)slot {;}

-(int)getLUNCount { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mLUNCount[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getMaxLUNs { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mMaxLUNs[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(long long)getMaximumLUNSizeAtLUN:(int)lun {;}
-(long long)getUsedCapacityOSAtLUN:(int)lun {;}
-(int)getPartitionCountAtLUN:(int)lun {;}
-(int)getPartitionTypeAtLUN:(int)lun {;}
-(int)getPartitionFormatAtLUN:(int)lun {;}

-(int)getSledStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mSledStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}
-(int)getDiskPackStatus { return [[[[[xmlDoc rootElement] nodesForXPath:@"/ESATMUpdate[1]/mDiskPackStatus[1]" error:&errorString] objectAtIndex:0] stringValue] intValue];}

@end