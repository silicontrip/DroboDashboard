
@interface DDServer: NSObject {


}
- (char)subscribeClient:(NSDistantObject *)object;
- (void)unsubscribeClient:(NSDistantObject *)object; 
- (int)getESACount:(NSDistantObject *)object;
- (char)getESAId:(NSDistantObject *)object ESAAtIndex:(int)index ESAID:(NSString **)esaid;
- (void)TMInit:(NSDistantObject *)object simulationMode:(char)sim PollingInterval:(int)poll VerboseLevel:(int)ver FileMode:(char)mode StartNetMonitorThread:(char)thread; 
- (oneway void)TMExit:(NSDistantObject *)object; 
- (void)registerESAEventListener:(NSDistantObject *)object;
- (oneway void)unregisterESAEventListener:(NSDistantObject *)object; 
- (int)getNextESAEventType:(NSDistantObject *)object; 
- (int)getNextESAUpdateEvent:(NSDistantObject *)object ESAID:(NSString **)esaid ESAUpdate:(NSString **)update; 
- (unsigned long)SendCommand:(NSDistantObject *)object ESAID:(NSString *)esaid cmd:(NSData **)data; 

- (char)GetESA_Time:(NSDistantObject *)object ESAID:(NSString *)esaid timeValue:(long *)time; 
- (char)GetESA_DroboName:(NSDistantObject *)object ESAID:(NSString *)esaid droboName:(NSString **)name;
- (char)GetESA_PartitionCount:(NSDistantObject *)object ESAID:(NSString *)esaid partitionCount:(unsigned int *)count; 
- (char)GetESA_LUNLabels:(NSDistantObject *)object ESAID:(NSString *)esaid lunLabels:(NSString **)label; 
- (unsigned int)GetProConfig:(NSDistantObject *)object ESAID:(NSString *)esaid configInfo:(NSData **)data; 
- (unsigned int)GetSledConfig:(NSDistantObject *)object ESAID:(NSString *)esaid configInfo:(NSData **)data; 
- (char)GetFirmwareFeatures:(NSDistantObject *)object ESAID:(NSString *)esaid features:(unsigned int*)feature; 
- (char)GetOption_RealTimeIntegrityChecking:(NSDistantObject *)object ESAID:(NSString *)esaid value:(char *)check;
- (char)GetOption_UseUnprotectedCapacity:(NSDistantObject *)object ESAID:(NSString *)esaid value:(char *)use;
- (char)GetOption_RedThreshold:(NSDistantObject *)object ESAID:(NSString *)esaid threshold:(unsigned int*)red; 
- (char)GetOption_YellowThreshold:(NSDistantObject *)object ESAID:(NSString *)esaid threshold:(unsigned int*)yellow; 
- (unsigned int)GetDemoModeSupportInfo:(NSDistantObject *)object ESAID:(NSString *)esaid; 

- (char)SetOption_RedThreshold:(NSDistantObject *)object ESAID:(NSString *)esaid threshold:(unsigned int)red;


- (int)dumpOption2:(NSDistantObject *)object ESAID:(NSString *)esaid options2Data:(NSData **) data;
- (int)dumpOption:(NSDistantObject *)object ESAID:(NSString *)esaid optionsData:(NSData **) data; 
- (int)dumpSlotInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arraySlotData:(NSData **)data; 
- (int)dumpLUNInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arrayLUNData:(NSData **)data; 
- (int)dumpDiskPackInfo:(NSDistantObject *)object ESAID:(NSString *)esaid diskPackData:(NSData **)data; 
- (int)dumpFirmwareInfo:(NSDistantObject *)object ESAID:(NSString *)esaid firmwareData:(NSData **)data; 

- (char)Identify:(NSDistantObject *)object ESAID:(NSString *)esaid; 


