//
//  TextFieldTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 05.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class TextFieldTests: XCTestCase {
  
  var sut: TextField!
  
  override func setUp() {
    super.setUp()
    
    sut = TextField(dict: ["id": "42", "userLabel": "fooTextField"])
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_textFieldPropertyString_HasExpectedOutput() {
    let expectedOutput = "let fooTextField: UITextField"
    XCTAssertEqual(sut.propertyString(), expectedOutput)
  }
  
  func test_textFieldInitString_HasExpectedOutput() {
    let expectedOutput = "fooTextField = UITextField()\n"
    XCTAssertEqual(sut.initString(), expectedOutput)
  }

  func test_textFieldSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attributesDict = ["clipsSubviews": "YES",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.clipsToBounds = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_borderStyle() {
    let attributesDict = ["borderStyle": "line",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.borderStyle = .line\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_placeholder() {
    let attributesDict = ["placeholder": "foo",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.placeholder = \"foo\"\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_textAlignment() {
    let attributesDict = ["textAlignment": "center",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.textAlignment = .center\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clearsOnBeginEditing() {
    let attributesDict = ["clearsOnBeginEditing": "YES",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.clearsOnBeginEditing = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clearButtonMode() {
    let attributesDict = ["clearButtonMode": "whileEditing",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let localSUT = TextField(dict: attributesDict)
    
    let expectedOutput = "fooTextField.clearButtonMode = .whileEditing\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
//  minimumFontSize="17"
  
  func test_TextFieldSetupString_HasExpectedOutputFor_autocapitalizationType() {
    let attributesDict = ["autocapitalizationType": "allCharacters"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.autocapitalizationType = .allCharacters\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_autocorrectionType() {
    let attributesDict = ["autocorrectionType": "no"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.autocorrectionType = .no\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_spellCheckingType() {
    let attributesDict = ["spellCheckingType": "no"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.spellCheckingType = .no\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_keyboardType() {
    let attributesDict = ["keyboardType": "twitter"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.keyboardType = .twitter\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_keyboardAppearance() {
    let attributesDict = ["keyboardAppearance": "alert"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.keyboardAppearance = .alert\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_returnKeyType() {
    let attributesDict = ["returnKeyType": "send"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.returnKeyType = .send\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_enablesReturnKeyAutomatically() {
    let attributesDict = ["enablesReturnKeyAutomatically": "YES"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.enablesReturnKeyAutomatically = true\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_secureTextEntry() {
    let attributesDict = ["secureTextEntry": "YES"]
    sut.textInputTraits = TextInputTraits(dict: attributesDict)
    
    let expectedOutput = "fooTextField.isSecureTextEntry = true\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func testTextFieldSetupString_HasTextColorString() {
    let color = Color(dict: ["key": "textColor", "red": "1", "green": "0", "blue": "0", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    sut.colors.append(color)
    
    let expectedOutput = "fooTextField.textColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func testTextFieldSetupString_HasFontString() {
    let attributesDict = ["key": "fontDescription", "name": "AvenirNext-Regular", "family": "Avenir Next", "pointSize":"20"]
    let font = Font(dict: attributesDict)
    sut.font = font
    
    let expectedOutput = "fooTextField.font = UIFont(name: \"AvenirNext-Regular\", size: 20)\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
}

extension TextFieldTests {
  func test_textFieldSetupString_HasNoOutputForDefaultValues() {
    let attributesDict = ["opaque": "NO",
                          "contentHorizontalAlignment": "left",
                          "contentVerticalAlignment": "center",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attributesDict)
    
    let expectedOutput = ""
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
}
