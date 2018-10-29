//  Created by dasdom on 25.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class StackView_StoryboardXMLParserDelegateTests: XCTestCase {

  var sut: StoryboardXMLParserDelegate!

  override func setUp() {
    super.setUp()
    
    sut = StoryboardXMLParserDelegate()
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_parsingOfStackview_createsStackView() {
    let xmlString = """
      <view id="mainId" userLabel="mainLabel">
        <subviews>
          <stackView axis="vertical" spacing="10" id="stackViewId" userLabel="blaStackView">
            <rect key="frame" x="0.0" y="0.0" width="42" height="51"/>
            <subviews>
              <label id="zdB-V2-Pkc" userLabel="firstLabel">
                <rect key="frame" x="0.0" y="0.0" width="42" height="20.5"/>
              </label>
              <label id="Ju8-oh-HLB" userLabel="secondLabel">
                <rect key="frame" x="0.0" y="30.5" width="42" height="20.5"/>
              </label>
            </subviews>
          </stackView>
        </subviews>
      </view>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let stackView = sut.viewDict["stackViewId"] as! StackView
    XCTAssertEqual(stackView.arrangedSubviews.first?.userLabel, "firstLabel")
    XCTAssertEqual(stackView.arrangedSubviews.last?.userLabel, "secondLabel")
  }
}
