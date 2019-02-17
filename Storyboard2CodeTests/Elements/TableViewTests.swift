//  Created by dasdom on 29.09.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class TableViewTests: XCTestCase {
  
//  var sut: TableView!
//
//  override func setUp() {
//    sut = TableView(dict: ["id": "foo", "userLabel": "foobar"])
//  }
//
//  override func tearDown() {
//    sut = nil
//  }
  
  func test_viewControllerExtension_setsView() {
    let attr = ["id": "foo", "userLabel": "foobar"]
    let sut = Builder.builder(for: .tableView).build(attributes: attr)

    let expectedOutput = """
                         override func loadView() {
                         view = Foobar()
                         }
                         """
    
    XCTAssertEqual(sut.viewControllerExtension, expectedOutput)
  }
  
  func test_viewController_whenCellsAreSet_registersCells() {
    let attr = ["id": "foo", "userLabel": "foobar"]
    let sut = Builder.builder(for: .tableView).build(attributes: attr) as! TableView
    let attrCell1 = ["id": "cellId_1", "userLabel": "fooCell"]
    let cell1 = Builder.builder(for: .tableViewCell).build(attributes: attrCell1) as! TableViewCell
    let attrCell2 = ["id": "cellId_2", "userLabel": "barCell"]
    let cell2 = Builder.builder(for: .tableViewCell).build(attributes: attrCell2) as! TableViewCell
    sut.cells = [cell1, cell2]

    let expectedOutput = """
                         override func loadView() {
                         view = Foobar()

                         tableView.register(FooCell.self, forCellReuseIdentifier: "FooCell")
                         tableView.register(BarCell.self, forCellReuseIdentifier: "BarCell")
                         }
                         """

    XCTAssertEqual(sut.viewControllerExtension, expectedOutput)
  }
}
