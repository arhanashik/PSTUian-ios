//
//  ApiServiceProtocol.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI


protocol ApiServiceProtocol {
    func get<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param?, completion: @escaping(Result<T, ApiError>) -> Void)
    func post<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param, completion: @escaping(Result<T, ApiError>) -> Void)
    func auth<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param?, completion: @escaping(Result<AuthResponse<T>, ApiError>) -> Void)
}
