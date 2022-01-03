//
//  ConfigEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

struct ConfigEntity: Codable {
    let id: Int
    let androidVersion: String
    let iosVersion: String
    let dataRefreshVersion: String
    let apiVersion: String
    let adminApiVersion: String
    let forceRefresh: Int
    let forceUpdate: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case androidVersion = "android_version"
        case iosVersion = "ios_version"
        case dataRefreshVersion = "data_refresh_version"
        case apiVersion = "api_version"
        case adminApiVersion = "admin_api_version"
        case forceRefresh = "force_refresh"
        case forceUpdate = "force_update"
    }
}
