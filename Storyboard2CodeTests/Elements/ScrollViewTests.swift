//  Created by dasdom on 18.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ScrollViewTests: XCTestCase {
  
  func test_segmentedControlPropertyString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.propertyString()
    
    let expected = "let fooScrollView: UIScrollView"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlInitString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)
    
    let result = sut.initString()
    
    let expected = "fooScrollView = UIScrollView()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_directionalLockEnabled() {
    let attr = ["directionalLockEnabled": "YES",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.directionalLockEnabled = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_bounces() {
    let attr = ["bounces": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.bounces = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_alwaysBounceVertical() {
    let attr = ["alwaysBounceVertical": "YES",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.alwaysBounceVertical = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_scrollEnabled() {
    let attr = ["scrollEnabled": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.scrollEnabled = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_pagingEnabled() {
    let attr = ["pagingEnabled": "YES",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.pagingEnabled = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_showsHorizontalScrollIndicator() {
    let attr = ["showsHorizontalScrollIndicator": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.showsHorizontalScrollIndicator = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_showsVerticalScrollIndicator() {
    let attr = ["showsVerticalScrollIndicator": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.showsVerticalScrollIndicator = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_indicatorStyle() {
    let attr = ["indicatorStyle": "black",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.indicatorStyle = .black"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_delaysContentTouches() {
    let attr = ["delaysContentTouches": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.delaysContentTouches = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_canCancelContentTouches() {
    let attr = ["canCancelContentTouches": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.canCancelContentTouches = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_minimumZoomScale() {
    let attr = ["minimumZoomScale": "5",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.minimumZoomScale = 5"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_maximumZoomScale() {
    let attr = ["maximumZoomScale": "3",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.maximumZoomScale = 3"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_bouncesZoom() {
    let attr = ["bouncesZoom": "NO",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.bouncesZoom = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_keyboardDismissMode() {
    let attr = ["keyboardDismissMode": "onDrag",
                "id": "42",
                "userLabel": "fooScrollView"]
    let sut = Builder.builder(for: .scrollView).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooScrollView.keyboardDismissMode = .onDrag"
    XCTAssertEqual(result.trimmed, expected)
  }
}
