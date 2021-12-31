//
//  SliderTests.swift
//  SliderTests
//
//  Created by Arhan Ashik on 2021/11/25.
//

import XCTest
import Combine
@testable import PSTUian

class SliderTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        
    }
    
    override func tearDown() {
        subscriptions = []
    }
    
    //----------- SLIDER TESTS -------------//
    func test_getting_slider_success() {
        // dummy response
        let result = Result<[SliderEntity], ApiError>.success([SliderEntity.example1()])
        // test subject
        let vm = prepareVM(result: result)

        // test
        let promise = expectation(description: "getting sliders")
        vm.$data.sink { data in
            if(data.count > 0) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }

    func test_getting_slider_error() {
        // dummy response
        let result = Result<[SliderEntity], ApiError>.failure(ApiError.badURL)
        // test subject
        let vm = prepareVM(result: result)

        // test
        let promise = expectation(description: "show error message")
        vm.$data.sink { data in
            if !data.isEmpty {
                XCTFail()
            }
        }.store(in: &subscriptions)

        // test
        vm.$errorMessage.sink { errorMessage in
            if errorMessage != nil {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }
    
    func prepareVM(result: Result<[SliderEntity], ApiError>) -> SliderVM {
        // moc service
        let service = ApiMockService(type: [SliderEntity].self, result: result)
        // dummy repo
        let repo = SliderRepo(service: service)
        
        return SliderVM(repo: repo)
    }
}
