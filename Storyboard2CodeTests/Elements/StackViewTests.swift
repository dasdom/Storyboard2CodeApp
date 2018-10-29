//  Created by dasdom on 28.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class StackViewTests: XCTestCase {

  func test_init_hasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooStackView"]
    let sut = StackView(dict: attr)
    
    let result = sut.initString()
    
    let expected = "fooStackView = UIStackView()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_initWithArrangedViews_hasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooStackView"]
    let sut = StackView(dict: attr)
    sut.arrangedSubviews.append(Label(dict: ["id": "123", "userLabel": "firstLabel"]))
    sut.arrangedSubviews.append(Label(dict: ["id": "456", "userLabel": "secondLabel"]))

    let result = sut.initString()
    
    let expected = "fooStackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenAxisIsVertical() {
    let attr = ["axis": "vertical", "id": "42", "userLabel": "fooStackView"]
    let sut = StackView(dict: attr)
    
    let result = sut.setupString()
    
    let expected = "fooStackView.axis = .vertical"
    XCTAssertEqual(result.trimmed, expected)
  }

}
