//
//  Response.swift
//  PSTUian
//
//  Created by Md Hasnain on 2021/12/28.
//

import SwiftUI

struct Response<T : Codable>: Codable {
    let code: Int?
    let success: Bool
    let message: String
    let data: T?
}

struct AuthResponse<T : Codable>: Codable {
    let code: Int?
    let success: Bool
    let message: String
    let data: T?
    let authToken: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case success
        case message
        case data
        case authToken = "auth_token"
    }
}
