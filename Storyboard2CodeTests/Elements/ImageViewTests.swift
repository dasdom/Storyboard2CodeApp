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
    
    let result = sut.initString()
    
    let expected = "fooImageView = UIImageView()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_clipsSubviews() {
    let attr = ["clipsSubviews": "YES", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)
 
    let expected = "fooImageView.clipsToBounds = true"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_scaleAspectFill() {
    let attr = ["contentMode": "scaleAspectFill", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.contentMode = .scaleAspectFill"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_horizontalHuggingPriority() {
    let attr = ["horizontalHuggingPriority": "251", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.setContentHuggingPriority(251, for: .horizontal)"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_verticalHuggingPriority() {
    let attr = ["verticalHuggingPriority": "251", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.setContentHuggingPriority(251, for: .vertical)"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_imageViewSetupString_HasExpectedOutputFor_image() {
    let attr = ["image": "fire", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.image = UIImage(named: \"fire\")"
    XCTAssertEqual(result.trimmed, expected)
  }

  func test_imageViewSetupString_HasExpectedOutputFor_highlightedImage() {
    let attr = ["highlightedImage": "see", "id": "42", "userLabel": "fooImageView"]
    let sut = ImageView(dict: attr)
    
    let result = sut.setupString(objC: false)

    let expected = "fooImageView.highlightedImage = UIImage(named: \"see\")"
    XCTAssertEqual(result.trimmed, expected)
  }
}
