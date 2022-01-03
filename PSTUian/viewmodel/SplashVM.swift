//
//  SplashVM.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

class SplashVM: ObservableObject {
    // Decides if splash view is active or not
    @Published var isActive: Bool = true
    
    @Published var data: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var alertItem: AlertItem?
    
    let repo: DeviceRepo
    init(repo: DeviceRepo = DeviceRepo()) {
        self.repo = repo
    }
    
    func registerDevice() {
        isLoading = true
        repo.registerDevice { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.alertItem = AlertContext.error
                    self.alertItem?.message = Text(error.localizedDescription)
                case .success(_):
                    self.clearCacheData()
                    self.checkForUpdate()
                }
            }
        }
    }
    
    func clearCacheData() {
    }
    
    func checkForUpdate() {
        getConfig()
    }
    
    func getConfig() {
        isLoading = true
        repo.getConfig { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.alertItem = AlertContext.error
                    self.alertItem?.message = Text(error.localizedDescription)
                case .success(let data):
                    print(data)
                    self.handleConfig(config: data)
                }
            }
        }
    }
    
    func handleConfig(config: ConfigEntity) {
        let lastDataRefreshVersion = UserDefaults.standard.string(forKey: Key.UserDefaults.DATA_REFRESH_VERSION) ?? ""
        if config.forceRefresh == 1 && config.dataRefreshVersion > lastDataRefreshVersion {
            // Refresh all data
            self.alertItem = AlertContext.error
            self.alertItem?.title = Text("Action Required")
            self.alertItem?.message = Text("Data refresh necessary")
            self.alertItem?.buttonTitle = Text("Refresh")
            self.alertItem?.action = { self.refreshData(version: config.dataRefreshVersion) }
        } else {
            self.isActive = false
        }
    }
    
    func refreshData(version: String) {
        if repo.deleteDevice() && repo.deleteConfig() {
            UserDefaults.standard.set(version, forKey: Key.UserDefaults.DATA_REFRESH_VERSION)
            registerDevice()
            return
        }
        
        self.alertItem = AlertContext.error
        self.alertItem?.message = Text("Data refresh failed")
        self.alertItem?.buttonTitle = Text("Try Again")
        self.alertItem?.action = { self.refreshData(version: version) }
    }
}
