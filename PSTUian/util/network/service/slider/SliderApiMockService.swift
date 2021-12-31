//
//  ApiMockService.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//
//  DEPRECATED

import SwiftUI

@available(*, deprecated)
struct SliderApiMockService: SliderApiServiceProtocol {
    
    var result: Result<[SliderEntity], ApiError>
    
    func getSliders(url: URL?, completion: @escaping (Result<[SliderEntity], ApiError>) -> Void) {
        completion(result)
    }
}
