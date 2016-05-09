//
//  SliderTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 08.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SliderTests: XCTestCase {
  
  var codeString: String!
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "SliderTests", andType: "xml") else { fatalError() }
    codeString = codeCreator.codeStringFrom(XMLdata: data)
    print(codeString)
  }
  
  func test_SliderdReturnsCorrectInitString() {
    let expectedString = "fooSlider = UISlider()\n"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooSlider.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }

  func testSliderSetupString_HasValueString() {
    let expectedString = "fooSlider.value = 5"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasMinimumValueString() {
    let expectedString = "fooSlider.minimumValue = -7"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasMaximumValueString() {
    let expectedString = "fooSlider.maximumValue = 33"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasContinuousString() {
    let expectedString = "fooSlider.continuous = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasMinimumTrackTintColorString() {
    let expectedString = "fooSlider.minimumTrackTintColor = UIColor(red: 0.000, green: 0.502, blue: 0.000, alpha: 1.000)"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasMaximumTrackTintColorString() {
    let expectedString = "fooSlider.maximumTrackTintColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSliderSetupString_HasThumbTintColorString() {
    let expectedString = "fooSlider.thumbTintColor = UIColor(red: 0.000, green: 0.251, blue: 0.502, alpha: 1.000)"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
}

extension SliderTests {
  func testDefaultSliderSetupString_HasNotContinuousString() {
    XCTAssert(codeString.containsString("defaultSlider"))
    let expectedString = "defaultSlider.continuous"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
  
  func testDefaultSliderSetupString_HasNotMinimumTrackTintColorString() {
    XCTAssert(codeString.containsString("defaultSlider"))
    let expectedString = "defaultSlider.minimumTrackTintColor"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
  
  func testDefaultSliderSetupString_HasNotMaximumTrackTintColorString() {
    XCTAssert(codeString.containsString("defaultSlider"))
    let expectedString = "defaultSlider.maximumTrackTintColor"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
  
  func testDefaultSliderSetupString_HasNotThumbTintColorString() {
    XCTAssert(codeString.containsString("defaultSlider"))
    let expectedString = "defaultSlider.thumbTintColor"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
}
