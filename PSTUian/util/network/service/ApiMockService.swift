//
//  ApiMockService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

struct ApiMockServie: ApiServiceProtocol {
    
//    var result: Result<T, ApiError>
    
    func fetch<T>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, ApiError>) -> Void) {
        
    }
}
