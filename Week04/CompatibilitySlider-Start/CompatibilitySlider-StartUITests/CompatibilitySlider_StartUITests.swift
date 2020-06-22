//
//  CompatibilitySlider_StartUITests.swift
//  CompatibilitySlider-StartUITests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest

var app: XCUIApplication!

class CompatibilitySlider_StartUITests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
    // UI tests must launch the application that they test.
    app = XCUIApplication()
    app.launch()

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    let app = XCUIApplication()
    app.sliders["50%"].swipeRight()
    app/*@START_MENU_TOKEN@*/.staticTexts["Next Item"]/*[[".buttons[\"Next Item\"].staticTexts[\"Next Item\"]",".staticTexts[\"Next Item\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    // given
    let slider = app.segmentedControls.sliders["50%"]
    let nextItemButton = app.segmentedControls.buttons["Next Item"]

    // then
    if slider.isSelected {
      XCTAssertTrue(slider.exists)
      XCTAssertFalse(nextItemButton.exists)

      nextItemButton.tap()
      XCTAssertTrue(nextItemButton.exists)
      XCTAssertFalse(slider.exists)
    } else if nextItemButton.isSelected {
      XCTAssertTrue(nextItemButton.exists)
      XCTAssertFalse(slider.exists)

      slider.tap()
      XCTAssertTrue(slider.exists)
      XCTAssertFalse(nextItemButton.exists)
    }

  }

  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
