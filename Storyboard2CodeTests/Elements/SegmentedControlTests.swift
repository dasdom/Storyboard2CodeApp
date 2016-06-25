//
//  SegmentedControlTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 10.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SegmentedControlTests: XCTestCase {
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "SegmentedControlTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
//    print(codeString)
  }
  
  func test_SegmentedControlReturnsCorrectInitString() {
    let expectedString = "fooSegmentedControl = UISegmentedControl()\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooSegmentedControl.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasInsertSegmentWithTitleFooString() {
    let expectedString = "fooSegmentedControl.insertSegmentWithTitle(\"Foo\", atIndex: 0, animated: false)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasInsertSegmentWithTitleBarString() {
    let expectedString = "fooSegmentedControl.insertSegmentWithTitle(\"Bar\", atIndex: 1, animated: false)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasInsertSegmentWithTitleHelloString() {
    let expectedString = "fooSegmentedControl.insertSegmentWithTitle(\"Hello\", atIndex: 2, animated: false)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasSetEnabledString() {
    let expectedString = "fooSegmentedControl.setEnabled(false, forSegmentAtIndex: 3)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasSelectedSegmentIndexString() {
    let expectedString = "fooSegmentedControl.selectedSegmentIndex = 1"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testSegmentedControlSetupString_HasMomentaryString() {
    let expectedString = "fooSegmentedControl.momentary = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
}

extension SegmentedControlTests {
  func testDefaultSegmentedControlSetupString_HasSetEnabled() {
    let expectedString = "defaultSegmentedControl.setEnabled"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}
