//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

enum ValueFormat {
  case string
  case number
  case enumCase
  case bool
  case method
  case raw
  
  func code(for raw: String, objC: Bool = false) -> String {
    if objC {
      switch self {
      case .string:
        return "@\"\(raw)\""
      case .number, .enumCase, .bool, .raw:
        return raw
      case .method:
        return ""
      }
    } else {
      switch self {
      case .string:
        return "\"\(raw)\""
      case .number, .raw:
        return raw
      case .enumCase:
        return ".\(raw)"
      case .bool:
        return raw == "YES" ? "true" : "false"
      case .method:
        return ""
      }
    }
  }
}
