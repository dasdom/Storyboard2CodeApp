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
    
    clipsSubviewsDefault = false
    opaqueDefault = false
    
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
    return string
  }
  
  public override var setupString: String {
    var string = super.setupString
    if contentHorizontalAlignment != "Center" { // Default = Center
      string += "\(userLabel).contentHorizontalAlignment = .\(contentHorizontalAlignment)\n"
    }
    if contentVerticalAlignment != "Center" { // Default = Center
      string += "\(userLabel).contentVerticalAlignment = .\(contentVerticalAlignment)\n"
    }
    if lineBreakMode != .ByTruncatingMiddle { // Default
      string += "\(userLabel).titleLabel?.lineBreakMode = \(lineBreakMode.codeString)"
    }

    string += stateString(fromStates: states)
    
    return string
  }
  
  public func colorString(fromColors colors: [Color]) -> String {
    var string = ""
    for color in colors {
      string += "\(userLabel).\(color.key) = \(color.codeString)\n"
    }
    return string
  }
  
  public func stateString(fromStates states: [ButtonState]) -> String {
    var string = ""
    for state in states {
      string += state.codeString(userLabel)
    }
    return string
  }
}
