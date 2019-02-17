//  Created by dasdom on 17.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct ContentHuggingPriority {
  enum Axis: String {
    case horizontalHuggingPriority
    case verticalHuggingPriority
  }
  
  let axis: Axis
  let value: String
  
  static var mapKeyAndValue = { (key: String, value: String, objC: Bool) -> String in
    guard let axis = Axis(rawValue: key) else { return "" }
    let huggingPriority = ContentHuggingPriority(axis: axis, value: value)
    return huggingPriority.code(objC: objC)
  }
  
  func code(objC: Bool) -> String {
    var code = ""
    if objC {
      code += "setContentHuggingPriority:"
    } else {
      code += "setContentHuggingPriority(UILayoutPriority(rawValue: "
    }
    
    if objC {
      switch self.axis {
      case .horizontalHuggingPriority:
        code += value + " forAxis:UILayoutConstraintAxisHorizontal]"
      case .verticalHuggingPriority:
        code += value + " forAxis:UILayoutConstraintAxisVertical]"
      }
    } else {
      switch self.axis {
      case .horizontalHuggingPriority:
        code += value + "), for: .horizontal)"
      case .verticalHuggingPriority:
        code += value + "), for: .vertical)"
      }
    }
    
    return code
  }
}
