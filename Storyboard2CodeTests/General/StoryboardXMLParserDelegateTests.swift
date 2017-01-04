//
//  StoryboardXMLParserDelegateTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 04/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class StoryboardXMLParserDelegateTests: XCTestCase {
  
  var sut: StoryboardXMLParserDelegate!
  
  override func setUp() {
    super.setUp()
    
    sut = StoryboardXMLParserDelegate()
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_ParsesButton() {
    let xmlString = ["<subviews>", "<button id=\"42\" userLabel=\"foo\">", "</button>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Button)
  }
  
  func test_ParsesImageView() {
    let xmlString = ["<subviews>", "<imageView id=\"42\" userLabel=\"foo\">", "</imageView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is ImageView)
  }
  
  func test_ParsesLabel() {
    let xmlString = ["<subviews>", "<label id=\"42\" userLabel=\"foo\">", "</label>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Label)
  }
  
  func parseAndCheckArrays(for string: String, file: StaticString = #file, line: UInt = #line) {
    guard let xmlData = string.data(using: .utf8)
      else {
        
        return XCTFail()
    }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    XCTAssertEqual(sut.viewDict.count, 1, file: file, line: line)
    XCTAssertEqual(sut.tempViews.count, 0, file: file, line: line)
  }
}
