//
//  ApiServiceProtocol.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//
// DEPRECATED

import SwiftUI

@available(*, deprecated)
protocol SliderApiServiceProtocol {
    func getSliders(url: URL?, completion: @escaping(Result<[SliderEntity], ApiError>) -> Void)
}
