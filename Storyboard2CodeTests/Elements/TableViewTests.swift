//  Created by dasdom on 29.09.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class TableViewTests: XCTestCase {
  
  var sut: TableView!
  
  override func setUp() {
    sut = TableView(dict: ["id": "foo", "userLabel": "foobar"])
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_viewControllerExtension_setsView() {
    let expectedOutput = """
                         override func loadView() {
                         view = Foobar()
                         }
                         """
    
    XCTAssertEqual(sut.viewControllerExtension, expectedOutput)
  }
  
  func test_viewController_whenCellsAreSet_registersCells() {
    sut.cells = [TableViewCell(dict: ["id": "cellId_1", "userLabel": "fooCell"]), TableViewCell(dict: ["id": "cellId_2", "userLabel": "barCell"])]
    
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
