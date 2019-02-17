//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

enum KeyMapping : Equatable, Hashable {
  case key(String)
  case mapping(String, String)
  case prefix(String, String, String)
  case isPrefix(String)
  
  var key: String {
    switch self {
    case .key(let key), .isPrefix(let key), .mapping(let key, _), .prefix(_, _, let key):
      return key
//    case .mapping(let key, _):
//      return key
//    case .prefix(_, let key)
    }
  }
  
  func code(objC: Bool = false) -> String {
    switch self {
    case .key(let key):
      return key
    case .mapping(_, let mapped):
      return mapped
    case .prefix(let swiftPrefix, let objCPrefix, let key):
      if objC {
        return objCPrefix + key
      } else {
        return swiftPrefix + key
      }
    case .isPrefix(let key):
      if objC {
        return "\(key)"
      } else {
        return "is\(key.capitalizeFirst)"
      }
    }
  }
}
