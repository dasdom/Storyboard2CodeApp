//  Created by dasdom on 03.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SafeAreaLayoutGuide_StoryboardXMLParserDelegateTests: XCTestCase {

  var sut: StoryboardXMLParserDelegate!

  override func setUp() {
    super.setUp()
    
    sut = StoryboardXMLParserDelegate()
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_parsing_createsObject() {
    let xmlString = """
      <view key="view" contentMode="scaleToFill" id="viewId">
        <viewLayoutGuide key="safeArea" id="6Tk-OE-BBY"/>
      </view>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let safeAreaLayoutGuide = sut.safeAreaLayoutGuides.first
    XCTAssertEqual(safeAreaLayoutGuide?.id, "6Tk-OE-BBY")
  }
  
  func test_parsing_setsItemNameInConstraint() {
    let xmlString = """
      <view key="view" contentMode="scaleToFill" id="viewId">
        <constraints>
          <constraint firstItem="Dim-RV-AiE" firstAttribute="top" secondItem="6Tk-OE-BBY" secondAttribute="top" id="rP8-Yv-KhH"/>
        </constraints>
        <viewLayoutGuide key="safeArea" id="6Tk-OE-BBY"/>
      </view>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let constraint = sut.constraints.first
    XCTAssertEqual(constraint?.secondItemName, "safeAreaLayoutGuide")
  }
}
