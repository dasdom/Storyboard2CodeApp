import Foundation

public enum Color: AttributeCreatable {
  case RedGreenBlueRepresentation(key:String, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
  case WhiteAlphaRepresentation(key: String, white: CGFloat, alpha: CGFloat)
  case StringRepresentation(key: String, string: String)
  case NotSupported
  
  public var key: String {
    switch self {
    case .RedGreenBlueRepresentation(let key, _, _, _, _): return key
    case .WhiteAlphaRepresentation(let key, _, _): return key
    case .StringRepresentation(let key, _): return key
    default: return "Not Supported"
    }
  }
  
  public init(dict: [String : String]) {
    if let redString = dict["red"],
      greenString = dict["green"],
      blueString = dict["blue"],
      alphaString = dict["alpha"],
      red = Float(redString),
      green = Float(greenString),
      blue = Float(blueString),
      alpha = Float(alphaString) {
      
      self = RedGreenBlueRepresentation(key: dict["key"]!, red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
      
    } else if let whiteString = dict["white"],
      alphaString = dict["alpha"],
      white = Float(whiteString),
      alpha = Float(alphaString) {
      
      self = WhiteAlphaRepresentation(key: dict["key"]!, white: CGFloat(white), alpha: CGFloat(alpha))
      
    } else if let string = dict["cocoaTouchSystemColor"] {
      self = StringRepresentation(key: dict["key"]!, string: string)
    } else {
      self = NotSupported
    }
  }
}

extension Color: AttributeCodeGeneratable {
  public var codeString: String {
    switch self {
    case .RedGreenBlueRepresentation(_, let red, let green, let blue, let alpha):
      return String(format: "UIColor(red: %.3lf, green: %.3lf, blue: %.3lf, alpha: %.3lf)", red, green, blue, alpha)
    case .WhiteAlphaRepresentation(_, let white, let alpha):
      return String(format: "UIColor(white: %.3lf, alpha: %.3lf)", white, alpha)
    case .StringRepresentation(_, let string):
      return "UIColor.\(string)()"
    default:
      return "Not implemented yet"
    }
  }
}
