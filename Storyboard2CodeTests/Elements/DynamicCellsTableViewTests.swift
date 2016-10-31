//
//  TableViewTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 28.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class DynamicCellsTableViewTests: XCTestCase {
  
  var codeString = ""
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "DynamicCellsTableViewTests", andType: "xml") else { fatalError() }
    let strings = codeCreator.codeStringsFrom(XMLdata: data)
    codeString = ""
    for (_, value) in strings {
      codeString += value
    }
    print(codeString)
  }
  
  func test_TableViewCodeString_HasImportStatement() {
    let expectedString = "import UIKit\n\n"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasClassStatement() {
    let expectedString = "class FooTableView: UITableView {"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasOverrideInitStatement() {
    let expectedString = "override init(frame: CGRect, style: UITableViewStyle) {"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSuperInitStatement() {
    let expectedString = "super.init(frame: frame, style: style)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSeparatorStyleStatement() {
    let expectedString = "separatorStyle = .singleLineEtched"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionIndexMinimumDisplayRowCountStatement() {
    let expectedString = "sectionIndexMinimumDisplayRowCount = 2"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasAllowsSelectionDuringEditingStatement() {
    let expectedString = "allowsSelectionDuringEditing = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasAllowsMultipleSelectionStatement() {
    let expectedString = "allowsMultipleSelection = true"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasRowHeightStatement() {
    let expectedString = "rowHeight = 44"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionHeaderHeightStatement() {
    let expectedString = "sectionHeaderHeight = 18"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionFooterHeightStatement() {
    let expectedString = "sectionFooterHeight = 18"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasBackgroundColorStatement() {
    let expectedString = "backgroundColor = UIColor(colorLiteralRed: 0.937, green: 0.937, blue: 0.957, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSeparatorColorStatement() {
    let expectedString = "separatorColor = UIColor(colorLiteralRed: 0.000, green: 0.502, blue: 0.000, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionIndexColorStatement() {
    let expectedString = "sectionIndexColor = UIColor(colorLiteralRed: 0.909, green: 0.302, blue: 0.236, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionIndexBackgroundColorStatement() {
    let expectedString = "sectionIndexBackgroundColor = UIColor(colorLiteralRed: 0.400, green: 0.800, blue: 1.000, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasSectionIndexTrackingBackgroundColorStatement() {
    let expectedString = "sectionIndexTrackingBackgroundColor = UIColor(colorLiteralRed: 0.216, green: 0.286, blue: 0.600, alpha: 1.000)"
    XCTAssertTrue(codeString.contains(expectedString))
  }
  
  func test_TableViewCodeString_HasInitWithCoderStatement() {
    let expectedString = "}\n\nrequired init?(coder aDecoder: NSCoder) {\nfatalError(\"init(coder:) has not been implemented\")\n}"
    XCTAssertTrue(codeString.contains(expectedString))
  }
}
