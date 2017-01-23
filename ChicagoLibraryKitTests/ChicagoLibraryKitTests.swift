//
//  ChicagoLibraryKitTests.swift
//  ChicagoLibraryKitTests
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import XCTest
@testable import ChicagoLibraryKit

class ChicagoLibraryKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLibraries() {
        let expectation = self.expectation(description: "Should be able to get all libraries")
        let libraryKit = ChicagoLibraryKit()
        libraryKit.getLibraries() { result in
            switch result {
            case let .success(libraries):
                print("libraries - \(libraries)")
                expectation.fulfill()
            case let .error(error):
                XCTFail("error - \(error)")
            }
        }
        
        waitForExpectations(timeout: 60) { error in
            XCTAssertNil(error, "Got an error getting forecast - \(error.debugDescription)")
        }
    }
    
}
