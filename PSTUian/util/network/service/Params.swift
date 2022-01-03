//
//  Params.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

struct Paging: Codable {
    var page: Int
    let limit: Int
    
    static func initial() -> Paging {
        return Paging(page: 1, limit: 20)
    }
}

struct SignInParams: Codable {
    let userType: String
    let email: String
    let password: String
    let deviceId: String
    
    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case email
        case password
        case deviceId = "device_id"
    }
}
