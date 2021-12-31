//
//  BatchTests.swift
//  PSTUianTests
//
//  Created by Arhan Ashik on 2021/12/31.
//

import XCTest
import Combine
@testable import PSTUian

class BatchTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        
    }
    
    override func tearDown() {
        subscriptions = []
    }

    //----------------- Batch Tests --------------------//
    func test_getting_batches_success() {
        // dummy response
        let result = Result<[BatchEntity], ApiError>.success([BatchEntity.example1()])
        // test subject
        let vm = prepareVM(result: result)

        // test
        let promise = expectation(description: "getting batches")
        vm.$data.sink { data in
            if(data.count > 0) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }

    func test_getting_batches_error() {
        // dummy response
        let result = Result<[BatchEntity], ApiError>.failure(ApiError.badURL)
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
    
    func prepareVM(result: Result<[BatchEntity], ApiError>) -> BatchVM {
        // moc service
        let service = ApiMockService(type: [BatchEntity].self, result: result)
        // dummy repo
        let repo = BatchRepo(service: service)
        
        return BatchVM(repo: repo)
    }

}
