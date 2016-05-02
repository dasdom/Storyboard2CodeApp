import Foundation

public class Label: View {
  public let horizontalHuggingPriority: Int
  public let verticalHuggingPriority: Int
  public let text: String?
  public let lineBreakMode: LineBreakMode
  public let baselineAdjustment: String?
  public let adjustsFontSizeToFit: Bool
  
  public required init(dict: [String : String]) {
    horizontalHuggingPriority = Int(dict["horizontalHuggingPriority"]!)!
    verticalHuggingPriority = Int(dict["verticalHuggingPriority"]!)!
    text = dict["text"]
    lineBreakMode = LineBreakMode(rawValue: dict["lineBreakMode"]!)!
    baselineAdjustment = dict["baselineAdjustment"]
    adjustsFontSizeToFit = dict["adjustsFontSizeToFit"] == "YES"
    
    super.init(dict: dict)
    
    contentModeDefault = "Left"
    
    type = ElementType.UILabel
  }
  
  public override var initString: String {
    return super.initString
  }
  
  public override var setupString: String {
    var string = super.setupString
    if let text = text {
      string += "\(userLabel).text = \"\(text)\"\n"
    }
    string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), forAxis: .Horizontal)\n"
    if let userInteractionEnabled = userInteractionEnabled {
      string += "\(userLabel).userInteractionEnabled = \(userInteractionEnabled)\n"
    }
    if let font = font {
      if font.codeString != "UIFont.systemFontOfSize(17)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
      }
    }
    return string
  }
}
