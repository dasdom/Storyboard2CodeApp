//  Created by dasdom on 30/12/2016.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class ImageViewTests: XCTestCase {
  
  var sut: ImageView!
  
  override func setUp() {
    super.setUp()

    sut = ImageView(dict: ["id": "42", "userLabel": "fooImageView"])
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_imageViewPropertyString_HasExpectedOutput() {
    
    let result = sut.propertyString()
    
    let expectedOutput = "let fooImageView: UIImageView"
    XCTAssertEqual(result.trimmed, expectedOutput)
  }
  
  func test_imageViewInitString_HasExpectedOutput() {
    let expectedOutput = "fooImageView = UIImageView()\n"
    XCTAssertEqual(sut.initString(), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attributesDict = ["translatesAutoresizingMaskIntoConstraints": "NO",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.translatesAutoresizingMaskIntoConstraints = false\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attributesDict = ["clipsSubviews": "YES",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.clipsToBounds = true\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_scaleAspectFill() {
    let attributesDict = ["contentMode": "scaleAspectFill",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.contentMode = .scaleAspectFill\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_horizontalHuggingPriority() {
    let attributesDict = ["horizontalHuggingPriority": "251",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.setContentHuggingPriority(251, for: .horizontal)\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_verticalHuggingPriority() {
    let attributesDict = ["verticalHuggingPriority": "251",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.setContentHuggingPriority(251, for: .vertical)\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_image() {
    let attributesDict = ["image": "fire",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.image = UIImage(named: \"fire\")\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }

  func test_imageViewSetupString_HasExpectedOutputFor_highlightedImage() {
    let attributesDict = ["highlightedImage": "see",
                          "id": "42",
                          "userLabel": "fooImageView"]
    let localSUT = ImageView(dict: attributesDict)
    
    let expectedOutput = "fooImageView.highlightedImage = UIImage(named: \"see\")\n"
    XCTAssertEqual(localSUT.setupString(objC: false), expectedOutput)
  }
}
