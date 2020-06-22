//
//  CompatibilitySlider_StartTests.swift
//  CompatibilitySlider-StartTests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest
@testable import CompatibilitySlider_Start

class CompatibilitySlider_StartTests: XCTestCase {

  var sut = CompatibilitySlider_Start.ViewController.init()

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    super.setUp()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testNextItem() throws {
    // 1. given
    _ = sut.currentItemIndex

    // 2. when
    sut.didPressNextItemButton((Any).self)

    // 3. then
    XCTAssertEqual(sut.currentItemIndex, 1, "Next item was not picked")
  }

  func testCalculateFullCompatibility() throws {
    // 1. given
    sut.person1 = Person(id: 1, items: ["Cat": 2.5, "Dog": 2.5])
    sut.person2 = Person(id: 2, items: ["Cat": 2.5, "Dog": 2.5])

    // 2. when
    let score = sut.calculateCompatibility()

    // 3. then
    XCTAssertEqual(score, "100.0%", "Incorrect score or string syntax")
  }

  func testCalculateNoCompatibility() throws {
    // 1. given
    sut.person1 = Person(id: 1, items: ["Cat": 0, "Dog": 5])
    sut.person2 = Person(id: 2, items: ["Cat": 5, "Dog": 0])

    // 2. when
    let score = sut.calculateCompatibility()

    // 3. then
    XCTAssertEqual(score, "0.0%", "Incorrect score or string syntax")
  }

}