@end
/*
 - (*Object)
 - (void)
 - (char)subscribeClient:(byref in *Object) 
 - (void)unsubscribeClient:(byref in *Object) 
 - (void)
 - (void)
 - (void)TMInit:(byref in *Object) simulationMode:(in char) PollingInterval:(in int) VerboseLevel:(in int) FileMode:(in char) StartNetMonitorThread:(in char) 
 - (oneway void)TMExit:(byref in *Object) 
 - (char)ChangeVolumeChangeStatus:(byref in *Object) volumeChangeID:(in unsignedint) volumeChangeStatus:(in unsignedint) 
 - (char)ForceUpdate:(byref in *Object) 
 - (int)getESACount:(byref in *Object) 
 - (char)getESAId:(byref in *Object) ESAAtIndex:(in int) ESAID:(bycopy out * *Object) 
 - (char)getESASerialNumber:(byref in *Object) ESAAtIndex:(in int) serialNumber:(bycopy out * *Object) 
 - (char)Restart:(byref in *Object) ESAID:(bycopy in *Object) 
 - (void)ReceiveSleepNote:(*Object) 
 - (int)getNextESAEventType:(byref in *Object) 
 - (void)registerESAEventListener:(byref in *Object) 
 - (int)
 - (void)ReceiveWakeNote:(*Object) 
 - (oneway void)unregisterESAEventListener:(byref in *Object) 
 - (int)getNextESAVolumeChangedEvent:(byref in *Object) ESAID:(bycopy out * *Object) arraySize:(out * unsignedint) volumeChangeData:(bycopy out * *Object) 
 - (int)getNextESARemovalEvent:(byref in *Object) ESAID:(bycopy out * *Object) 
 - (int)getNextESAUpdateEvent:(byref in *Object) ESAID:(bycopy out * *Object) ESAUpdate:(bycopy out * *Object) 
 - (int)sendCDB:(byref in *Object) ESAID:(bycopy in *Object) cdb:(byref in *Object) cdbLength:(in unsignedint) cdbTransferType:(in unsignedint) data:(bycopy inout * *Object) dataSize:(inout * unsignedint) 
 - (int)dumpConfigurationInfo:(byref in *Object) ESAID:(bycopy in *Object) configurationData:(bycopy out * *Object) 
 - (int)dumpSystemSetting:(byref in *Object) ESAID:(bycopy in *Object) systemSettingsData:(bycopy out * *Object) 
 - (int)dumpProtocolVersion:(byref in *Object) ESAID:(bycopy in *Object) majorVersion:(out * unsignedint) minorVersion:(out * unsignedint) 
 - (int)dumpLUNInfo2:(byref in *Object) ESAID:(bycopy in *Object) arrayLUNData:(bycopy out * *Object) 
 - (int)dumpLUNInfo:(byref in *Object) ESAID:(bycopy in *Object) arrayLUNData:(bycopy out * *Object) 
 - (int)dumpSlotInfo:(byref in *Object) ESAID:(bycopy in *Object) arraySlotData:(bycopy out * *Object) 
 - (int)dumpCapacityInfo:(byref in *Object) ESAID:(bycopy in *Object) capacityInfo:(bycopy out * struct{ unsignedchar    char int   unsignedint in float out  unsignedlonglong unsignedlonglong unsignedlonglong unsignedlonglong }) 
 - (int)dumpStatusInfo:(byref in *Object) ESAID:(bycopy in *Object) statusInfo:(bycopy out * struct{ unsignedshort     short unsignedint in float out  unsignedint unsignedint unsignedint }) 
 - (unsignedlong)SendCommandEx:(byref in *Object) ESAID:(bycopy in *Object) inCmd:(bycopy in *Object) outCmd:(bycopy out * *Object) 
 - (unsignedlong)SendCommand:(byref in *Object) ESAID:(bycopy in *Object) cmd:(bycopy inout * *Object) 
 - (unsignedint)SetProConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(byref in *Object) 
 - (unsignedint)GetProConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy out * *Object) 
 - (unsignedint)SledAuthenticate:(byref in *Object) ESAID:(bycopy in *Object) sledSecurityInfo:(bycopy in *Object) 
 - (unsignedint)ShutdownSled:(byref in *Object) ESAID:(bycopy in *Object) dissentingVolume:(bycopy out * *Object) 
 - (unsignedint)SetSledConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy in *Object) 
 - (unsignedint)GetSledConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy out * *Object) 
 - (char)GetESA_PartitionCount:(byref in *Object) ESAID:(bycopy in *Object) partitionCount:(out * unsignedint) 
 - (char)SetESA_LUNLabels:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy in *Object) 
 - (char)GetESA_LUNLabels:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy out * *Object) 
 - (char)SetESA_DroboName:(byref in *Object) ESAID:(bycopy in *Object) droboName:(bycopy in *Object) 
 - (char)GetESA_DroboName:(byref in *Object) ESAID:(bycopy in *Object) droboName:(bycopy out * *Object) 
 - (char)SetESA_Time:(byref in *Object) ESAID:(bycopy in *Object) timeValue:(in unsignedint) GMTOffset:(in int) 
 - (char)GetESA_Time:(byref in *Object) ESAID:(bycopy in *Object) timeValue:(out * long) 
 - (char)SetOption_AutonomousLUNMgmt:(byref in *Object) ESAID:(bycopy in *Object) value:(in char) 
 - (char)SetOption_FeatureStates:(byref in *Object) ESAID:(bycopy in *Object) states:(in unsignedlonglong) 
 - (char)SetOption_RealTimeIntegrityChecking:(byref in *Object) ESAID:(bycopy in *Object) value:(in char) 
 - (char)SetOption_UseUnprotectedCapacity:(byref in *Object) ESAID:(bycopy in *Object) value:(in char) 
 - (char)SetOption_RedThreshold:(byref in *Object) ESAID:(bycopy in *Object) threshold:(in unsignedint) 
 - (char)SetOption_YellowThreshold:(byref in *Object) ESAID:(bycopy in *Object) threshold:(in unsignedint) 
 - (char)GetOption_RealTimeIntegrityChecking:(byref in *Object) ESAID:(bycopy in *Object) value:(out * char) 
 - (char)GetOption_UseUnprotectedCapacity:(byref in *Object) ESAID:(bycopy in *Object) value:(out * char) 
 - (char)GetOption_RedThreshold:(byref in *Object) ESAID:(bycopy in *Object) threshold:(out * unsignedint) 
 - (char)GetOption_YellowThreshold:(byref in *Object) ESAID:(bycopy in *Object) threshold:(out * unsignedint) 
 - (int)ClearBadShutdownFlag:(byref in *Object) ESAID:(bycopy in *Object) 
 - (int)InsertDrive:(byref in *Object) ESAID:(bycopy in *Object) slotId:(int) status:(out * int) 
 - (int)RemoveDrive:(byref in *Object) ESAID:(bycopy in *Object) slotId:(int) status:(out * int) 
 - (int)SetFlashConfig:(byref in *Object) ESAID:(bycopy in *Object) cmdStr:(bycopy in *Object) 
 - (int)RunEsaCommand:(byref in *Object) ESAID:(bycopy in *Object) cmdStr:(bycopy in *Object) cmdOutput:(bycopy out * *Object) 
 - (char)GetFirmwareFeatures:(byref in *Object) ESAID:(bycopy in *Object) features:(out * unsignedint) 
 - (unsignedint)GetDemoModeSupportInfo:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)SetDemoMode:(byref in *Object) ESAID:(bycopy in *Object) demoMode:(in unsignedint) scaleFactor:(in unsignedint) 
 - (char)GetDemoMode:(byref in *Object) ESAID:(bycopy in *Object) demoMode:(out * unsignedint) scaleFactor:(out * unsignedint) 
 - (char)SetUsedCapacity:(byref in *Object) ESAID:(bycopy in *Object) usedCapacity:(in unsignedlonglong) numPartitions:(in unsignedint) 
 - (char)UseOSCapacity:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)SetCapacityLEDs:(byref in *Object) ESAID:(bycopy in *Object) ledBits:(in unsignedint) 
 - (char)ResizeLuns:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) 
 - (char)CrashESA:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)DoEsaLockedDiags:(byref in *Object) ESAID:(bycopy in *Object) diagnosticsBinary:(bycopy in *Object) 
 - (char)UploadDiagnostics:(byref in *Object) ESAID:(bycopy in *Object) diagnosticsBinary:(bycopy in *Object) 
 - (char)RevertFirmware:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)InstallSledware:(byref in *Object) ESAID:(bycopy in *Object) firmwareBinary:(bycopy in *Object) 
 - (char)InstallFirmware:(byref in *Object) ESAID:(bycopy in *Object) firmwareBinary:(bycopy in *Object) 
 - (char)Identify:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)ClearVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)RetrieveVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) changeCount:(inout * unsignedint) volumeChangeArray:(bycopy out * *Object) 
 - (char)ProcessVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) changeCount:(in unsignedint) volumeChangeArray:(bycopy in *Object) 
 - (char)RenameUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) lunID:(in unsignedint) lunLabel:(bycopy in *Object) 
 - (char)Rename:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy in *Object) 
 - (char)ResizePartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) numLUNs:(in unsignedint) lunLabels:(bycopy in *Object) formatType:(in unsignedint) statusArray:(bycopy out * *Object) statusArraySize:(in unsignedint) 
 - (char)PartitionFormatUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) uniqueLUNID:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 
 - (char)ResizePartitionFormatLun:(byref in *Object) ESAID:(bycopy in *Object) lun:(in unsignedint) lunSize:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 
 - (char)DeleteUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) lunID:(in unsignedint) status:(out * unsignedint) 
 - (char)CreatePartitionFormatLUN:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 
 - (char)PartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy in *Object) reformat:(in char) formatType:(in unsignedint) lun:(in unsignedint) status:(out * unsignedint) 
 - (char)ESAPartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lun:(in unsignedint) partitionType:(in unsignedint) formatType:(in unsignedint) volumeLabel:(bycopy in *Object) blobSize:(in unsignedint) blob:(byref in *Object) 
 - (char)Reset:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)Format:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)Shutdown:(byref in *Object) ESAID:(bycopy in *Object) dissentingVolume:(bycopy out * *Object) 
 - (char)Standby:(byref in *Object) ESAID:(bycopy in *Object) dissentingVolume:(bycopy out * *Object) 
 - (int)SetEmailPreferences:(byref in *Object) username:(bycopy in *Object) emailSettings:(bycopy in *Object) 
 - (int)SetSystemPreferences:(byref in *Object) username:(bycopy in *Object) keyValues:(bycopy in *Object) type:(in unsignedint) 
 */