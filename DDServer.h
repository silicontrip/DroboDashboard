
@interface DDServer: NSObject {


}

// some of this information from ftp://drobo.com/drobohacks/TransportManager/dll/TransportManager.h

- (char)subscribeClient:(NSDistantObject *)object;
- (void)unsubscribeClient:(NSDistantObject *)object; 
- (char)getESASerialNumber:(NSDistantObject *)object ESAAtIndex:(int)index serialNumber:(NSString **)serial;

///\brief Initialize the Transport Manager
/// By calling this function, transport manager will start to enumeration
/// ESA devices and start the polling thread for each of the detected ESA
/// devices.  The intialize method will also start the PNPManager to
/// monitor the device arrival/removal.
///\param simulationMode set true to enable the simulation mode.
///\param pollInterval the time between each polling interval.  This value is in the unit of seconds.
///\param level set the logging level
///\param fileMode set true to enable output to a file.
- (void)TMInit:(NSDistantObject *)object simulationMode:(char)sim PollingInterval:(int)poll VerboseLevel:(int)ver FileMode:(char)mode StartNetMonitorThread:(char)thread; 

///\brief Release the Transport Manager
/// By calling this function, transport manager will prepare for termination
- (oneway void)TMExit:(NSDistantObject *)object; 

///\brief Register the Transport Manager Listener with Transport Manager.
/// This method should be called before invoking the TMInit method.
/// Once registering your listener, the transport manager will
/// invoke the callback functions immediately,
/// so that the host application can get the initial capacity 
/// information.  Once the callback functions are invoked, the callback 
/// functions will only get invoked again if the event occurred again.
///\param listener Your implementation of the TransportManagerListener.  
- (void)registerESAEventListener:(NSDistantObject *)object;

///\brief Unregister the Transport Manager Listener with Transport Manager.
/// This will remove the listener from receiving TM broadcasts.
///\param listener Your implementation of the TransportManagerListener.  
- (oneway void)unregisterESAEventListener:(NSDistantObject *)object; 

- (int)getNextESAEventType:(NSDistantObject *)object; 
- (int)getNextESAUpdateEvent:(NSDistantObject *)object ESAID:(NSString **)esaid ESAUpdate:(NSString **)update; 
- (unsigned long)SendCommand:(NSDistantObject *)object ESAID:(NSString *)esaid cmd:(NSData **)data; 

///\brief Get the ESA time
///\param pESAID the ESA we want to set the time
///\param pValue a provided buffer location for a returned value (seconds since 01/01/1970 00:00 GMT)
///\return true if we are able to get the value successfully
- (char)GetESA_Time:(NSDistantObject *)object ESAID:(NSString *)pESAID timeValue:(long *)pValue; 

- (char)GetESA_DroboName:(NSDistantObject *)object ESAID:(NSString *)esaid droboName:(NSString **)name;

///\brief Get the number of partitions currently specified within the ESA
///\param pESAID the ESA we want to set the descriptive name
///\param pValue a provided buffer location for a returned value (# of partitions)
///\return true if we are able to set the value successfully.
- (char)GetESA_PartitionCount:(NSDistantObject *)object ESAID:(NSString *)pESAID partitionCount:(unsigned int *)pValue; 

///\brief Gets the volume(LUN) labels (and drive letters on Windows) associated with a specific ESA
///The names are ordered from lowest LUN to highest LUN
///ex. Windows -> "G: Drobo1, H: Drobo2"      Mac -> "Drobo1, Drobo2"
///\param pESAID the ESA we want to set the descriptive name
///\param pValue a provided buffer location for a returned value
///\param pBufferSize the size in bytes of the provided buffer
///\return true if we are able to set the value successfully.
- (char)GetESA_LUNLabels:(NSDistantObject *)object ESAID:(NSString *)pESAID lunLabels:(NSString **)pValue; 

- (unsigned int)GetProConfig:(NSDistantObject *)object ESAID:(NSString *)esaid configInfo:(NSData **)data; 

