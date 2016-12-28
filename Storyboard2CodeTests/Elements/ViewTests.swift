//  Created by dasdom on 01.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ViewTests: XCTestCase {

  func test_viewPropertyString_HasExpectedOutput() {
    let attributesDict = ["id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "let fooView: UIView"
    XCTAssertEqual(sut.propertyString, expectedOutput)
  }
  
  func test_viewInitString_HasExpectedOutput() {
    let attributesDict = ["id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView = UIView()\n"
    XCTAssertEqual(sut.initString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_autoresizesSubviews() {
    let attributesDict = ["autoresizesSubviews": "NO", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.autoresizesSubviews = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_opaque() {
    let attributesDict = ["opaque": "NO", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.isOpaque = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attributesDict = ["clipsSubviews": "YES", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.clipsToBounds = true\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clearsContextBeforeDrawing() {
    let attributesDict = ["clearsContextBeforeDrawing": "NO", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.clearsContextBeforeDrawing = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_userInteractionEnabled() {
    let attributesDict = ["userInteractionEnabled": "NO", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.userInteractionEnabled = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_tag() {
    let attributesDict = ["tag": "22", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.tag = 22\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_contentMode() {
    let attributesDict = ["contentMode": "redraw", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.contentMode = .redraw\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "fooView.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(sut.setupString, expectedOutput)
  }
  
  func test_viewAddToSuperString_HasExpectedOutput() {
    let attributesDict = ["id": "42", "userLabel": "fooView"]
    let sut = View(dict: attributesDict)
    
    let expectedOutput = "addSubview(fooView)"
    XCTAssertEqual(sut.addToSuperString, expectedOutput)
  }
}
