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
}
