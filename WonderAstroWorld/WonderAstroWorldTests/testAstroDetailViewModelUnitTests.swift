//
//  testAstroDetailViewModelUnitTests.swift
//  WonderAstroWorldTests
//
//  Created by JSharma on 28/05/24.
//

import XCTest
@testable import WonderAstroWorld

final class testAstroDetailViewModelUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetData() throws {
        
        let expectation = XCTestExpectation(description: "Fetch data completion called")

        let mockURLString = "https://apod.nasa.gov/apod/image/2405/AuroraStartrails_chiragupreti1024.jpg"
        
        let cardViewModel = AstroDetailViewModel()
        
        cardViewModel.getData(urlString: mockURLString, key: "", isHD: false, completion: { uiImage, error in
            
            if error == nil {
                XCTAssertNotNil(uiImage)
            } else {
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
            
        })
        
    }

}
