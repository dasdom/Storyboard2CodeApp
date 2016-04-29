import Foundation

public struct Font: AttributeCreatable, Equatable {
  let name: String?
  let size: Int
  let type: String?
  
  public init(dict: [String : String]) {
    name = dict["name"]
    size = Int(dict["pointSize"]!)!
    type = dict["type"]
  }
}

extension Font: AttributeCodeGeneratable {
  public var codeString: String {
    if let type = type {
      if type == "system" {
        return "UIFont.systemFontOfSize(\(size))"
      } else if type == "boldSystem" {
        return "UIFont.boldSystemFontOfSize(\(size))"
      } else {
        let message = "\(type) not yet supported"
        assert(false, message)
        return message
      }
    } else {
      if let name = name {
        return "UIFont(name: \"\(name)\", size: \(size))"
      }
      assert(false, "Not yet supported")
      return "Not yet supported"
    }
  }
}

public func ==(lhs: Font, rhs: Font) -> Bool {
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
