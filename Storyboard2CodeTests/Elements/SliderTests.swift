//  Created by dasdom on 08.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SliderTests: XCTestCase {
  
  func test_sliderPropertyString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.propertyString()

    let expected = "let fooSlider: UISlider"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderInitString_HasExpectedOutput() {
    let attr = ["id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.initString()

    let expected = "fooSlider = UISlider()"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_translatesAutoresizingMaskIntoConstraints() {
    let attr = ["translatesAutoresizingMaskIntoConstraints": "NO", "id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooSlider.translatesAutoresizingMaskIntoConstraints = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_value() {
    let attr = ["value": "5", "id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.setupString(objC: false)

    let expected = "fooSlider.value = 5"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_minValue() {
    let attr = ["minValue": "-7", "id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.minimumValue = -7"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_maxValue() {
    let attr = ["maxValue": "33", "id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.maximumValue = 33"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_continuous() {
    let attr = ["continuous": "NO", "id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)

    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.continuous = false"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_minimumTrackTintColor() {
    let attr = ["id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)
    let color = Color(dict: ["key": "minimumTrackTintColor", "red": "0.0", "green": "0.50196081400000003", "blue": "0.0", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    sut.add(color: color)
    
    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.minimumTrackTintColor = UIColor(red: 0.000, green: 0.502, blue: 0.000, alpha: 1.000)"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_maximumTrackTintColor() {
    let attr = ["id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)
    let color = Color(dict: ["key": "maximumTrackTintColor", "red": "1", "green": "0.0", "blue": "0.0", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    sut.add(color: color)

    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.maximumTrackTintColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)"
    XCTAssertEqual(result.trimmed, expected)
  }
  
  func test_sliderSetupString_HasExpectedOutputFor_thumbTintColor() {
    let attr = ["id": "42", "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)
    let color = Color(dict: ["key": "thumbTintColor", "red": "0.0", "green": "0.25098040700000002", "blue": "0.50196081400000003", "alpha": "1", "colorSpace": "custom", "customColorSpace": "sRGB"])
    sut.add(color: color)

    let result = sut.setupString(objC: false)
    
    let expected = "fooSlider.thumbTintColor = UIColor(red: 0.000, green: 0.251, blue: 0.502, alpha: 1.000)"
    XCTAssertEqual(result.trimmed, expected)
  }
}

extension SliderTests {
  func test_sliderSetupString_HasNoOutputForDefaultValues() {
    let attr = ["opaque": "NO",
                "contentMode": "scaleToFill",
                "contentHorizontalAlignment": "center",
                "contentVerticalAlignment": "center",
                "id": "42",
                "userLabel": "fooSlider"]
    let sut = Builder.builder(for: .slider).build(attributes: attr)
    
    let expectedOutput = ""
    XCTAssertEqual(sut.setupString(objC: false), expectedOutput)
  }
}
