//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ButtonTests: XCTestCase {
  
  func test_buttonPropertyString_HasExpectedOutput() {
    let attr = ["id": "cfU-u7-b0P", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.propertyString()
    
    let expectedOutput = "let fooButton: UIButton"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_buttonInitString_HasExpectedOutput() {
    let attr = ["buttonType": "roundedRect", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.initString()
    
    let expectedOutput = "fooButton = UIButton(type: .system)"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_enabled() {
    let attr = ["enabled": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expectedOutput = "fooButton.isEnabled = false"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_highlighted() {
    let attr = ["highlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooButton.isHighlighted = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_selected() {
    let attr = ["selected": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooButton.isSelected = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_contentHorizontalAlignment() {
    let attr = ["contentHorizontalAlignment": "left", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooButton.contentHorizontalAlignment = .left"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_contentVerticalAlignment() {
    let attr = ["contentVerticalAlignment": "top", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooButton.contentVerticalAlignment = .top"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_reversesTitleShadowWhenHighlighted() {
    let attr = ["reversesTitleShadowWhenHighlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooButton.reversesTitleShadowWhenHighlighted = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_showsTouchWhenHighlighted() {
    let attr = ["showsTouchWhenHighlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooButton.showsTouchWhenHighlighted = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_adjustsImageWhenHighlighted() {
    let attr = ["adjustsImageWhenHighlighted": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooButton.adjustsImageWhenHighlighted = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_adjustsImageWhenDisabled() {
    let attr = ["adjustsImageWhenDisabled": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooButton.adjustsImageWhenDisabled = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_lineBreakMode() {
    let attr = ["lineBreakMode": "clip", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooButton.titleLabel?.lineBreakMode = .byClipping"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooButton.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_textColor() {
    let attr = ["id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)
    let color = Color(dict: ["key": "titleColor", "red": "1", "green": "1", "blue": "0.400", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    var state = ButtonState(dict: ["key": "normal", "title": "Button 1"])
    state.set(titleColor: color)
    (sut as! Button).add(state: state)
    
    let expectedOutput = "fooButton.setTitle(\"Button 1\", for: .normal)\nfooButton.setTitleColor(UIColor(red: 1.000, green: 1.000, blue: 0.400, alpha: 1.000), for: .normal)\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
}

// MARK: - ObjC
extension ButtonTests {
  func test_buttonSetupString_HasExpectedOutputFor_lineBreakMode_objC() {
    let attr = ["lineBreakMode": "clip", "id": "42", "userLabel": "fooButton"]
    let sut = Builder.builder(for: .button).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooButton.titleLabel.lineBreakMode = NSLineBreakByClipping;"
    XCTAssertEqual(result.trimmed, expected)
  }
}
