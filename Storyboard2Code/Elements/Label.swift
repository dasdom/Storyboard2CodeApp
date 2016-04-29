import Foundation

public class Label: View {
  public let horizontalHuggingPriority: Int
  public let verticalHuggingPriority: Int
  public let text: String
  public let lineBreakMode: LineBreakMode
  public let baselineAdjustment: String
  public let adjustsFontSizeToFit: Bool
  
  public required init(dict: [String : String]) {
    horizontalHuggingPriority = Int(dict["horizontalHuggingPriority"]!)!
    verticalHuggingPriority = Int(dict["verticalHuggingPriority"]!)!
    text = dict["text"]!
    lineBreakMode = LineBreakMode(rawValue: dict["lineBreakMode"]!)!
    baselineAdjustment = dict["baselineAdjustment"]!
    adjustsFontSizeToFit = dict["adjustsFontSizeToFit"] == "YES"
    
    super.init(dict: dict)
    
    type = ElementType.UILabel
  }
  
  public override var initString: String {
    var string = super.initString
    string += "\(userLabel).text = \"\(text)\"\n"
    string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), forAxis: .Horizontal)\n"
    if userInteractionEnabled {
      string += "\(userLabel).userInteractionEnabled = \(userInteractionEnabled)\n"
    }
    if contentMode != "Left" { // Default is Left
      string += "\(userLabel).contentMode = .\(contentMode)\n"
    }
//    for color in colors {
//      if !(color.key == "textColor" && color.codeString == "UIColor.darkTextColor()") { // Defaults
//        string += "\(userLabel).\(color.key) = \(color.codeString)\n"
//      }
//    }
    if let font = font {
      if font.codeString != "UIFont.systemFontOfSize(17)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
      }
    }
    return string
  }
}
