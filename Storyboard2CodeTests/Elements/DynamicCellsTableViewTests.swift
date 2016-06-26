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
  
  func test_TableViewCodeString_HasInitWithCoderStatement() {
    let expectedString = "required init?(coder aDecoder: NSCoder) {\nfatalError(\"init(coder:) has not been implemented\")\n}"
    XCTAssertTrue(codeString.contains(expectedString))
  }
}
