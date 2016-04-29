import Foundation

public struct ButtonState: AttributeCreatable, ControlStateCodeGeneratable {
  public let key: String
  public let title: String?
  public var titleColor: Color? = nil
  
  public init(dict: [String : String]) {
    key = dict["key"]!.capitalizedString
    title = dict["title"]
  }
  
  public func codeString(userLabel: String) -> String {
    var string = ""
    if let title = title {
      string += "\(userLabel).setTitle(\"\(title)\", forState: .\(key))\n"
    }
    if let titleColor = titleColor {
      string += "\(userLabel).setTitleColor(\(titleColor.codeString), forState: .\(key))\n"
    }
    return string
  }
}

public class Button: View {
  public let contentHorizontalAlignment: String
  public let contentVerticalAlignment: String
  public let buttonType: String
  public let lineBreakMode: LineBreakMode
  public var states: [ButtonState] = []
  
  public required init(dict: [String : String]) {
    
    contentHorizontalAlignment = dict["contentHorizontalAlignment"]!.capitalizeFirst
    contentVerticalAlignment = dict["contentVerticalAlignment"]!.capitalizeFirst
    buttonType = dict["buttonType"]!.capitalizeFirst
    lineBreakMode = LineBreakMode(rawValue: dict["lineBreakMode"]!)!
    
    super.init(dict: dict)
    
    type = ElementType.UIButton
  }
  
  public override var initString: String {
    var string = "\(userLabel) = "
    if buttonType == "RoundedRect" {
      string += "\(type.rawValue)(type: .System)\n"
    } else {
      assert(false, "Not supported yet")
      string += "Not supported yet"
    }
    string += "\(userLabel).translatesAutoresizingMaskIntoConstraints = \(translatesAutoresizingMaskIntoConstraints)\n"
    if opaque != false { // Default = false
      string += "\(userLabel).opaque = \(opaque)\n"
    }
    if contentMode != "ScaleToFill" { // Default = ScaleToFill
      string += "\(userLabel).contentMode = .\(contentMode)\n"
    }
    if contentHorizontalAlignment != "Left" { // Default = Left
      string += "\(userLabel).contentHorizontalAlignment = .\(contentHorizontalAlignment)\n"
    }
    if contentVerticalAlignment != "Center" { // Default = Center
      string += "\(userLabel).contentVerticalAlignment = .\(contentVerticalAlignment)\n"
    }
    for color in colors {
      string += "\(userLabel).\(color.key) = \(color.codeString)\n"
    }
    if lineBreakMode != .ByTruncatingMiddle { // Default
      string += "\(userLabel).titleLabel?.lineBreakMode = \(lineBreakMode.codeString)"
    }
    for state in states {
      string += state.codeString(userLabel)
    }
    return string
  }
}
