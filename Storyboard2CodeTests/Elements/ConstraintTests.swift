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
    
    XCTAssertEqual(constraintString.trimmed, "foo.topAnchor.constraint(equalTo:bar.bottomAnchor),")
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
    
    XCTAssertEqual(constraintString.trimmed, "contentView.topAnchor.constraint(equalTo:bar.bottomAnchor),")
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
    
    XCTAssertEqual(constraintString.trimmed, "topAnchor.constraint(equalTo:bar.bottomAnchor),")
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
    
    XCTAssertEqual(constraintString.trimmed, "[self.foo.topAnchor constraintEqualToAnchor:self.bar.bottomAnchor],")
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
    
    XCTAssertEqual(constraintString.trimmed, "[self.contentView.topAnchor constraintEqualToAnchor:self.bar.bottomAnchor],")
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
    
    XCTAssertEqual(constraintString.trimmed, "[self.topAnchor constraintEqualToAnchor:self.bar.bottomAnchor],")
  }
  
  func test_constraintEqualToConstant_objC() {
    var sut = Constraint(dict: ["id": "1",
                                "firstItem": "12",
                                "firstAttribute": "width",
                                "constant": "23"])
    sut.firstItemName = "foo"
    
    let constraintString = sut.codeString(objC: true)
    
    XCTAssertEqual(constraintString.trimmed, "[self.foo.widthAnchor constraintEqualToConstant:23],")
  }
}
