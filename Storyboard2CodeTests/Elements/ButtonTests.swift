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
    
    guard let data = dataFromResource(withName: "dummy", andType: "xml") else { fatalError() }
    guard let dict = StoryboardXMLHelper().attributedDictionary(fromData: data, forElement: "button") else { fatalError() }
    print(dict)
    sut = Button(dict: dict)
  }
  
  func test_ButtonReturnsCorrectInitString() {
    var expectedInitString = "tapMeButton = UIButton(type: .System)\n"
    expectedInitString += "tapMeButton.translatesAutoresizingMaskIntoConstraints = false\n"
    
    XCTAssertEqual(sut.initString, expectedInitString)
  }
}
