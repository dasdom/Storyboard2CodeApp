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
    
    let result = sut.propertyString()
    
    let expected = "let fooTextField: UITextField"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldInitString_HasExpectedOutput() {
    
    let result = sut.initString()

    let expected = "fooTextField = UITextField()"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_textFieldSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attr = ["clipsSubviews": "YES",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.clipsToBounds = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_borderStyle() {
    let attr = ["borderStyle": "line",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.borderStyle = .line"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_placeholder() {
    let attr = ["placeholder": "foo",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.placeholder = \"foo\""
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_textAlignment() {
    let attr = ["textAlignment": "center",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.textAlignment = .center"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clearsOnBeginEditing() {
    let attr = ["clearsOnBeginEditing": "YES",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.clearsOnBeginEditing = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_textFieldSetupString_HasExpectedOutputFor_clearButtonMode() {
    let attr = ["clearButtonMode": "whileEditing",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.clearButtonMode = .whileEditing"
    XCTAssertEqual(result.trimmed, expected)
  }
  
//  minimumFontSize="17"
  
  func test_TextFieldSetupString_HasExpectedOutputFor_autocapitalizationType() {
    let attr = ["autocapitalizationType": "allCharacters"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.autocapitalizationType = .allCharacters"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_autocorrectionType() {
    let attr = ["autocorrectionType": "no"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.autocorrectionType = .no"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_spellCheckingType() {
    let attr = ["spellCheckingType": "no"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.spellCheckingType = .no"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_keyboardType() {
    let attr = ["keyboardType": "twitter"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.keyboardType = .twitter"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_keyboardAppearance() {
    let attr = ["keyboardAppearance": "alert"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.keyboardAppearance = .alert"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_returnKeyType() {
    let attr = ["returnKeyType": "send"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.returnKeyType = .send"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_enablesReturnKeyAutomatically() {
    let attr = ["enablesReturnKeyAutomatically": "YES"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.enablesReturnKeyAutomatically = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_TextFieldSetupString_HasExpectedOutputFor_secureTextEntry() {
    let attr = ["secureTextEntry": "YES"]
    sut.textInputTraits = TextInputTraits(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.isSecureTextEntry = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func testTextFieldSetupString_HasTextColorString() {
    let color = Color(dict: ["key": "textColor", "red": "1", "green": "0", "blue": "0", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    sut.colors.append(color)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.textColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func testTextFieldSetupString_HasFontString() {
    let attr = ["key": "fontDescription", "name": "AvenirNext-Regular", "family": "Avenir Next", "pointSize":"20"]
    let font = Font(dict: attr)
    sut.font = font
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooTextField.font = UIFont(name: \"AvenirNext-Regular\", size: 20)"
    XCTAssertEqual(result.trimmed, expected)
  }
}

extension TextFieldTests {
  func test_textFieldSetupString_HasNoOutputForDefaultValues() {
    let attr = ["opaque": "NO",
                          "contentHorizontalAlignment": "left",
                          "contentVerticalAlignment": "center",
                          "id": "42",
                          "userLabel": "fooTextField"]
    let sut = TextField(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = ""
    XCTAssertEqual(result.trimmed, expected)
  }
}
