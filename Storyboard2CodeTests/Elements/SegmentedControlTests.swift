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
  
  var codeString: String!
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "SegmentedControlTests", andType: "xml") else { fatalError() }
    codeString = codeCreator.codeStringFrom(XMLdata: data)
    print(codeString)
  }
  
  func test_SegmentedControlReturnsCorrectInitString() {
    let expectedString = "fooSegmentedControl = UISegmentedControl()\n"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testSegmentedControlSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooSegmentedControl.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
}
