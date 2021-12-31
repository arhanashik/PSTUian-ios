//
//  ApiServiceProtocol.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI


protocol ApiServiceProtocol {
    func fetch<T: Codable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T, ApiError>) -> Void)
}
