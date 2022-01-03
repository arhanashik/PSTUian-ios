//
//  DeviceRepo.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

class DeviceRepo: BaseRepo<DeviceEntity> {
    
    func registerDevice(completion: @escaping(Result<DeviceEntity, RepoError>) -> Void) {
        guard let newDevice = createNewDevice() else {
            completion(Result.failure(RepoError.localError(error: "Could not create device")))
            return
        }
        let oldDevice = getDevice()
        
        // device is registered and updated
        if(newDevice == oldDevice) {
            completion(Result.success(newDevice))
            return
        }
        // device is not registered yet/device is not updated
        let url = URL(string: Api.Device.Register)
        service.post(DeviceEntity.self, url: url, param: newDevice) { result in
            switch result {
                case .failure(let error):
                completion(Result.failure(RepoError.apiError(error: error)))
                print(error)
                case .success(_):
                // First try to delete old device if exists
                // Store new device
                if !self.saveDevice(newDevice) {
                    // Failed to store device
                    completion(Result.failure(RepoError.localError(error: "Could not store device")))
                    return
                }
                completion(Result.success(newDevice))
            }
        }
    }
    
    func saveDevice(_ device: DeviceEntity) -> Bool {
        return saveKeyChain(device, service: Key.KeyChain.DEVICE)
    }
    
    func getDevice() -> DeviceEntity? {
        return getKeyChain(Key.KeyChain.DEVICE, type: DeviceEntity.self)
    }
    
    func deleteDevice() -> Bool {
        return deleteKeyChain(service: Key.KeyChain.DEVICE)
    }
    
    func createNewDevice() -> DeviceEntity? {
        var deviceId: String? = getKeyChain(Key.KeyChain.DEVICE_ID, type: String.self)
        
        // Generate new device Id
        if deviceId == nil {
            deviceId = UIDevice.deviceId
            // If failed to generate deviceId return failed
            if deviceId == nil {
                print("Could not generate device Id")
                return nil
            }
            // Store new device Id
            if !saveKeyChain(deviceId, service: Key.KeyChain.DEVICE_ID) {
                // Failed to store device Id
                print("Could not store device Id")
                return nil
            }
        }
        
        return DeviceEntity(
            id: deviceId!,
            fcmToken: "",
            model: UIDevice.modelName,
            androidVersion: nil,
            iosVersion: UIDevice.version,
            appVersionCode: UIApplication.buildNumber,
            appVersionName: UIApplication.versionNumber,
            ipAddress: UIDevice.getIPAddress(),
            lat: "0.0",
            lng: "0.0",
            locale: UIApplication.locale,
            createdAt: "",
            updatedAt: ""
        )
    }
    
    func getConfig(completion: @escaping(Result<ConfigEntity, RepoError>) -> Void) {
        let url = URL(string: Api.GET_CONFIG)
        service.get(ConfigEntity.self, url: url, param: Paging.initial()) { result in
            switch result {
                case .failure(let error):
                print(error)
                completion(Result.failure(RepoError.apiError(error: error)))
                case .success(let data):
                if !self.saveConfig(data) {
                    // Failed to store device
                    completion(Result.failure(RepoError.localError(error: "Could not store config")))
                    return
                }
                completion(Result.success(data))
            }
        }
    }
    
    func saveConfig(_ config: ConfigEntity) -> Bool {
        return saveKeyChain(config, service: Key.KeyChain.CONFIG)
    }
    
    func getConfig() -> ConfigEntity? {
        return getKeyChain(Key.KeyChain.CONFIG, type: ConfigEntity.self)
    }
    
    func deleteConfig() -> Bool {
        return deleteKeyChain(service: Key.KeyChain.CONFIG)
    }
}
