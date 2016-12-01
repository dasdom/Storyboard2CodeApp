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
    minimumValue = Float(dict["minValue"]!)!
    maximumValue = Float(dict["maxValue"]!)!
    value = Float(dict["value"]!)!
    continuous = dict["continuous"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)
    
    type = ElementType.UISlider
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    temp.append("minimumValue")
    temp.append("maximumValue")
    temp.append("value")
    temp.append("continuous")
    
    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
    temp = temp.filter { $0 != "opaque" }
    return temp
  }
}
