//  Created by dasdom on 28.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class StackViewTests: XCTestCase {

  func test_init_hasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.initString()
    
    let expected = "fooStackView = UIStackView()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenAxisIsVertical() {
    let attr = ["axis": "vertical", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooStackView.axis = .vertical"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_setupString_whenSpacingIsPresent() {
    let attr = ["spacing": "10", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooStackView.spacing = 10"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenDistributionIsPresent() {
    let attr = ["distribution": "fillEqually", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooStackView.distribution = .fillEqually"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenDistributionIsDefault() {
    let attr = ["distribution": "fill", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString()
    
    XCTAssertEqual(result.trimmed, "")
  }
  
  func test_setupString_whenAlignmentIsPresent() {
    let attr = ["alignment": "top", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString()
    
    let expected = "fooStackView.alignment = .top"
    XCTAssertEqual(result.trimmed, expected)
  }
}

// MARK: - ObjC
extension StackViewTests {
  func test_init_hasExpectedOutput_objC() {
    let attr = ["id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.initString(objC: true)
    
    let expected = "_fooStackView = [[UIStackView alloc] init];"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenAxisIsVertical_objC() {
    let attr = ["axis": "vertical", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooStackView.axis = UILayoutConstraintAxisVertical;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenSpacingIsPresent_ojbC() {
    let attr = ["spacing": "10", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooStackView.spacing = 10;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenDistributionIsPresent_objC() {
    let attr = ["distribution": "fillEqually", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooStackView.distribution = UIStackViewDistributionFillEqually;"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_setupString_whenAlignmentIsPresent_objC() {
    let attr = ["alignment": "top", "id": "42", "userLabel": "fooStackView"]
    let sut = Builder.builder(for: .stackView).build(attributes: attr)

    let result = sut.setupString(objC: true)
    
    let expected = "_fooStackView.alignment = UIStackViewAlignmentTop;"
    XCTAssertEqual(result.trimmed, expected)
  }
}
