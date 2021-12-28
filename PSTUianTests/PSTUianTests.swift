//
//  PSTUianTests.swift
//  PSTUianTests
//
//  Created by Arhan Ashik on 2021/11/25.
//

import XCTest
import Combine
@testable import PSTUian

class PSTUianTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        
    }
    
    override func tearDown() {
        subscriptions = []
    }
    
    func test_getting_slider_success() {
        let result = Result<[SliderEntity], ApiError>.success([SliderEntity.example1()])
        let sliderVM = SliderViewModel(sliderService: SliderApiMockService(result: result))
        
        let promise = expectation(description: "getting sliders")
        
        sliderVM.$sliders.sink { sliders in
            if(sliders.count > 0) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 2)
    }
    
    func test_getting_slider_error() {
        let result = Result<[SliderEntity], ApiError>.failure(ApiError.badURL)
        let sliderVM = SliderViewModel(sliderService: SliderApiMockService(result: result))
        
        let promise = expectation(description: "show error message")
        sliderVM.$sliders.sink { sliders in
            if !sliders.isEmpty {
                XCTFail()
            }
        }.store(in: &subscriptions)
        
        sliderVM.$errorMessage.sink { errorMessage in
            if errorMessage != nil {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 2)
    }

}