///\ brief Get current Sled configurations
///\param pESAID identifies an ESA connected to the Sled whose config we wish to get.
///\param pSledConfigInfo is reference to a SledConfigInfo struct to be filled with current Sled config values.
///\return one of SledConfigStatus::*
- (unsigned int)GetSledConfig:(NSDistantObject *)object ESAID:(NSString *)pESAID configInfo:(NSData **)pSledConfigInfo; 

///\brief Get the firmware feature table from the esa
///\param pESAID is the esa whose feature table we want to query
///\param pFeatures points to the returned feature table value
- (char)GetFirmwareFeatures:(NSDistantObject *)object ESAID:(NSString *)pESAID features:(unsigned int*)pFeatures; 

///\brief Get the current realtime integrity checking value
///\param pESAID ID that specifies the ESA we want to retrieve the setting from. 
///\param pValue a provided buffer location for a returned value
///\return true if we are able to get the value successfully
- (char)GetOption_RealTimeIntegrityChecking:(NSDistantObject *)object ESAID:(NSString *)pESAID value:(char *)pValue;

///\brief Get the current use unprotected capacity value
///\param pESAID ID that specifies the ESA we want to retrieve the setting from. 
///\param pValue a provided buffer location for a returned value
///\return true if we are able to get the value successfully
- (char)GetOption_UseUnprotectedCapacity:(NSDistantObject *)object ESAID:(NSString *)pESAID value:(char *)pValue;

///\brief Get the current red alert threshold setting
///\param pESAID ID that specifies the ESA we want to retrieve the setting from. 
///\param pValue a provided buffer location for a returned value
///\return true if we are able to get the value successfully
- (char)GetOption_RedThreshold:(NSDistantObject *)object ESAID:(NSString *)pESAID threshold:(unsigned int*)pValue; 

///\brief Get the current yellow alert threshold setting
///\param pESAID ID that specifies the ESA we want to retrieve the setting from.
///\param pValue a provided buffer location for a returned value
///\return true if we are able to get the value successfully
- (char)GetOption_YellowThreshold:(NSDistantObject *)object ESAID:(NSString *)pESAID threshold:(unsigned int*)pValue; 

///\brief Get DemoMode support info on the esa
///\param pESAID is the esa whose DemoMode support we want to query
- (unsigned int)GetDemoModeSupportInfo:(NSDistantObject *)object ESAID:(NSString *)pESAID; 

///\brief Get the current red alert threshold setting
///\param pESAID ID that specifies the ESA we want to retrieve the setting from. 
///\param pValue a provided buffer location for a returned value
///\return true if we are able to get the value successfully
- (char)SetOption_RedThreshold:(NSDistantObject *)object ESAID:(NSString *)pESAID threshold:(unsigned int)pValue;

///\brief Identify the ESA
///\param pESAID the ESA we want to perform this operation.
///\return true if the operation submitted successfully.
- (char)Identify:(NSDistantObject *)object ESAID:(NSString *)pESAID; 

///\brief Standby the ESA
///\param pESAID the ESA we want to perform this operation.
///\param pDissentingVolume a provided string buffer to contain the name of any volume with activity preventing the Standby.
///\return true if the operation submitted successfully.
- (char)Standby:(NSDistantObject *)object ESAID:(NSString *)pESAID dissentingVolume:(NSString **)pDissentingVolume;

///\brief Force a TM re-broadcast of all connected ESAs
///\return true if the operation submitted successfully.
- (char)ForceUpdate:(NSDistantObject *)object;

///@cond UNIT_TEST
// The api below are used for tranport manager's unit testing purpose.
// Host application MUST NOT depend on any of the APIs below.

