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
  
  func test_ParsesScrollView() {
    let xmlString = ["<subviews>", "<scrollView id=\"42\" userLabel=\"foo\">", "</scrollView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is ScrollView)
  }
  
  func test_ParsesSegmentedControl() {
    let xmlString = ["<subviews>", "<segmentedControl id=\"42\" userLabel=\"foo\">", "</segmentedControl>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is SegmentedControl)
  }
  
  func test_ParsesSlider() {
    let xmlString = ["<subviews>", "<slider id=\"42\" userLabel=\"foo\">", "</slider>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Slider)
  }
  
  func test_ParsesTableView() {
    let xmlString = ["<subviews>", "<tableView id=\"42\" userLabel=\"foo\">", "</tableView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is TableView)
  }
  
  func test_ParsesTableViewCell() {
    let xmlString = ["<tableViewController id=\"23\" customClass=\"bar\">, <tableViewCell id=\"42\" userLabel=\"foo\">", "</tableViewCell>", "</tableViewController>"].joined(separator: "\n")
    guard let xmlData = xmlString.data(using: .utf8)
      else {
        
        return XCTFail()
    }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    XCTAssertEqual(sut.scenes.count, 1)
  }
  
  func test_ParsesTextField() {
    let xmlString = ["<subviews>", "<textField id=\"42\" userLabel=\"foo\">", "</textField>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is TextField)
  }
  
  func test_ParsesView() {
    let xmlString = ["<subviews>", "<view id=\"42\" userLabel=\"foo\">", "</view>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
  }
}

extension StoryboardXMLParserDelegateTests {
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
