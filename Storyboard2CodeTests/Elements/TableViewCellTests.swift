//  Created by dasdom on 30.09.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class TableViewCellTests: XCTestCase {
  
  var sut: TableViewCell!
  
  override func setUp() {
    sut = TableViewCell(dict: ["id": "cellId_1", "userLabel": "fooCell"])
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_viewControllerExtension_isEmpty() {
    XCTAssertEqual(sut.viewControllerExtension, "")
  }
  
}
