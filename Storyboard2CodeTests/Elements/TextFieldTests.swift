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
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "TextFieldTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
  //    print(codeString)
  }
  
  func test_TextFieldReturnsCorrectInitString() {
    let expectedString = "fooTextField = UITextField()\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooTextField.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasBorderStyleString() {
    let expectedString = "fooTextField.borderStyle = .line"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasPlaceholderString() {
    let expectedString = "fooTextField.placeholder = \"foo\""
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasTextAlignmentString() {
    let expectedString = "fooTextField.textAlignment = .center"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasClearsOnBeginEditingString() {
    let expectedString = "fooTextField.clearsOnBeginEditing = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasClearButtonModeString() {
    let expectedString = "fooTextField.clearButtonMode = .whileEditing"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasTextColorString() {
    let expectedString = "fooTextField.textColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasFontString() {
    let expectedString = "fooTextField.font = UIFont(name: \"AvenirNext-Regular\", size: 20)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasAutocapitalizationTypeString() {
    let expectedString = "fooTextField.autocapitalizationType = .allCharacters"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasAutocorrectionTypeString() {
    let expectedString = "fooTextField.autocorrectionType = .no"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasSpellCheckingTypeString() {
    let expectedString = "fooTextField.spellCheckingType = .no"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasKeyboardTypeString() {
    let expectedString = "fooTextField.keyboardType = .twitter"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasKeyboardAppearanceString() {
    let expectedString = "fooTextField.keyboardAppearance = .dark"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasReturnKeyTypeString() {
    let expectedString = "fooTextField.returnKeyType = .send"
    XCTAssertTrue(codeString.contains(expectedString))
  }

  func testTextFieldSetupString_HasEnablesReturnKeyAutomaticallyString() {
    let expectedString = "fooTextField.enablesReturnKeyAutomatically = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasSecureTextEntryString() {
    let expectedString = "fooTextField.secureTextEntry = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testTextFieldSetupString_HasNotOpaqueString() {
    let expectedString = "fooTextField.opaque"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}

//MARK: Default text field
extension TextFieldTests {
  func testDefaultTextFieldSetupString_HasNotClipsToBoundsString() {
    let expectedString = "defaultTextField.clipsToBounds"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultTextFieldSetupString_HasNotContentModeString() {
    let expectedString = "defaultTextField.contentMode"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultTextFieldSetupString_HasNotContentHorizontalAlignmentString() {
    let expectedString = "defaultTextField.contentHorizontalAlignment"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultTextFieldSetupString_HasNotContentVerticalAlignmentString() {
    let expectedString = "defaultTextField.contentVerticalAlignment"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultTextFieldSetupString_HasNotTextAlignmentString() {
    let expectedString = "defaultTextField.textAlignment"
    XCTAssertFalse(codeString.contains(expectedString))
  }
  
  func testDefaultTextFieldSetupString_HasNotOpaqueString() {
    let expectedString = "defaultTextField.opaque"
    XCTAssertFalse(codeString.contains(expectedString))
  }
}