- (int)getESACount:(NSDistantObject *)object;
- (char)getESAId:(NSDistantObject *)object ESAAtIndex:(int)index ESAID:(NSString **)esaid;
- (int)dumpSlotInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arraySlotData:(NSData **)data; 
- (int)dumpLUNInfo:(NSDistantObject *)object ESAID:(NSString *)esaid arrayLUNData:(NSData **)data; 
- (int)dumpDiskPackInfo:(NSDistantObject *)object ESAID:(NSString *)esaid diskPackData:(NSData **)data; 
- (int)dumpFirmwareInfo:(NSDistantObject *)object ESAID:(NSString *)esaid firmwareData:(NSData **)data; 
- (int)dumpOption2:(NSDistantObject *)object ESAID:(NSString *)esaid options2Data:(NSData **) data;
- (int)dumpOption:(NSDistantObject *)object ESAID:(NSString *)esaid optionsData:(NSData **) data; 
// - (int)sendCDB:(byref in *Object) ESAID:(bycopy in *Object) cdb:(byref in *Object) cdbLength:(in unsignedint) cdbTransferType:(in unsignedint) data:(bycopy inout * *Object) dataSize:(inout * unsignedint) 
// - (int)dumpConfigurationInfo:(byref in *Object) ESAID:(bycopy in *Object) configurationData:(bycopy out * *Object) 
// - (int)dumpSystemSetting:(byref in *Object) ESAID:(bycopy in *Object) systemSettingsData:(bycopy out * *Object) 
// - (int)dumpProtocolVersion:(byref in *Object) ESAID:(bycopy in *Object) majorVersion:(out * unsignedint) minorVersion:(out * unsignedint) 
// - (int)dumpLUNInfo2:(byref in *Object) ESAID:(bycopy in *Object) arrayLUNData:(bycopy out * *Object) 
// - (int)dumpLUNInfo:(byref in *Object) ESAID:(bycopy in *Object) arrayLUNData:(bycopy out * *Object) 
// - (int)dumpSlotInfo:(byref in *Object) ESAID:(bycopy in *Object) arraySlotData:(bycopy out * *Object) 

struct CapacityInfo
{
	unsigned char c1;
	char c2;
	int i1;
	unsigned int i2;
	float f1;
	unsigned long long mFreeCapacityProtected;
	unsigned long long mUsedCapacityProtected;
	unsigned long long mTotalCapacityProtected;
	unsigned long long mTotalCapacityUnprotected;
};



- (int)dumpCapacityInfo:(NSDistantObject *)object ESAID:(NSString *)esaid capacityInfo:(struct CapacityInfo**)capacity;

struct StatusInfo {
	unsigned short s1;
	short s2;
	unsigned int i1;
	float f1;
	unsigned int mStatus;
	unsigned int mRelayoutCount;
	unsigned int mDiskPackStatus;
};


- (int)dumpStatusInfo:(NSDistantObject *)object ESAID:(NSString *)pESAID statusInfo:(struct StatusInfo **)status; 


