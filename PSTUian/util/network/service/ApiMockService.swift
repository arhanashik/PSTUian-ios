//
//  ApiMockService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//
// Responsible for providing mock data for api calls.
// Generic <P: Codable> MUST have to be same type as T.
// Example of use:
// let service = ApiMockService(type: [SliderEntity].self, result: Result<[SliderEntity], ApiError>.failure(ApiError.badURL))

import SwiftUI


struct ApiMockService<P: Codable>: ApiServiceProtocol {
    
    var type: P.Type
    var result: Result<P, ApiError>
    
    func get<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param?, completion: @escaping (Result<T, ApiError>) -> Void) {
        completion(result as! Result<T, ApiError>)
    }
    
    func post<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param, completion: @escaping (Result<T, ApiError>) -> Void) {
        completion(result as! Result<T, ApiError>)
    }
    
    func auth<Param: Codable, T: Codable>(_ type: T.Type, url: URL?, param: Param, completion: @escaping (Result<AuthResponse<T>, ApiError>) -> Void) {
    }
}
