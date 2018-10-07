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
  
  var sut: ScrollView!
  
  override func setUp() {
    super.setUp()
    
    sut = ScrollView(dict: ["id": "42", "userLabel": "fooScrollView"])
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_segmentedControlPropertyString_HasExpectedOutput() {
    let expectedOutput = "let fooScrollView: UIScrollView"
    XCTAssertEqual(sut.propertyString(), expectedOutput)
  }
  
  func test_segmentedControlInitString_HasExpectedOutput() {
    let expectedOutput = "fooScrollView = UIScrollView()\n"
    XCTAssertEqual(sut.initString(), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_directionalLockEnabled() {
    let attributesDict = ["directionalLockEnabled": "YES",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.directionalLockEnabled = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_bounces() {
    let attributesDict = ["bounces": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.bounces = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_alwaysBounceVertical() {
    let attributesDict = ["alwaysBounceVertical": "YES",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.alwaysBounceVertical = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_scrollEnabled() {
    let attributesDict = ["scrollEnabled": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.scrollEnabled = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_pagingEnabled() {
    let attributesDict = ["pagingEnabled": "YES",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.pagingEnabled = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_showsHorizontalScrollIndicator() {
    let attributesDict = ["showsHorizontalScrollIndicator": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.showsHorizontalScrollIndicator = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_showsVerticalScrollIndicator() {
    let attributesDict = ["showsVerticalScrollIndicator": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.showsVerticalScrollIndicator = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_indicatorStyle() {
    let attributesDict = ["indicatorStyle": "black",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.indicatorStyle = .black\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_delaysContentTouches() {
    let attributesDict = ["delaysContentTouches": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.delaysContentTouches = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_canCancelContentTouches() {
    let attributesDict = ["canCancelContentTouches": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.canCancelContentTouches = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_minimumZoomScale() {
    let attributesDict = ["minimumZoomScale": "5",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.minimumZoomScale = 5\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_maximumZoomScale() {
    let attributesDict = ["maximumZoomScale": "3",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.maximumZoomScale = 3\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_bouncesZoom() {
    let attributesDict = ["bouncesZoom": "NO",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.bouncesZoom = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_scrollViewSetupString_HasExpectedOutputFor_keyboardDismissMode() {
    let attributesDict = ["keyboardDismissMode": "onDrag",
                          "id": "42",
                          "userLabel": "fooScrollView"]
    let localSUT = ScrollView(dict: attributesDict)
    
    let expectedOutput = "fooScrollView.keyboardDismissMode = .onDrag\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
}
