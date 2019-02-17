//  Created by dasdom on 01.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ViewTests: XCTestCase {

  func test_viewPropertyString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)
    
    let result = sut.propertyString()

    let expected = "let fooView: UIView"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewInitString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)
    
    let result = sut.initString()

    let expected = "fooView = UIView()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_autoresizesSubviews() {
    let attr = ["autoresizesSubviews": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooView.autoresizesSubviews = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_opaque() {
    let attr = ["opaque": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.isOpaque = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attr = ["clipsSubviews": "YES", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.clipsToBounds = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clearsContextBeforeDrawing() {
    let attr = ["clearsContextBeforeDrawing": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.clearsContextBeforeDrawing = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_userInteractionEnabled() {
    let attr = ["userInteractionEnabled": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.userInteractionEnabled = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_tag() {
    let attr = ["tag": "22", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.tag = 22"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_contentMode() {
    let attr = ["contentMode": "redraw", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.contentMode = .redraw"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooView.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_reflectableString_withEmptyTarget() {
    let attr = ["id": "42", "userLabel": "fooView", "userInteractionEnabled": "NO"]
    let sut = Builder.builder(for: .view).build(attributes: attr)
    sut.isMainView = true
    
    let result = sut.setupString()
    
    let expected = "userInteractionEnabled = false"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_viewAddToSuperString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.addToSuperString()
    
    let expected = "addSubview(fooView)"
    XCTAssertEqual(result.trimmed, expected)
  }
}

// MARK: - ObjC
extension ViewTests {
  func test_viewPropertyString_HasExpectedOutput_OjbC() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.propertyString(objC: true)

    let expected = "@property (nonatomic) UIView *fooView;"
    XCTAssertEqual(result, expected)
  }
  
  func test_viewInitString_HasExpectedOutput_OjbC() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.initString(objC: true)

    let expected = "_fooView = [[UIView alloc] init];"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_autoresizesSubviews_OjbC() {
    let attr = ["autoresizesSubviews": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.autoresizesSubviews = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_opaque_OjbC() {
    let attr = ["opaque": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.opaque = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clipsSubviews_OjbC() {
    let attr = ["clipsSubviews": "YES", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.clipsToBounds = YES;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_clearsContextBeforeDrawing_OjbC() {
    let attr = ["clearsContextBeforeDrawing": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.clearsContextBeforeDrawing = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_userInteractionEnabled_OjbC() {
    let attr = ["userInteractionEnabled": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.userInteractionEnabled = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_tag_OjbC() {
    let attr = ["tag": "22", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.tag = 22;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_contentMode_objC() {
    let attr = ["contentMode": "redraw", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.contentMode = UIViewContentModeRedraw;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_viewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints_objC() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooView.translatesAutoresizingMaskIntoConstraints = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_reflectableString_withEmptyTarget_objC() {
    let attr = ["id": "42", "userLabel": "fooView", "userInteractionEnabled": "NO"]
    let sut = Builder.builder(for: .view).build(attributes: attr)
    sut.isMainView = true
    
    let result = sut.setupString(objC: true)
    
    let expected = "self.userInteractionEnabled = NO;"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_viewAddToSuperString_HasExpectedOutput_objC() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let sut = Builder.builder(for: .view).build(attributes: attr)

    let result = sut.addToSuperString(objC: true)
    
    let expected = "[self addSubview:_fooView];"
    XCTAssertEqual(result.trimmed, expected)
  }
}
