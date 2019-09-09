//
//  CordovaTestUITests.m
//  CordovaTestUITests
//
//  Created by eport on 2019/5/23.
//  Copyright © 2019 eport. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CordovaTestUITests : XCTestCase

@end

@implementation CordovaTestUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    XCUIElementQuery *tablesQuery = app.tables;
//    XCUIElement *staticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\U5316\U9a8c\U65b9\U6cd5"]/*[[".cells.staticTexts[@\"\\U5316\\U9a8c\\U65b9\\U6cd5\"]",".staticTexts[@\"\\U5316\\U9a8c\\U65b9\\U6cd5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
//    [staticText swipeUp];
//
//    XCUIElement *element = [[[app.otherElements containingType:XCUIElementTypeAlert identifier:@"\U672a\U627e\U5230\U63d2\U4ef6"] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
//    [element swipeUp];
//    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\U8de8\U5883\U4e2a\U4eba\U6d88\U8d39\U4fe1\U606f"]/*[[".cells.staticTexts[@\"\\U8de8\\U5883\\U4e2a\\U4eba\\U6d88\\U8d39\\U4fe1\\U606f\"]",".staticTexts[@\"\\U8de8\\U5883\\U4e2a\\U4eba\\U6d88\\U8d39\\U4fe1\\U606f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeUp];
//    [element swipeUp];
//    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\U8fdb\U51fa\U53e3\U5546\U54c1\U7a0e\U7387"]/*[[".cells.staticTexts[@\"\\U8fdb\\U51fa\\U53e3\\U5546\\U54c1\\U7a0e\\U7387\"]",".staticTexts[@\"\\U8fdb\\U51fa\\U53e3\\U5546\\U54c1\\U7a0e\\U7387\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeUp];
//    [staticText tap];
//
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"\U62a5\U5173\U5355\U67e5\U8be2"]/*[[".cells.staticTexts[@\"\\U62a5\\U5173\\U5355\\U67e5\\U8be2\"]",".staticTexts[@\"\\U62a5\\U5173\\U5355\\U67e5\\U8be2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
//
//    XCUIElement *okButton = app.alerts.buttons[@"OK"];
//    [okButton tap];
//
//    XCUIElementQuery *webViewsQuery = app.webViews;
//    [webViewsQuery.buttons[@"\U67e5\U8be2"] tap];
//
//    XCUIElement *textField = webViewsQuery.textFields[@"\U8bf7\U8f93\U5165\U62a5\U5173\U5355\U7f16\U53f7"];
//    [textField tap];
//
//    XCUIElement *textField2 = webViewsQuery.textFields[@"\U8bf7\U8f93\U5165\U4e2d\U5fc3\U7edf\U4e00\U7f16\U53f7"];
//    [textField2 tap];
//
//    XCUIElement *textField3 = webViewsQuery.textFields[@"\U8bf7\U8f93\U5165\U6536\U53d1\U8d27\U4eba\U7f16\U53f7"];
//    [textField3 tap];
//    [webViewsQuery.staticTexts[@"\U81f3\U5c11\U586b\U5199\U4e00\U9879\U67e5\U8be2\U6761\U4ef6"] tap];
//    [textField tap];
//    [textField2 tap];
//    [webViewsQuery.otherElements[@"1"] tap];
//    [app.toolbars[@"Toolbar"].buttons[@"Done"] tap];
//    [textField3 tap];
//    [textField3 tap];
//
//    XCUIElement *switch2 = webViewsQuery.switches[@"\U67e5\U8be2"];
//    [switch2 tap];
//    [textField tap];
//    [switch2 tap];
//    [textField tap];
//    [switch2 tap];
//    [textField2 tap];
//    [okButton tap];
//    [okButton tap];
//    [app.navigationBars[@"CordovaTest.PluginView"].buttons[@"Back"] tap];
    
}

@end
