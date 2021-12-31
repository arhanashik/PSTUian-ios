//
//  ApiMockService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//
// Responsible for providing mock data for api calls.
// Generic <Data: Codable> MUST have to be same type as T.
// Example of use:
// let service = ApiMockService(type: [SliderEntity].self, result: Result<[SliderEntity], ApiError>.failure(ApiError.badURL))

import SwiftUI


struct ApiMockService<Data: Codable>: ApiServiceProtocol {
    
    var type: Data.Type
    var result: Result<Data, ApiError>
    
    func fetch<T>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, ApiError>) -> Void) {
        completion(result as! Result<T, ApiError>)
    }
}
