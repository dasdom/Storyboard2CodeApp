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
  
  func test_segmentedControlPropertyString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr)

    let result = sut.propertyString()
    
    let expected = "let fooSegmentedControl: UISegmentedControl"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlInitString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr)

    let result = sut.initString()
    
    let expected = "fooSegmentedControl = UISegmentedControl()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooSegmentedControl.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlSetupString_HasInsertSegmentWithTitleString() {
    let attr = ["id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr) as! SegmentedControl

    sut.add(segment: Segment(dict: ["title": "Foo"]))
    sut.add(segment: Segment(dict: ["title": "Bar"]))
    sut.add(segment: Segment(dict: ["title": "Hello"]))
    sut.add(segment: Segment(dict: ["title": "World", "enabled": "NO"]))
    
    var expectedOutput = "fooSegmentedControl.insertSegment(withTitle:\"Foo\", at: 0, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"Bar\", at: 1, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"Hello\", at: 2, animated: false)\n"
    expectedOutput += "fooSegmentedControl.insertSegment(withTitle:\"World\", at: 3, animated: false)\n"
    expectedOutput += "fooSegmentedControl.setEnabled(false, forSegmentAtIndex: 3)\n"
    XCTAssertEqual(sut.setupString(), expectedOutput)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_selectedSegmentIndex() {
    let attr = ["selectedSegmentIndex": "1", "id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooSegmentedControl.selectedSegmentIndex = 1"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_segmentedControlSetupString_HasExpectedOutputFor_momentary() {
    let attr = ["momentary": "YES", "id": "42", "userLabel": "fooSegmentedControl"]
    let sut = Builder.builder(for: .segmentedControl).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooSegmentedControl.momentary = true"
    XCTAssertEqual(result.trimmed, expected)
  }
}
