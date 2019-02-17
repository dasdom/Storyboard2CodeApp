//  Created by dasdom on 17.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct LayoutPriority {
  let rawValue: Int
  
  func code(objC: Bool) -> String {
    if objC {
      return "\(rawValue)"
    } else {
      return "UILayoutPriority(rawValue: \(rawValue)"
    }
  }
}
