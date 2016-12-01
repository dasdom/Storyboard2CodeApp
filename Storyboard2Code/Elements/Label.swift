import Foundation

public class Label: View {
  public let horizontalHuggingPriority: Int
  public let verticalHuggingPriority: Int
  public var text: String?
  public var textAlignment: String?
  var textAlignmentDefault = "natural"
  public let lineBreakMode: LineBreakMode
  var lineBreakModeDefault = LineBreakMode.ByTruncatingTail
  public let baselineAdjustment: String?
  var baseLineAdjustmentDefault = "alignBaselines"
//  public let adjustsFontSizeToFitWidth: Bool
  public let numberOfLines: String?
  public let minimumScaleFactor: String?
  public let enabled: Bool?
  public let highlighted: Bool?
  
  public required init(dict: [String : String]) {

    horizontalHuggingPriority = Int(dict["horizontalHuggingPriority"]!)!
    verticalHuggingPriority   = Int(dict["verticalHuggingPriority"]!)!
    
    text                = dict["text"]
    textAlignment       = dict["textAlignment"]
    lineBreakMode       = LineBreakMode(rawValue: dict["lineBreakMode"]!)!
    baselineAdjustment  = dict["baselineAdjustment"]
    numberOfLines       = dict["numberOfLines"]
    minimumScaleFactor  = dict["minimumScaleFactor"]
    enabled             = dict["enabled"].flatMap { $0 == "YES" }
    highlighted         = dict["highlighted"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)

    contentModeDefault = "Left"
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
    temp = temp.filter { $0 != "opaque" }
    return temp
  }
  
  public override var initString: String {
    return super.initString
  }
  
  public override var setupString: String {
    var string = super.setupString
    if let text = text {
      string += "\(userLabel).text = \"\(text)\"\n"
    }
    string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), for: .horizontal)\n"
    if let font = font {
      if font.codeString != "UIFont.systemFont(ofSize: 17)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
      }
    }
    if lineBreakMode != lineBreakModeDefault {
      string += "\(userLabel).lineBreakMode = .\(lineBreakMode.codeString)"
    }
    return string
  }
}
