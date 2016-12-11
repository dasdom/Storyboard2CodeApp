//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public class Slider: View {
  let minimumValue: Float
  let maximumValue: Float
  let value: Float
  let continuous: Bool?
  
  public required init(dict: [String : String]) {
    minimumValue = Float(dict[Key.minValue.rawValue]!)!
    maximumValue = Float(dict[Key.maxValue.rawValue]!)!
    value = Float(dict[Key.value.rawValue]!)!
    continuous = dict[Key.continuous.rawValue].flatMap { $0 == "YES" }
    
    super.init(dict: dict)
    
    type = ElementType.UISlider
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    temp.append("minimumValue")
    temp.append("maximumValue")
    temp.append(Key.value.rawValue)
    temp.append(Key.continuous.rawValue)
    
    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
    temp = temp.filter { $0 != "opaque" }
    return temp
  }
}

extension Slider {
  fileprivate enum Key: String {
    case minValue, maxValue, value, continuous
  }
}