@end
/*
 - (char)ChangeVolumeChangeStatus:(byref in *Object) volumeChangeID:(in unsignedint) volumeChangeStatus:(in unsignedint) \
 
 ///\brief Restart the ESA
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)Restart:(byref in *Object) ESAID:(bycopy in *Object) 

 - (void)ReceiveSleepNote:(*Object) 
 - (void)ReceiveWakeNote:(*Object) 
 
 
 - (int)getNextESAVolumeChangedEvent:(byref in *Object) ESAID:(bycopy out * *Object) arraySize:(out * unsignedint) volumeChangeData:(bycopy out * *Object) 
 - (int)getNextESARemovalEvent:(byref in *Object) ESAID:(bycopy out * *Object) 
 - (int)getNextESAUpdateEvent:(byref in *Object) ESAID:(bycopy out * *Object) ESAUpdate:(bycopy out * *Object) 
 - (unsignedlong)SendCommandEx:(byref in *Object) ESAID:(bycopy in *Object) inCmd:(bycopy in *Object) outCmd:(bycopy out * *Object) 
 - (unsignedlong)SendCommand:(byref in *Object) ESAID:(bycopy in *Object) cmd:(bycopy inout * *Object) 
 - (unsignedint)SetProConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(byref in *Object) 
 - (unsignedint)GetProConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy out * *Object) 
 
 ///\ brief Ask the sled to authenticate the user credentials passed in
 ///\param pESAID identifies an ESA connected to the Sled.
 ///\param pSledSecurityInfo is a reference to a SledSecurityInfo struct containing the user credentials. If this
 ///\      parameter is null, try using the TM's cached version of these credentials.
 ///\return one of SledConfigStatus::*
  - (unsignedint)SledAuthenticate:(byref in *Object) ESAID:(bycopy in *Object) sledSecurityInfo:(bycopy in *Object) 
 
 ///\ brief Shutdown the sled. in practice this consists of putting all connected Drobos into standby
 ///\param pESAID identifies an ESA connected to the Sled whose config we wish to get.
 ///\return one of SledConfigStatus::* 
 - (unsignedint)ShutdownSled:(byref in *Object) ESAID:(bycopy in *Object) dissentingVolume:(bycopy out * *Object) 
 
 ///\ brief Set Sled configurations
 ///\param pESAID identifies an ESA connected to the Sled whose config we wish to set.
 ///\param pSledConfigInfo is reference to a SledConfigInfo struct containing the config to set on the Sled.
 ///\return one of SledConfigStatus::* 
 - (unsignedint)SetSledConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy in *Object) 
 
 ///\ brief Get current Sled configurations
 ///\param pESAID identifies an ESA connected to the Sled whose config we wish to get.
 ///\param pSledConfigInfo is reference to a SledConfigInfo struct to be filled with current Sled config values.
 ///\return one of SledConfigStatus::* 
 - (unsignedint)GetSledConfig:(byref in *Object) ESAID:(bycopy in *Object) configInfo:(bycopy out * *Object) 
 
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
 
 ///\brief Set flash configuration on the esa
 ///\param pESAID is the esa whose DemoMode we want to change
 ///\param configuration key-value pair string. 
 - (int)SetFlashConfig:(byref in *Object) ESAID:(bycopy in *Object) cmdStr:(bycopy in *Object) 
 
 ///\brief Run an ESA command on the esa
 ///\param pESAID is the esa whose DemoMode we want to change
 ///\param command length and string. 
 - (int)RunEsaCommand:(byref in *Object) ESAID:(bycopy in *Object) cmdStr:(bycopy in *Object) cmdOutput:(bycopy out * *Object) 

 
 - (char)SetDemoMode:(byref in *Object) ESAID:(bycopy in *Object) demoMode:(in unsignedint) scaleFactor:(in unsignedint) 
 - (char)GetDemoMode:(byref in *Object) ESAID:(bycopy in *Object) demoMode:(out * unsignedint) scaleFactor:(out * unsignedint) 
 - (char)SetUsedCapacity:(byref in *Object) ESAID:(bycopy in *Object) usedCapacity:(in unsignedlonglong) numPartitions:(in unsignedint) 
 - (char)UseOSCapacity:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)SetCapacityLEDs:(byref in *Object) ESAID:(bycopy in *Object) ledBits:(in unsignedint) 
 - (char)ResizeLuns:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) 
 - (char)CrashESA:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)DoEsaLockedDiags:(byref in *Object) ESAID:(bycopy in *Object) diagnosticsBinary:(bycopy in *Object) 
 
 ///\brief Upload diags from the ESA
 ///\param pESAID the ESA we want to perform this operation on.
 ///\param diagnosticsBinary the path to the file to create or overwrite with diagnostics.
 ///\return true if the operation submitted successfully. 
 - (char)UploadDiagnostics:(byref in *Object) ESAID:(bycopy in *Object) diagnosticsBinary:(bycopy in *Object) 
 
 ///\brief RevertFirmware the ESA
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)RevertFirmware:(byref in *Object) ESAID:(bycopy in *Object) 

 ///\brief InstallSledware the Sled
 ///\param pESAID the ESA we want to perform this operation.
 ///\param firmwareBinary the location of the firmware image that needs to be uploaded to the ESA.
 ///\return true if the operation submitted successfully. 
 - (char)InstallSledware:(byref in *Object) ESAID:(bycopy in *Object) firmwareBinary:(bycopy in *Object)
 
 ///\brief InstallFirmware the ESA
 ///\param pESAID the ESA we want to perform this operation.
 ///\param firmwareBinary the location of the firmware image that needs to be uploaded to the ESA.
 ///\return true if the operation submitted successfully.
 - (char)InstallFirmware:(byref in *Object) ESAID:(bycopy in *Object) firmwareBinary:(bycopy in *Object) 

 - (char)ClearVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) 
 - (char)RetrieveVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) changeCount:(inout * unsignedint) volumeChangeArray:(bycopy out * *Object) 
 - (char)ProcessVolumeChanges:(byref in *Object) ESAID:(bycopy in *Object) changeCount:(in unsignedint) volumeChangeArray:(bycopy in *Object) 
 - (char)RenameUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) lunID:(in unsignedint) lunLabel:(bycopy in *Object) 
 
 ///\brief A function that encapsulates renaming an ESA's current LUNs. 
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)Rename:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy in *Object) 
 
 ///\brief A function that encapsulates resizing an ESA's current LUN size and then partitioning, formatting, and naming the new LUNs. 
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)ResizePartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) numLUNs:(in unsignedint) lunLabels:(bycopy in *Object) formatType:(in unsignedint) statusArray:(bycopy out * *Object) statusArraySize:(in unsignedint) 
 - (char)PartitionFormatUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) uniqueLUNID:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 
 
 ///\brief OS level partition/format of a lun on the ESA. The lun resize part implied by the function name is currently not supported.
 ///\param pESAID the ESA we want to perform this operation.
 ///\param LUNNumber the lun number of the lun to format.
 ///\param LUNSize the size of the lun. Currently ignored.
 ///\param pLUNLabel the volume label to use for the new volume created.
 ///\param FormatType the filesystem type to use.
 ///\param pStatus the status of the operation to be filled in by this function. The value is one of PartitionFormatStatus::*.
 ///\return true if the operation submitted successfully. 
 - (char)ResizePartitionFormatLun:(byref in *Object) ESAID:(bycopy in *Object) lun:(in unsignedint) lunSize:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 

 - (char)DeleteUniqueLUN:(byref in *Object) ESAID:(bycopy in *Object) lunID:(in unsignedint) status:(out * unsignedint) 
 - (char)CreatePartitionFormatLUN:(byref in *Object) ESAID:(bycopy in *Object) lunSize:(in unsignedint) lunLabel:(bycopy in *Object) formatType:(in unsignedint) status:(out * unsignedint) 
 
 ///\brief OS level partition/format of the ESA. 
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)PartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lunLabels:(bycopy in *Object) reformat:(in char) formatType:(in unsignedint) lun:(in unsignedint) status:(out * unsignedint) 
 
 ///\brief Function to partition and format the ESA for those partitions and formats the array understands
 ///\param pESAID the ESA we want to perform this operation on.
 ///\param partitionFormatInfo the info for partitioning and formatting 
 - (char)ESAPartitionFormat:(byref in *Object) ESAID:(bycopy in *Object) lun:(in unsignedint) partitionType:(in unsignedint) formatType:(in unsignedint) volumeLabel:(bycopy in *Object) blobSize:(in unsignedint) blob:(byref in *Object) 
 - (char)Reset:(byref in *Object) ESAID:(bycopy in *Object)
 
 ///\brief Low level device format of the ESA. 
 ///\param pESAID the ESA we want to perform this operation.
 ///\return true if the operation submitted successfully. 
 - (char)Format:(byref in *Object) ESAID:(bycopy in *Object) 
 
 - (int)SetEmailPreferences:(byref in *Object) username:(bycopy in *Object) emailSettings:(bycopy in *Object) 
 - (int)SetSystemPreferences:(byref in *Object) username:(bycopy in *Object) keyValues:(bycopy in *Object) type:(in unsignedint) 
 */