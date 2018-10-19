import Foundation

struct Font: AttributeCreatable, Equatable {
  let name: String?
  let size: Int
  let type: String?
  
  init(dict: [String : String]) {
    name = dict[Key.name.rawValue]
    size = Int(dict[Key.pointSize.rawValue]!)!
    type = dict[Key.type.rawValue]
  }
}

extension Font {
  fileprivate enum Key: String {
    case name, pointSize, type
  }
}

extension Font: AttributeCodeGeneratable {
  func codeString(objC: Bool = false) -> String {
    if let type = type {
      if type == "system" {
        if objC {
          return "[UIFont systemFontOfSize:\(size)];"
        } else {
          return "UIFont.systemFont(ofSize: \(size))"
        }
      } else if type == "boldSystem" {
        if objC {
          return "[UIFont boldSystemFontOfSize:\(size)];"
        } else {
          return "UIFont.boldSystemFont(ofSize: \(size))"
        }
      } else {
        let message = "\(type) not yet supported"
        assert(false, message)
        return message
      }
    } else {
      if let name = name {
        if objC {
          return "[UIFont fontWithName:@\"\(name)\" size:\(size)];"
        } else {
          return "UIFont(name: \"\(name)\", size: \(size))"
        }
      }
      assert(false, "Not yet supported")
      return "Not yet supported"
    }
  }
}

func ==(lhs: Font, rhs: Font) -> Bool {
  if lhs.name != rhs.name {
    return false
  }
  if lhs.size != rhs.size {
    return false
  }
  if lhs.type != rhs.type {
    return false
  }
  return true
}
