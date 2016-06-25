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
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    
    guard let data = dataFromResource(withName: "ButtonTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
//    print(codeString)
  }
  
  func test_ButtonReturnsCorrectInitString() {
    let expectedString = "button = UIButton(type: .System)\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "button.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasContentHorizontalAlignmentString() {
    let expectedString = "button.contentHorizontalAlignment = .Left"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasContentVerticalAlignmentString() {
    let expectedString = "button.contentVerticalAlignment = .Top"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasLineBreakModeString() {
    let expectedString = "button.titleLabel?.lineBreakMode = .ByClipping"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasEnabledString() {
    let expectedString = "button.enabled = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasHighlightedString() {
    let expectedString = "button.highlighted = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasSelectedString() {
    let expectedString = "button.selected = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasReversesTitleShadowWhenHighlightedString() {
    let expectedString = "button.reversesTitleShadowWhenHighlighted = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasShowsTouchWhenHighlightedString() {
    let expectedString = "button.showsTouchWhenHighlighted = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }

  func testButtonSetupString_HasAdjustsImageWhenHighlightedString() {
    let expectedString = "button.adjustsImageWhenHighlighted = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasAdjustsImageWhenDisabledString() {
    let expectedString = "button.adjustsImageWhenDisabled = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testButtonSetupString_HasTitleColorString() {
    let expectedString = "button.setTitleColor(UIColor(red: 1.000, green: 1.000, blue: 0.400, alpha: 1.000), forState: .Normal)"
    print(codeString)
    XCTAssertTrue(codeString.contains(expectedString))
  }
}


//MARK: - Default Button
extension ButtonTests {
  func testDefaultButtonSetupString_HasNotUserInteractionEnabledString() {
    let expectedString = "button.userInteractionEnabled"
    XCTAssertFalse(codeString.contains(expectedString))
  }
 
  func testDefaultButtonSetupString_HasNotEnabledString() {
    let expectedString = "defaultButton.enabled"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotHighlightedString() {
    let expectedString = "defaultButton.highlighted"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotSelectedString() {
    let expectedString = "defaultButton.selected"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotReversesTitleShadowWhenHighlightedString() {
    let expectedString = "defaultButton.reversesTitleShadowWhenHighlighted"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotShowsTouchWhenHighlightedString() {
    let expectedString = "defaultButton.showsTouchWhenHighlighted"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotAdjustsImageWhenHighlightedString() {
    let expectedString = "defaultButton.adjustsImageWhenHighlighted"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultButtonSetupString_HasNotAdjustsImageWhenDisabledString() {
    let expectedString = "defaultButton.adjustsImageWhenDisabled"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}
