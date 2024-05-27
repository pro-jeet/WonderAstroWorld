//
//  testAstroListViewUITests.swift
//  WonderAstroWorldUITests
//
//  Created by JSharma on 27/05/24.
//

import XCTest
@testable import WonderAstroWorld

final class testAstroListViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.swipeUp()
        element.swipeUp()
        element.swipeDown()
        element.swipeDown()
        
    }
    
    func testCalendarButtonClick() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let ttgc7swiftui32navigationstackhostingNavigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".otherElements[\"Calendar\"].buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    }
    
    func testAstroListStaticTextLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["Picture of the Day"].tap()
        app.staticTexts["Wonder Astronomy"].tap()
    }
    
    func testAstroDetailViewLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeUp()
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Read More"].tap()
        elementsQuery.buttons["Read Less"].tap()
        
        let ttgc7swiftui32navigationstackhostingNavigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["HD"]/*[[".otherElements[\"HD\"].buttons[\"HD\"]",".buttons[\"HD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["Normal"]/*[[".otherElements[\"Normal\"].buttons[\"Normal\"]",".buttons[\"Normal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        ttgc7swiftui32navigationstackhostingNavigationBar.buttons["Back"].tap()
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
