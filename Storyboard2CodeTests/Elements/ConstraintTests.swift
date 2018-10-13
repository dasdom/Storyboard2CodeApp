//  Created by dasdom on 11.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ConstraintTests: XCTestCase {
  
  func test_simpleConstraint() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = "foo"
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString()
    
    XCTAssertEqual(constraintString, "foo.topAnchor.constraint(equalTo:bar.bottomAnchor),\n")
  }
  
  func test_constraintWithContentView() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = "contentView_of_a_tableviewcell"
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString()
    
    XCTAssertEqual(constraintString, "contentView.topAnchor.constraint(equalTo:bar.bottomAnchor),\n")
  }
  
  func test_constraintWithEmptyFirstItemName() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = ""
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString()
    
    XCTAssertEqual(constraintString, "topAnchor.constraint(equalTo:bar.bottomAnchor),\n")
  }
}

// ==========================================================
// MARK: - ObjC
extension ConstraintTests {
  func test_simpleConstraint_objC() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = "foo"
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString(objC: true)
    
    XCTAssertEqual(constraintString, "[_foo.topAnchor constraintEqualToAnchor:_bar.bottomAnchor],\n")
  }
  
  func test_constraintWithContentView_objC() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = "contentView_of_a_tableviewcell"
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString(objC: true)
    
    XCTAssertEqual(constraintString, "[self.contentView.topAnchor constraintEqualToAnchor:_bar.bottomAnchor],\n")
  }
  
  func test_constraintWithEmptyFirstItemName_objC() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "top",
                                "secondItem": "13",
                                "secondAttribute": "bottom"])
    sut.firstItemName = ""
    sut.secondItemName = "bar"
    
    let constraintString = sut.codeString(objC: true)
    
    XCTAssertEqual(constraintString, "[self.topAnchor constraintEqualToAnchor:_bar.bottomAnchor],\n")
  }
}
