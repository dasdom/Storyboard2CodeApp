//  Created by dasdom on 19.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct Image {  
  static var mapValue = { (value: String, objC: Bool) -> String in
    return "UIImage(named: \"\(value)\")"
  }
}
