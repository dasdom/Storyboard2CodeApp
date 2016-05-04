import Foundation

public class Label: View {
  public let horizontalHuggingPriority: Int
  public let verticalHuggingPriority: Int
  public let text: String?
  public let lineBreakMode: LineBreakMode
  public let baselineAdjustment: String?
//  public let adjustsFontSizeToFitWidth: Bool
  public let numberOfLines: String?
  public let minimumScaleFactor: String?
  
  public required init(dict: [String : String]) {
    var tempReflectable: [String] = []

    horizontalHuggingPriority = Int(dict["horizontalHuggingPriority"]!)!
    verticalHuggingPriority = Int(dict["verticalHuggingPriority"]!)!
    
    var label = "text"
    text = dict["text"]
    if text != nil { tempReflectable.append(label) }
    
    lineBreakMode = LineBreakMode(rawValue: dict["lineBreakMode"]!)!
    
    label = "baselineAdjustment"
    baselineAdjustment = dict["baselineAdjustment"]
    if baselineAdjustment != nil { tempReflectable.append(label) }
    
    label = "numberOfLines"
    numberOfLines = dict["numberOfLines"]
    if numberOfLines != nil { tempReflectable.append(label) }
    
    label = "minimumScaleFactor"
    minimumScaleFactor = dict["minimumScaleFactor"]
    if minimumScaleFactor != nil {
      tempReflectable.append(label)
      
//      adjustsFontSizeToFitWidth = true
//      tempReflectable.append("adjustsFontSizeToFitWidth")
//    } else {
//      adjustsFontSizeToFitWidth = false
    }
    
    super.init(dict: dict)
    super.reflectable += tempReflectable

    contentModeDefault = "Left"
    
    type = ElementType.UILabel
  }
  
  public override var initString: String {
    return super.initString
  }
  
  public override var setupString: String {
    var string = super.setupString
//    if let text = text {
//      string += "\(userLabel).text = \"\(text)\"\n"
//    }
    string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), forAxis: .Horizontal)\n"
//    if let userInteractionEnabled = userInteractionEnabled {
//      string += "\(userLabel).userInteractionEnabled = \(userInteractionEnabled)\n"
//    }
    if let font = font {
      if font.codeString != "UIFont.systemFontOfSize(17)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
      }
    }
    string += "\(userLabel).lineBreakMode = .\(lineBreakMode.codeString)"
//    if let numberOfLines = numberOfLines {
//      string += "\(userLabel).numberOfLines = \(numberOfLines)"
//    }
    return string
  }
}
