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
    XCTAssertTrue(sut.viewDictForConstraints.values.first is Button)
  }
  
  func test_ParsesImageView() {
    let xmlString = ["<subviews>", "<imageView id=\"42\" userLabel=\"foo\">", "</imageView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is ImageView)
  }
  
  func test_ParsesLabel() {
    let xmlString = ["<subviews>", "<label id=\"42\" userLabel=\"foo\">", "</label>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is Label)
  }
  
  func test_ParsesScrollView() {
    let xmlString = ["<subviews>", "<scrollView id=\"42\" userLabel=\"foo\">", "</scrollView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is ScrollView)
  }
  
  func test_ParsesSegmentedControl() {
    let xmlString = ["<subviews>", "<segmentedControl id=\"42\" userLabel=\"foo\">", "</segmentedControl>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is SegmentedControl)
  }
  
  func test_ParsesSlider() {
    let xmlString = ["<subviews>", "<slider id=\"42\" userLabel=\"foo\">", "</slider>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is Slider)
  }
  
  func test_ParsesTableView() {
    let xmlString = ["<subviews>", "<tableView id=\"42\" userLabel=\"foo\">", "</tableView>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is TableView)
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
    
    XCTAssertEqual(sut.fileRepresentations.count, 1)
  }
  
  func test_ParsesTextField() {
    let xmlString = ["<subviews>", "<textField id=\"42\" userLabel=\"foo\">", "</textField>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDictForConstraints.values.first is TextField)
  }
  
  func test_ParsesView() {
    let xmlString = ["<subviews>", "<view id=\"42\" userLabel=\"foo\">", "</view>", "</subviews>"].joined(separator: "\n")
    
    parseAndCheckArrays(for: xmlString)
  }
  
  func test_ParsesSubView() {
    let xmlString = ["<view id=\"mainId\" userLabel=\"mainLabel\">",
                     "<subviews>",
                     "<view id=\"subViewId\" userLabel=\"subViewLabel\">",
                     "<subviews>",
                     "<view id=\"firstSubSubViewId\" userLabel=\"firstSubSubViewLabel\">",
                     "</view>",
                     "<view id=\"secondSubSubViewId\" userLabel=\"secondSubSubViewLabel\">",
                     "</view>",
                     "</subviews>",
                     "</view>",
                     "</subviews>",
                     "</view>"].joined(separator: "\n")
    
    guard let xmlData = xmlString.data(using: .utf8) else { return XCTFail() }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let subView = sut.viewDictForConstraints["subViewId"]
    XCTAssertEqual(subView?.addToSuperString, "addSubview(subViewLabel)")
    let firstSubSubView = sut.viewDictForConstraints["firstSubSubViewId"]
    XCTAssertEqual(firstSubSubView?.addToSuperString, "subViewLabel.addSubview(firstSubSubViewLabel)")
    let secondSubSubView = sut.viewDictForConstraints["secondSubSubViewId"]
    XCTAssertEqual(secondSubSubView?.addToSuperString, "subViewLabel.addSubview(secondSubSubViewLabel)")
  }
  
  func test_ParsesTableViewCellSubViews() {
    let xmlString = ["<tableViewController id=\"tableViewControllerId\" customClass=\"TableViewControllerClass\">",
                     "<tableView id=\"tableViewId\" userLabel=\"tableViewLabel\">",
                     "<prototypes>",
                     "<tableViewCell id=\"firstTableViewCellId\" userLabel=\"firstTableViewCellLabel\">",
                     "<tableViewCellContentView id=\"firstTableViewCellContentViewId\">",
                     "<subviews>",
                     "<imageView id=\"imageViewId\" userLabel=\"imageViewLabel\">",
                     "</imageView>",
                     "</subviews>",
                     "</tableViewCellContentView>",
                     "</tableViewCell>",
                     "<tableViewCell id=\"secondTableViewCellId\" userLabel=\"SecondTableViewCellLabel\">",
                     "<tableViewCellContentView id=\"secondTableViewCellContentViewId\">",
                     "<subviews>",
                     "<label id=\"labelId\" userLabel=\"labelLabel\">",
                     "</label>",
                     "</subviews>",
                     "</tableViewCellContentView>",
                     "</tableViewCell>",
                     "</prototypes>",
                     "</tableView>",
                     "</tableViewController>"].joined(separator: "\n")
    
    guard let xmlData = xmlString.data(using: .utf8) else { return XCTFail() }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let subView = sut.viewDictForConstraints["imageViewId"]
    XCTAssertEqual(subView?.addToSuperString, "contentView.addSubview(imageViewLabel)")
    
    guard let firstFileRepresentation = sut.fileRepresentations.first else { return XCTFail() }
    XCTAssertTrue(firstFileRepresentation.mainView is TableViewCell)
    XCTAssertEqual(firstFileRepresentation.viewDict.count, 1)
    
    guard let lastFileRepresentation = sut.fileRepresentations.last else { return XCTFail() }
    XCTAssertTrue(lastFileRepresentation.mainView is TableViewCell)
    XCTAssertEqual(lastFileRepresentation.viewDict.count, 1)
  }
  
  func test_ParsingTableView_DoesNotAddCellsAsSubview() {
    let xmlString = ["<scene>",
                     "<tableViewController id=\"tableViewControllerId\" customClass=\"TableViewControllerClass\">",
                     "<tableView id=\"tableViewId\" userLabel=\"tableViewLabel\">",
                     "<prototypes>",
                     "<tableViewCell id=\"firstTableViewCellId\" userLabel=\"firstTableViewCellLabel\">",
                     "<tableViewCellContentView id=\"firstTableViewCellContentViewId\">",
                     "</tableViewCellContentView>",
                     "</tableViewCell>",
                     "</prototypes>",
                     "</tableView>",
                     "</tableViewController>",
                     "</scene>"].joined(separator: "\n")
    
    guard let xmlData = xmlString.data(using: .utf8) else { return XCTFail() }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    guard let lastFileRepresentation = sut.fileRepresentations.last else { return XCTFail() }
    XCTAssertTrue(lastFileRepresentation.mainView is TableView)
    XCTAssertNil(lastFileRepresentation.viewDict["firstTableViewCellId"])
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
    
    XCTAssertEqual(sut.viewDictForConstraints.count, 1, file: file, line: line)
    XCTAssertEqual(sut.tempViews.count, 0, file: file, line: line)
  }
}
