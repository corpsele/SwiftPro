//
//  SwiftProUITests.swift
//  SwiftProUITests
//
//  Created by eport on 2019/7/11.
//  Copyright © 2019 eport. All rights reserved.
//

import XCTest

class SwiftProUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 3).swipeUp()
        let cell15 = tablesQuery.cells.element(boundBy: 14)
        cell15.tap()
        app.buttons["显示左侧menu"].tap()
        expectation(for: NSPredicate { _, _ in
            struct Holder { static let startTime = CACurrentMediaTime() }

//            if checkSomehowThatCallbackFired() {
//                XCTFail("Callback fired when it shouldn't have.")
//                return true
//            }

            return Holder.startTime.distance(to: CACurrentMediaTime()) > 1.0 // or however long you want to wait
        }, evaluatedWith: self, handler: nil)
        waitForExpectations(timeout: 10.0 /* longer than wait time above */, handler: nil)

//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["22"]/*[[".cells.staticTexts[\"22\"]",".staticTexts[\"22\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//
//        let staticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["23"]/*[[".cells.staticTexts[\"23\"]",".staticTexts[\"23\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        staticText.swipeUp()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["26"]/*[[".cells.staticTexts[\"26\"]",".staticTexts[\"26\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["24"]/*[[".cells.staticTexts[\"24\"]",".staticTexts[\"24\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
//        staticText.swipeDown()
//
//        let staticText2 = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["15"]/*[[".cells.staticTexts[\"15\"]",".staticTexts[\"15\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        staticText2.tap()
//
//        let backButton = app.navigationBars["SwiftPro.SliderMenuTestVC"].buttons["Back"]
//        backButton.tap()
//        staticText2.tap()
//        app.buttons["显示左侧menu"].tap()
//        app.staticTexts["Test"].tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
//        backButton.tap()
//        backButton.tap()
    }
}
