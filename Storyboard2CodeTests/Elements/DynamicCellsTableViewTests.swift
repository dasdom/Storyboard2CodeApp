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
  
  func test_ScrollViewReturnsCorrectInitString() {
    let expectedString = "fooTableView = FooTableView()\n"
    XCTAssertTrue(codeString.containsString(expectedString))
  }
}
