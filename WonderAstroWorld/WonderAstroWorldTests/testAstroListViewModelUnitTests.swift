//
//  testAstroListViewModelUnitTests.swift
//  WonderAstroWorldTests
//
//  Created by JSharma on 28/05/24.
//

import XCTest
@testable import WonderAstroWorld

final class testAstroListViewModelUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAstroData() throws {
        
        let expectation = XCTestExpectation(description: "Fetch data completion called")
        
        let astroListViewModel = AstroListViewModel()
        let date = Date()
        astroListViewModel.fetchAstroData(endDate: date, completion: { astroArray, error in
            if error == nil {
                XCTAssertNotNil(astroArray)
            } else {
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
    }
    
    func testDateLimit() throws {
                
        let astroListViewModel = AstroListViewModel()
        XCTAssertNotNil(astroListViewModel.dateLimit)
    }
    
    func testStartDate() throws {
        
        let astroListViewModel = AstroListViewModel()
        let date = astroListViewModel.getStartDate(endDate: Date())
        XCTAssertNotNil(date)
 
    }
    
    func testEndDate() throws {
        
        let astroListViewModel = AstroListViewModel()
        let date = astroListViewModel.getEndDate(date: Date())
        XCTAssertNotNil(date)
 
    }

}
