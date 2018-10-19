//  Created by dasdom on 19.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class FontTests: XCTestCase {
  func test_systemFont() {
    let sut = Font(dict: ["pointSize": "15", "type": "system"])
    
    let result = sut.codeString()
    
    XCTAssertEqual(result.trimmed, "UIFont.systemFont(ofSize: 15)")
  }
  
  func test_boldSystemFont() {
    let sut = Font(dict: ["pointSize": "15", "type": "boldSystem"])
    
    let result = sut.codeString()
    
    XCTAssertEqual(result.trimmed, "UIFont.boldSystemFont(ofSize: 15)")
  }
  
  func test_fontWithName() {
    let sut = Font(dict: ["pointSize": "15", "name": "Foo"])
    
    let result = sut.codeString()
    
    XCTAssertEqual(result.trimmed, "UIFont(name: \"Foo\", size: 15)")
  }
}

extension FontTests {
  func test_systemFont_objC() {
    let sut = Font(dict: ["pointSize": "15", "type": "system"])
    
    let result = sut.codeString(objC: true)
    
    XCTAssertEqual(result.trimmed, "[UIFont systemFontOfSize:15];")
  }
  
  func test_boldSystemFont_objC() {
    let sut = Font(dict: ["pointSize": "15", "type": "boldSystem"])
    
    let result = sut.codeString(objC: true)
    
    XCTAssertEqual(result.trimmed, "[UIFont boldSystemFontOfSize:15];")
  }
  
  func test_fontWithName_objC() {
    let sut = Font(dict: ["pointSize": "15", "name": "Foo"])
    
    let result = sut.codeString(objC: true)
    
    XCTAssertEqual(result.trimmed, "[UIFont fontWithName:@\"Foo\" size:15];")
  }
  
}
