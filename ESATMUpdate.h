
#import <Cocoa/Cocoa.h>
#import "DDServer.h"


@interface ESATMUpdate : NSObject {

	NSError *errorString;
	NSXMLDocument *xmlDoc;
    NSDictionary *esaStatus;
    NSDictionary *ledStatus;

}

-(id)initWithString:(NSString *)update;

-(NSString *)getESAID;
-(NSString *)getSerial;
-(NSString *)getName;
-(NSString *)getVersion;
-(NSString *)getReleaseDate;
-(NSString *)getArch;
-(int)getFirmwareFeatures;
-(int)getStatus;
-(NSArray *)getStatusAsArray;
-(NSString *)getStatusAsString;
-(int)getRelayoutCount;
-(long long)getTotalCapacityProtected;
-(long long)getUsedCapacityProtected;
-(long long)getFreeCapacityProtected;
-(long long)getUsedCapacityOS;
-(int)getYellowThreshold;
-(int)getRedThreshold;
-(int)getUseUnprotectedCapacity;
-(NSString *)getDroboName;
-(int)getSlotCountExp;
-(int)getStatusAtSlot:(int)slot;
-(NSString *)getStatusAtSlotAsString:(int)slot;
-(long long)getPhysicalCapacityAtSlot:(int)slot;

-(int)getLUNCount;
-(int)getMaxLUNs;
-(long long)getMaximumLUNSizeAtLUN:(int)lun;
-(long long)getUsedCapacityOSAtLUN:(int)lun;
-(int)getPartitionCountAtLUN:(int)lun;
-(int)getPartitionTypeAtLUN:(int)lun;
-(int)getPartitionFormatAtLUN:(int)lun;

-(int)getSledStatus;
-(int)getDiskPackStatus;
-(void)xml;
-(void)xpath;

@end
