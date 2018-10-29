import Foundation

final class Button: View {
  let contentHorizontalAlignment: String?
  let contentHorizontalAlignmentDefault = "center"
  
  let contentVerticalAlignment: String?
  let contentVerticalAlignmentDefault = "center"
  
  let buttonType: String?
  
  let lineBreakMode: LineBreakMode?
  let lineBreakModeDefault = LineBreakMode.ByTruncatingMiddle
  
  let enabled: Bool?
  let highlighted: Bool?
  let selected: Bool?
  let reversesTitleShadowWhenHighlighted: Bool?
  let showsTouchWhenHighlighted: Bool?
  let adjustsImageWhenHighlighted: Bool?
  let adjustsImageWhenDisabled: Bool?
  
  var states: [ButtonState] = []
  
  required init(dict: [String : String]) {
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
    
    type = .UIButton
  }
  
  override func initString(objC: Bool = false) -> String {
    var string = "\(userLabel) = "
    if buttonType == "roundedRect" {
      string += "\(type.rawValue)(type: .system)\n"
    } else {
      assert(false, "Not supported yet")
      string += "Not supported yet"
    }
    return string
  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)
    if let lineBreakMode = lineBreakMode, lineBreakMode != lineBreakModeDefault {
      string += "    "
      if objC {
        string += "_"
      }
      string += "\(userLabel).titleLabel"
      if !objC {
        string += "?"
      }
      string += ".lineBreakMode = "
      if !objC {
        string += "."
      }
      string += lineBreakMode.codeString(objC: objC)
      if objC {
        string += ";"
      }
      string += "\n"
    }
    string += stateString(fromStates: states)
    return string
  }
  
   func stateString(fromStates states: [ButtonState]) -> String {
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
