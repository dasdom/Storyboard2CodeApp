//  Created by dasdom on 07.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct ViewMargin : Hashable, Equatable {
  let marginPrefix: String
  let mainUserLabel: String?
  
  func codeString(objC: Bool = false) -> String {
    var string = ""
    if objC {
      string += "UILayoutGuide *\(marginPrefix)Margins = "
      if marginPrefix != mainUserLabel {
        string += "\(marginPrefix)."
      } else {
        string += "self."
      }
      string += "layoutMarginsGuide;\n"
      return string
    } else {
      string += "let \(marginPrefix)Margins = "
      if marginPrefix != mainUserLabel {
        string += "\(marginPrefix)."
      }
      string += "layoutMarginsGuide\n"
      return string
    }
  }
}
