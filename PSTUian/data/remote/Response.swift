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
