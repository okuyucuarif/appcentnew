//
//  AppCentNewTests.swift
//  AppCentNewTests
//
//  Created by ArifOk on 9.06.2021.
//

import XCTest
@testable import AppCentNew

class AppCentNewTests: XCTestCase {
    
    var sut: NewsViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = NewsViewModel(delegate: MockServiceProtocol())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testExample() throws {
        XCTAssertEqual("https://newsapi.org/v2/everything?q=tesla&page=1&apiKey=873cfce39d554c5d851e863a8f4df624", sut!.getURL("tesla", 1))
        XCTAssertEqual("https://newsapi.org/v2/everything?q=tesla&page=2&apiKey=873cfce39d554c5d851e863a8f4df624", sut!.getURL("tesla", 2))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockServiceProtocol: NewsServiceResponse {
    func serviceResponseSucces() {
        //
    }
    
    func serviceResponseFailure() {
        //
    }
    
    
}
