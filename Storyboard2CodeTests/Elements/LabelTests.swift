//  Created by dasdom on 02.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class LabelTests: XCTestCase {
  
  func test_labelPropertyString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.propertyString()
    
    let expectedOutput = "let fooLabel: UILabel"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_labelInitString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.initString()

    let expected = "fooLabel = UILabel()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_textAlignment() {
    let attr = ["textAlignment": "justified", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.textAlignment = .justified"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_lineBreakMode() {
    let attr = ["lineBreakMode": "headTruncation", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.lineBreakMode = .byTruncatingHead"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_numberOfLines() {
    let attr = ["numberOfLines": "0", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.numberOfLines = 0"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_minimumScaleFactor() {
    let attr = ["minimumScaleFactor": "0.5", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.minimumScaleFactor = 0.5"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_enabled() {
    let attr = ["enabled": "NO", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.enabled = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_highlighted() {
    let attr = ["highlighted": "YES", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.highlighted = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_labelSetupString_HasExpectedOutputFor_Text() {
    let attr = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    sut.text = "Foo"
    
    let result = sut.setupString(objC: false)

    let expected = "fooLabel.text = \"Foo\""
    XCTAssertEqual(result.trimmed, expected)
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
    let attr = ["horizontalHuggingPriority": "251",
                "verticalHuggingPriority": "251",
                "opaque": "NO",
                "userInteractionEnabled": "NO",
                "contentMode": "left",
                "id": "42",
                "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = ""
    XCTAssertEqual(result.trimmed, expected)
  }
}

// MARK: - ObjC
extension LabelTests {
  func test_labelSetupString_HasExpectedOutputFor_textAlignment_objC() {
    let attr = ["textAlignment": "justified", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: true)
    
    let expected = "_fooLabel.textAlignment = NSTextAlignmentJustified;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_lineBreakMode_objC() {
    let attr = ["lineBreakMode": "headTruncation", "id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: true)
    
    let expected = "_fooLabel.lineBreakMode = NSLineBreakByTruncatingHead;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_HasExpectedOutputFor_Text_objC() {
    let attr = ["id": "42", "userLabel": "fooLabel"]
    let sut = Label(dict: attr)
    sut.text = "Foo"
    
    let result = sut.setupString(objC: true)
    
    let expected = "_fooLabel.text = @\"Foo\";"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_labelSetupString_hasExpectedOutputFor_horizontalHuggingPriority_objC() {
    let attr = ["id": "42", "userLabel": "fooLabel", "horizontalHuggingPriority": "123"]
    let sut = Label(dict: attr)
    
    let result = sut.setupString(objC: true)
    
    let expected = "[_fooLabel setContentHuggingPriority:123 forOrientation:NSLayoutConstraintOrientationHorizontal];"
    XCTAssertEqual(result.trimmed, expected)
  }
}
