//
//  Slider.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public class Slider: View {
  let minValue: Float
  let maxValue: Float
  let value: Float
  
  public required init(dict: [String : String]) {
    minValue = Float(dict["minValue"]!)!
    maxValue = Float(dict["maxValue"]!)!
    value = Float(dict["value"]!)!
    
    super.init(dict: dict)
    
    type = ElementType.UISlider
  }
  
  public override var initString: String {
    var string = super.initString
    string += "\(userLabel).minimumValue = \(minValue)\n"
    string += "\(userLabel).maximumValue = \(maxValue)\n"
    string += "\(userLabel).value = \(value)\n"
    return string
  }
}
