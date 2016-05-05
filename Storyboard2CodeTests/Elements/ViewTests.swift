//
//  ViewTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 01.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ViewTests: XCTestCase {
  
  var codeString: String!
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "ViewTests", andType: "xml") else { fatalError() }
    codeString = codeCreator.codeStringFrom(XMLdata: data)
//    print(codeString)
  }
  
  func test_ViewReturnsCorrectInitString() {
    let expectedString = "fooView = UIView()\n"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
 
  func testViewSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooView.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasAutoresizesSubviewsString() {
    let expectedString = "fooView.autoresizesSubviews = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasOpaqueString() {
    let expectedString = "fooView.opaque = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasClipsToBoundsString() {
    let expectedString = "fooView.clipsToBounds = true"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasClearsContextBeforeDrawingString() {
    let expectedString = "fooView.clearsContextBeforeDrawing = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasUserInteractionEnabledString() {
    let expectedString = "fooView.userInteractionEnabled = false"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasTagString() {
    let expectedString = "fooView.tag = 22"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
  
  func testViewSetupString_HasContentModeString() {
    let expectedString = "fooView.contentMode = .Redraw"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
}

//MARK: - Default View
extension ViewTests {
  func testDefaultViewSetupString_HasNotContentModeString() {
    let expectedString = "defaultView.contentMode"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
  
  func testDefaultViewSetupString_HasNotClipsToBoundsString() {
    let expectedString = "defaultView.clipsToBounds"
    XCTAssertFalse(codeString.containsString(expectedString))
  }
}
