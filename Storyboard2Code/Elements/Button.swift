import Foundation

final public class Button: View {
  public let contentHorizontalAlignment: String
  let contentHorizontalAlignmentDefault = "Center"
  
  public let contentVerticalAlignment: String
  let contentVerticalAlignmentDefault = "Center"
  
  public let buttonType: String
  
  public let lineBreakMode: LineBreakMode
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
//    if lineBreakMode != lineBreakModeDefault { tempReflectable.append(label) }
    
    label = "enabled"
    enabled = dict[label].flatMap { $0 == "YES" }
    if enabled != nil { tempReflectable.append(label) }
    
    label = "highlighted"
    highlighted = dict[label].flatMap { $0 == "YES" }
    if highlighted != nil { tempReflectable.append(label) }
    
    label = "selected"
    selected = dict[label].flatMap { $0 == "YES" }
    if selected != nil { tempReflectable.append(label) }
    
    label = "reversesTitleShadowWhenHighlighted"
    reversesTitleShadowWhenHighlighted = dict[label].flatMap { $0 == "YES" }
    if reversesTitleShadowWhenHighlighted != nil { tempReflectable.append(label) }
    
    label = "showsTouchWhenHighlighted"
    showsTouchWhenHighlighted = dict[label].flatMap { $0 == "YES" }
    if showsTouchWhenHighlighted != nil { tempReflectable.append(label) }
    
    label = "adjustsImageWhenHighlighted"
    adjustsImageWhenHighlighted = dict[label].flatMap { $0 == "YES" }
    if adjustsImageWhenHighlighted != nil { tempReflectable.append(label) }
    
    label = "adjustsImageWhenDisabled"
    adjustsImageWhenDisabled = dict[label].flatMap { $0 == "YES" }
    if adjustsImageWhenDisabled != nil { tempReflectable.append(label) }
    
    super.init(dict: dict)
    super.reflectable += tempReflectable
    
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
    if lineBreakMode != lineBreakModeDefault {
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
}
