//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct ButtonState: AttributeCreatable, ControlStateCodeGeneratable {
  let key: String
  let title: String?
  var titleColor: Color? = nil
  
  init(dict: [String : String]) {
    key = dict[Key.key.rawValue]!
    title = dict[Key.title.rawValue]
  }
  
  func codeString(_ userLabel: String) -> String {
    var string = ""
    if let title = title {
      string += "\(userLabel).setTitle(\"\(title)\", for: .\(key))\n"
    }
    if let titleColor = titleColor {
      string += "\(userLabel).setTitleColor(\(titleColor.codeString), for: .\(key))\n"
    }
    return string
  }
}

extension ButtonState {
  fileprivate enum Key: String {
    case key, title
  }
}
