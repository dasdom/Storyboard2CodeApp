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

final public class Button: View {
  public let contentHorizontalAlignment: String
  let contentHorizontalAlignmentDefault = "Center"
  
  public let contentVerticalAlignment: String
  let contentVerticalAlignmentDefault = "Center"
  
  public let buttonType: String
  
  public let lineBreakMode: LineBreakMode
  let lineBreakModeDefault = LineBreakMode.ByTruncatingMiddle
  
  public var states: [ButtonState] = []
  
  
  public required init(dict: [String : String]) {
    var tempReflectable: [String] = []
    
    var label = "contentHorizontalAlignment"
    contentHorizontalAlignment = dict[label]!.capitalizeFirst
    if contentHorizontalAlignment != contentHorizontalAlignmentDefault { tempReflectable.append(label) }
    
    label = "contentVerticalAlignment"
    contentVerticalAlignment = dict[label]!.capitalizeFirst
    if contentVerticalAlignment != contentVerticalAlignmentDefault { tempReflectable.append(label) }
    
    label = "buttonType"
    buttonType = dict[label]!.capitalizeFirst
    
    label = "lineBreakMode"
    lineBreakMode = LineBreakMode(rawValue: dict[label]!)!
    if lineBreakMode != lineBreakModeDefault { tempReflectable.append(label) }
    
    super.init(dict: dict)
    super.reflectable += tempReflectable
    
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
    string += stateString(fromStates: states)
    return string
  }
  
//  public func colorString(fromColors colors: [Color]) -> String {
//    var string = ""
//    for color in colors {
//      string += "\(userLabel).\(color.key) = \(color.codeString)\n"
//    }
//    return string
//  }
  
  public func stateString(fromStates states: [ButtonState]) -> String {
    var string = ""
    for state in states {
      string += state.codeString(userLabel)
    }
    return string
  }
}
