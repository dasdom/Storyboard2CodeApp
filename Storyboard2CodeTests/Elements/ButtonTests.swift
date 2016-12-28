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
  
  func test_buttonPropertyString_HasExpectedOutput() {
    let attributesDict = ["id": "cfU-u7-b0P", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "let fooButton: UIButton"
    XCTAssertEqual(sut.propertyString, expectedOutput)
  }
  
  func test_buttonInitString_HasExpectedOutput() {
    let attributesDict = ["buttonType": "roundedRect", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton = UIButton(type: .system)\n"
    XCTAssertEqual(sut.initString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_enabled() {
    let attributesDict = ["enabled": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.enabled = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_highlighted() {
    let attributesDict = ["highlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.highlighted = true\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_selected() {
    let attributesDict = ["selected": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.selected = true\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_contentHorizontalAlignment() {
    let attributesDict = ["contentHorizontalAlignment": "left", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.contentHorizontalAlignment = .left\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_contentVerticalAlignment() {
    let attributesDict = ["contentVerticalAlignment": "top", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.contentVerticalAlignment = .top\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_reversesTitleShadowWhenHighlighted() {
    let attributesDict = ["reversesTitleShadowWhenHighlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.reversesTitleShadowWhenHighlighted = true\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_showsTouchWhenHighlighted() {
    let attributesDict = ["showsTouchWhenHighlighted": "YES", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.showsTouchWhenHighlighted = true\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_adjustsImageWhenHighlighted() {
    let attributesDict = ["adjustsImageWhenHighlighted": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.adjustsImageWhenHighlighted = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_adjustsImageWhenDisabled() {
    let attributesDict = ["adjustsImageWhenDisabled": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.adjustsImageWhenDisabled = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_lineBreakMode() {
    let attributesDict = ["lineBreakMode": "clip", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.titleLabel?.lineBreakMode = .byClipping\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    
    let expectedOutput = "fooButton.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_buttonSetupString_HasExpectedOutputFor_textColor() {
    let attributesDict = ["id": "42", "userLabel": "fooButton"]
    let sut = Button(dict: attributesDict)
    let color = Color(dict: ["key": "titleColor", "red": "1", "green": "1", "blue": "0.400", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    var state = ButtonState(dict: ["key": "normal", "title": "Button 1"])
    state.titleColor = color
    sut.states.append(state)
    
    let expectedOutput = "fooButton.setTitle(\"Button 1\", for: .normal)\nfooButton.setTitleColor(UIColor(colorLiteralRed: 1.000, green: 1.000, blue: 0.400, alpha: 1.000), for: .normal)\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
}
