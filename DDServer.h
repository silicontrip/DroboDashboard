
@interface DDServer: NSObject {


}
- (char)subscribeClient:(NSDistantObject *)object;
- (int)getESACount:(NSDistantObject *)object;
- (char)getESAId:(NSDistantObject *)object ESAAtIndex:(int)index ESAID:(NSString **)esaid;
- (void)TMInit:(NSDistantObject *)object simulationMode:(char)sim PollingInterval:(int)poll VerboseLevel:(int)ver FileMode:(char)mode StartNetMonitorThread:(char)thread; 
- (void)registerESAEventListener:(NSDistantObject *)object;
- (int)getNextESAEventType:(NSDistantObject *)object; 
- (int)getNextESAUpdateEvent:(NSDistantObject *)object ESAID:(NSString **)esaid ESAUpdate:(NSString **)update; 
- (int)dumpSlotInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arraySlotData:(NSData **)data; 
- (int)dumpLUNInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arrayLUNData:(NSData **)data; 
- (unsigned long)SendCommand:(NSDistantObject *)object ESAID:(NSString *)esaid cmd:(NSData **)data; 

@end
