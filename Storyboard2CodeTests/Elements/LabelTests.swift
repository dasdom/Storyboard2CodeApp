//
//  LabelTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 02.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class LabelTests: XCTestCase {
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "LabelTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
    print(codeString)
  }
  
  func test_LabelReturnsCorrectInitString() {
    let expectedString = "fooLabel = UILabel()\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooLabel.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasLineBreakModeString() {
    let expectedString = "fooLabel.lineBreakMode = .byTruncatingHead"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasTextAlignmentString() {
    let expectedString = "fooLabel.textAlignment = .justified"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasNumberOfLinesString() {
    let expectedString = "fooLabel.numberOfLines = 0"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasMinimumScaleFactorString() {
    let expectedString = "fooLabel.minimumScaleFactor = 0.5"
    XCTAssertTrue(codeString.contains(expectedString))
  }

//  // Check if this is needed when minimumScaleFactor is set
//  func testLabelSetupString_HasAdjustsFontSizeToFitWidthString() {
//    assert(false, "Check if this is needed when minimumScaleFactor is set")
//    let expectedString = "fooLabel.adjustsFontSizeToFitWidth = true"
//    XCTAssertTrue(codeString.containsString(expectedString))
//  }
  
  func testLabelSetupString_HasEnabledString() {
    let expectedString = "fooLabel.enabled = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasHighlightedString() {
    let expectedString = "fooLabel.highlighted = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasTextString() {
    let expectedString = "fooLabel.text = \"foo\\nLabel\""
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testLabelSetupString_HasNotOpaqueString() {
    let expectedString = "fooLabel.opaque"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}

//MARK: - Default Label
extension LabelTests {
  func testDefaultLabelSetupString_HasNotUserInteractionEnabledString() {
    let expectedString = "defaultLabel.userInteractionEnabled"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultLabelSetupString_HasNotTextAlignmentString() {
    let expectedString = "defaultLabel.textAlignment"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultLabelSetupString_HasNotLineBreakModeString() {
    let expectedString = "defaultLabel.lineBreakMode"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultLabelSetupString_HasNotBaselineAdjustmentString() {
    let expectedString = "defaultLabel.baselineAdjustment"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultLabelSetupString_HasNotAdjustsFontSizeToFitWidthString() {
    let expectedString = "defaultLabel.adjustsFontSizeToFitWidth"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultLabelSetupString_HasNotOpaqueString() {
    let expectedString = "defaultLabel.opaque"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}
