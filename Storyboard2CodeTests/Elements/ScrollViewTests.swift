//
//  ScrollViewTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 18.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ScrollViewTests: XCTestCase {
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "ScrollViewTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
    print(codeString)
  }
  
  func test_ScrollViewReturnsCorrectInitString() {
    let expectedString = "fooScrollView = UIScrollView()\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasTranslatesAutoresizingString() {
    let expectedString = "fooScrollView.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasDirectionalLockEnabledString() {
    let expectedString = "fooScrollView.directionalLockEnabled = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasBouncesString() {
    let expectedString = "fooScrollView.bounces = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasAlwaysBounceVerticalString() {
    let expectedString = "fooScrollView.alwaysBounceVertical = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasScrollEnabledString() {
    let expectedString = "fooScrollView.scrollEnabled = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasPagingEnabledString() {
    let expectedString = "fooScrollView.pagingEnabled = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasShowsHorizontalScrollIndicatorString() {
    let expectedString = "fooScrollView.showsHorizontalScrollIndicator = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasShowsVerticalScrollIndicatorString() {
    let expectedString = "fooScrollView.showsVerticalScrollIndicator = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasIndicatorStyleString() {
    let expectedString = "fooScrollView.indicatorStyle = .Black"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasDelaysContentTouchesString() {
    let expectedString = "fooScrollView.delaysContentTouches = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasCanCancelContentTouchesString() {
    let expectedString = "fooScrollView.canCancelContentTouches = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasMinimumZoomScaleString() {
    let expectedString = "fooScrollView.minimumZoomScale = 5"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasMaximumZoomScaleString() {
    let expectedString = "fooScrollView.maximumZoomScale = 3"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasBouncesZoomString() {
    let expectedString = "fooScrollView.bouncesZoom = false"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func testScrollViewSetupString_HasKeyboardDismissModeString() {
    let expectedString = "fooScrollView.keyboardDismissMode = .OnDrag"
    XCTAssertTrue(codeString.contains(expectedString))
  }
}
