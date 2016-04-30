//
//  ButtonTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ButtonTests: XCTestCase {
  
  var sut: Button!
  
  override func setUp() {
    super.setUp()
    
    guard let data = dataFromResource(withName: "ButtonTest", andType: "xml") else { fatalError() }
    guard let dict = StoryboardXMLHelper().attributedDictionary(fromData: data, forElement: "button") else { fatalError() }
    print(dict)
    sut = Button(dict: dict)
  }
  
  func test_ButtonReturnsCorrectInitString() {    
    XCTAssertEqual(sut.initString, "button = UIButton(type: .System)\n")
  }
  
  func testSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "button.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasContentHorizontalAlignmentString() {
    let expectedString = "button.contentHorizontalAlignment = .Left"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasContentVerticalAlignmentString() {
    let expectedString = "button.contentVerticalAlignment = .Top"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasLineBreakModeString() {
    let expectedString = "button.titleLabel?.lineBreakMode = .ByClipping"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasEnabledString() {
    let expectedString = "button.enabled = false"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasHighlightedString() {
    let expectedString = "button.highlighted = true"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasSelectedString() {
    let expectedString = "button.selected = true"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasReversesTitleShadowWhenHighlightedString() {
    let expectedString = "button.reversesTitleShadowWhenHighlighted = true"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasShowsTouchWhenHighlightedString() {
    let expectedString = "button.showsTouchWhenHighlighted = true"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }

  func testSetupString_HasAdjustsImageWhenHighlightedString() {
    let expectedString = "button.adjustsImageWhenHighlighted = false"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
  
  func testSetupString_HasAdjustsImageWhenDisabledString() {
    let expectedString = "button.adjustsImageWhenDisabled = false"
    XCTAssertTrue(sut.setupString.containsString(expectedString))
  }
}
