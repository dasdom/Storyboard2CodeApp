import Foundation

final public class Button: View {
  public let contentHorizontalAlignment: String?
  let contentHorizontalAlignmentDefault = "center"
  
  public let contentVerticalAlignment: String?
  let contentVerticalAlignmentDefault = "center"
  
  public let buttonType: String?
  
  public let lineBreakMode: LineBreakMode?
  let lineBreakModeDefault = LineBreakMode.ByTruncatingMiddle
  
  public let enabled: Bool?
  public let highlighted: Bool?
  public let selected: Bool?
  public let reversesTitleShadowWhenHighlighted: Bool?
  public let showsTouchWhenHighlighted: Bool?
  public let adjustsImageWhenHighlighted: Bool?
  public let adjustsImageWhenDisabled: Bool?
  
  public var states: [ButtonState] = []
  
  public required init(dict: [String : String]) {
    contentHorizontalAlignment          = dict["contentHorizontalAlignment"]
    contentVerticalAlignment            = dict["contentVerticalAlignment"]
    buttonType                          = dict["buttonType"]
    lineBreakMode                       = LineBreakMode(rawValue: dict["lineBreakMode"] ?? "foo")
    enabled                             = dict["enabled"].flatMap { $0 == "YES" }
    highlighted                         = dict["highlighted"].flatMap { $0 == "YES" }
    selected                            = dict["selected"].flatMap { $0 == "YES" }
    reversesTitleShadowWhenHighlighted  = dict["reversesTitleShadowWhenHighlighted"].flatMap { $0 == "YES" }
    showsTouchWhenHighlighted           = dict["showsTouchWhenHighlighted"].flatMap { $0 == "YES" }
    adjustsImageWhenHighlighted         = dict["adjustsImageWhenHighlighted"].flatMap { $0 == "YES" }
    adjustsImageWhenDisabled            = dict["adjustsImageWhenDisabled"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)
    
    opaqueDefault = false
    
    type = ElementType.UIButton
  }
  
  public override var initString: String {
    var string = "\(userLabel) = "
    if buttonType == "roundedRect" {
      string += "\(type.rawValue)(type: .system)\n"
    } else {
      assert(false, "Not supported yet")
      string += "Not supported yet"
    }
    return string
  }
  
  public override var setupString: String {
    var string = super.setupString
    if let lineBreakMode = lineBreakMode, lineBreakMode != lineBreakModeDefault {
      string += "\(userLabel).titleLabel?.lineBreakMode = .\(lineBreakMode.codeString)\n"
    }
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
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    if contentHorizontalAlignment != contentHorizontalAlignmentDefault { temp.append("contentHorizontalAlignment") }
    if contentVerticalAlignment != contentVerticalAlignmentDefault { temp.append("contentVerticalAlignment") }
    temp.append("enabled")
    temp.append("highlighted")
    temp.append("selected")
    temp.append("reversesTitleShadowWhenHighlighted")
    temp.append("showsTouchWhenHighlighted")
    temp.append("adjustsImageWhenHighlighted")
    temp.append("adjustsImageWhenDisabled")
    return temp
  }
}
