//  Created by dasdom on 02.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class LabelTests: XCTestCase {
  
  func test_labelPropertyString_HasExpectedOutput() {
    let attributesDict = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let result = sut.propertyString()
    
    let expectedOutput = "let fooLabel: UILabel"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_labelInitString_HasExpectedOutput() {
    let attributesDict = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel = UILabel()\n"
    XCTAssertEqual(sut.initString(), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_textAlignment() {
    let attributesDict = ["textAlignment": "justified", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.textAlignment = .justified\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_lineBreakMode() {
    let attributesDict = ["lineBreakMode": "headTruncation", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.lineBreakMode = .byTruncatingHead\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_numberOfLines() {
    let attributesDict = ["numberOfLines": "0", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.numberOfLines = 0\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_minimumScaleFactor() {
    let attributesDict = ["minimumScaleFactor": "0.5", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.minimumScaleFactor = 0.5\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_enabled() {
    let attributesDict = ["enabled": "NO", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.enabled = false\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_highlighted() {
    let attributesDict = ["highlighted": "YES", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.highlighted = true\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = "fooLabel.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }

  func test_labelSetupString_HasExpectedOutputFor_Text() {
    let attributesDict = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    sut.text = "Foo"
    
    let expectedOutput = "fooLabel.text = \"Foo\"\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
//  // Check if this is needed when minimumScaleFactor is set
//  func testLabelSetupString_HasAdjustsFontSizeToFitWidthString() {
//    assert(false, "Check if this is needed when minimumScaleFactor is set")
//    let expectedString = "fooLabel.adjustsFontSizeToFitWidth = true"
//    XCTAssertTrue(codeString.containsString(expectedString))
//  }
  
  // Ignored because not in the currect documentation:
  // - adjustsLetterSpacingToFitWidth="YES"
}

extension LabelTests {
  func test_labelSetupString_HasNoOutputForDefaultValues() {
    let attributesDict = ["horizontalHuggingPriority": "251",
                          "verticalHuggingPriority": "251",
                          "opaque": "NO",
                          "userInteractionEnabled": "NO",
                          "contentMode": "left",
                          "id": "42",
                          "userLabel": "fooLabel"]
    let sut = Label(dict: attributesDict)
    
    let expectedOutput = ""
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
}
