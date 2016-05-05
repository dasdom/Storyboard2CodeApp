//
//  TextFieldTests.swift
//  Storyboard2Code
//
//  Created by dasdom on 05.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class TextFieldTests: XCTestCase {
  
  var codeString: String!
  let codeCreator = CodeCreator()
  
  override func setUp() {
    super.setUp()
    guard let data = dataFromResource(withName: "TextFieldTests", andType: "xml") else { fatalError() }
    codeString = codeCreator.codeStringFrom(XMLdata: data)
    print(codeString)
  }
  
}
