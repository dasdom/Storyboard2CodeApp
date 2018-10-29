import Foundation

final class Label: View {
  let horizontalHuggingPriority: Int?
  var horizontalHuggingPriorityDefault = 251
  let verticalHuggingPriority: Int?
  var verticalHuggingPriorityDefault = 251
  var text: String?
  var textAlignment: String?
  var textAlignmentDefault = "natural"
  let lineBreakMode: LineBreakMode?
  var lineBreakModeDefault = LineBreakMode.ByTruncatingTail
  let baselineAdjustment: String?
  var baseLineAdjustmentDefault = "alignBaselines"
//  public let adjustsFontSizeToFitWidth: Bool
  let numberOfLines: String?
  let minimumScaleFactor: String?
  let enabled: Bool?
  let highlighted: Bool?
  
  required init(dict: [String : String]) {

    horizontalHuggingPriority = dict["horizontalHuggingPriority"] != nil ? Int(dict["horizontalHuggingPriority"]!) : nil
    verticalHuggingPriority   = dict["verticalHuggingPriority"] != nil ? Int(dict["verticalHuggingPriority"]!) : nil
    
    text                = dict["text"]
    textAlignment       = dict["textAlignment"]
    lineBreakMode       = LineBreakMode(rawValue: dict["lineBreakMode"] ?? "foo")
    baselineAdjustment  = dict["baselineAdjustment"]
    numberOfLines       = dict["numberOfLines"]
    minimumScaleFactor  = dict["minimumScaleFactor"]
    enabled             = dict["enabled"].flatMap { $0 == "YES" }
    highlighted         = dict["highlighted"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)

    contentModeDefault = "left"
    userInteractionEnabledDefault = false
    
    type = ElementType.UILabel
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    if baselineAdjustment != baselineAdjustment { temp.append("baselineAdjustment") }
    temp.append("numberOfLines")
    temp.append("minimumScaleFactor")
    temp.append("enabled")
    temp.append("highlighted")
    if textAlignment != textAlignmentDefault { temp.append("textAlignment") }

    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
    temp = temp.filter { $0 != "isOpaque" }
    return temp
  }
  
//  public override var initString: String {
//    return super.initString
//  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)
    if let text = text {
      if objC {
        string += "_"
      }
      string += "\(userLabel).text = "
      if objC {
        string += "@"
      }
      string += "\"\(text)\""
      if objC {
        string += ";"
      }
      string += "\n"
    }
    if let horizontalHuggingPriority = horizontalHuggingPriority, horizontalHuggingPriority != horizontalHuggingPriorityDefault {
      if objC {
        string += "[_\(userLabel) setContentHuggingPriority:\(horizontalHuggingPriority) forOrientation:NSLayoutConstraintOrientationHorizontal];\n"
      } else {
        string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), for: .horizontal)\n"
      }
    }
    if let font = font {
      if font.codeString() != "UIFont.systemFont(ofSize: 17)" { // Default
        string += "    \(userLabel).font = \(font.codeString)\n"
      }
    }
    if let lineBreakMode = lineBreakMode, lineBreakMode != lineBreakModeDefault {
      string += "    "
      if objC {
        string += "_"
      }
      string += "\(userLabel).lineBreakMode = "
      if !objC {
        string += "."
      }
      string += lineBreakMode.codeString(objC: objC)
      if objC {
        string += ";"
      }
      string += "\n"
    }
    return string
  }
  
  override func configureForObjC() {
    super.configureForObjC()
    
    if let textAlignment = textAlignment {
      self.textAlignment = "NSTextAlignment\(textAlignment.capitalizeFirst)"
    }
  }
}
