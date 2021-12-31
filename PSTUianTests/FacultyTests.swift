//
//  FacultyTests.swift
//  PSTUianTests
//
//  Created by Arhan Ashik on 2021/12/31.
//

import XCTest
import Combine
@testable import PSTUian

class FacultyTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        
    }
    
    override func tearDown() {
        subscriptions = []
    }

    //----------------- FACULTY Tests --------------------//
    func test_getting_faculties_success() {
        // dummy response
        let result = Result<[FacultyEntity], ApiError>.success([FacultyEntity.example1()])
        // test subject
        let vm = prepareVM(result: result)

        // test
        let promise = expectation(description: "getting faculties")
        vm.$data.sink { data in
            if(data.count > 0) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }

    func test_getting_faculties_error() {
        // dummy response
        let result = Result<[FacultyEntity], ApiError>.failure(ApiError.badURL)
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
    
    func prepareVM(result: Result<[FacultyEntity], ApiError>) -> FacultyVM {
        // moc service
        let service = ApiMockService(type: [FacultyEntity].self, result: result)
        // dummy repo
        let repo = FacultyRepo(service: service)
        
        return FacultyVM(repo: repo)
    }

}
