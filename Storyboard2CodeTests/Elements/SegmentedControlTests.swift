//
//  SegmentedControlTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 10.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SegmentedControlTests: XCTestCase {
  
  var sut: SegmentedControl!
  
  override func setUp() {
    super.setUp()
    
    sut = SegmentedControl(dict: ["id": "42", "userLabel": "fooSegmentedControl"])
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_segmentedControlPropertyString_HasExpectedOutput() {
    
    let result = sut.propertyString()
    
    let expected = "let fooSegmentedControl: UISegmentedControl"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlInitString_HasExpectedOutput() {
    
    let result = sut.initString()
    
    let expected = "fooSegmentedControl = UISegmentedControl()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO",
                "id": "42",
                "userLabel": "fooSegmentedControl"]
    let sut = SegmentedControl(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooSegmentedControl.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func testSegmentedControlSetupString_HasInsertSegmentWithTitleString() {
    sut.segments.append(Segment(dict: ["title": "Foo"]))
    sut.segments.append(Segment(dict: ["title": "Bar"]))
    sut.segments.append(Segment(dict: ["title": "Hello"]))
    sut.segments.append(Segment(dict: ["title": "World", "enabled": "NO"]))
    
    var expectedOutput = "fooSegmentedControl.insertSegment(withTitle:\"Foo\", at: 0, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"Bar\", at: 1, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"Hello\", at: 2, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"World\", at: 3, animated: false)\n"
    expectedOutput += "fooSegmentedControl.setEnabled(false, forSegmentAtIndex: 3)\n"
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_selectedSegmentIndex() {
    let attr = ["selectedSegmentIndex": "1",
                "id": "42",
                "userLabel": "fooSegmentedControl"]
    let sut = SegmentedControl(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooSegmentedControl.selectedSegmentIndex = 1"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_momentary() {
    let attr = ["momentary": "YES",
                "id": "42",
                "userLabel": "fooSegmentedControl"]
    let sut = SegmentedControl(dict: attr)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooSegmentedControl.momentary = true"
    XCTAssertEqual(result.trimmed, expected)
  }
}
