//
//  DeviceEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

struct DeviceEntity: Codable, Identifiable, Equatable {
    let id: String
    let fcmToken: String?
    let model: String?
    let androidVersion: String?
    let iosVersion: String?
    let appVersionCode: Int?
    let appVersionName: String?
    let ipAddress: String?
    let lat: String?
    let lng: String?
    let locale: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fcmToken = "fcm_token"
        case model
        case androidVersion = "android_version"
        case iosVersion = "ios_version"
        case appVersionCode = "app_version_code"
        case appVersionName = "app_version_name"
        case ipAddress = "ip_address"
        case lat
        case lng
        case locale
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    static func example1() -> DeviceEntity {
        return DeviceEntity(id: "1", fcmToken: "", model: "iPhone 12 Pro", androidVersion: nil, iosVersion: nil, appVersionCode: 1, appVersionName: "1.0.0", ipAddress: "0.0.0.0", lat: "0.0", lng: "0.0", locale: "en", createdAt: "", updatedAt: "")
    }
}
