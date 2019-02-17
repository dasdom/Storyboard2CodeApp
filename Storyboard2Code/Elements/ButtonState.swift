//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct ButtonState: AttributeCreatable, ControlStateCodeGeneratable {
  private let state: String
  private let title: String?
  private var titleColor: Color? = nil
  
  init(dict: [String : String]) {
    state = dict[Key.key.rawValue]!
    title = dict[Key.title.rawValue]
  }
  
  func codeString(_ userLabel: String) -> String {
    var string = ""
    if let title = title {
      string += "\(userLabel).setTitle(\"\(title)\", for: .\(state))\n"
    }
    if let titleColor = titleColor {
      string += "\(userLabel).setTitleColor(\(titleColor.codeString()), for: .\(state))\n"
    }
    return string
  }
  
  mutating func set(titleColor: Color) {
    self.titleColor = titleColor
  }
}

extension ButtonState {
  fileprivate enum Key: String {
    case key, title
  }
}
