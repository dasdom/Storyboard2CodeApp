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
  
  var codeString: String!
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "LabelTest", andType: "xml") else { fatalError() }
    codeString = codeCreator.codeStringFrom(XMLdata: data)
    print(codeString)
  }
  
  func test_LabelReturnsCorrectInitString() {
    let expectedString = "fooLabel = UILabel()\n"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testLabelSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooLabel.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
}
