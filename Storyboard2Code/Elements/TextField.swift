import Foundation

public class TextField: View {
  public let contentHorizontalAlignment: String
  public let contentVerticalAlignment: String
  public let borderStyle: String
  public let placeholder: String?
  public let text: String?
  public let textAlignment: String
  public let minimumFontSize: Int
  
  public required init(dict: [String : String]) {
    contentHorizontalAlignment = dict["contentHorizontalAlignment"]!.capitalizeFirst
    contentVerticalAlignment = dict["contentVerticalAlignment"]!.capitalizeFirst
    borderStyle = dict["borderStyle"]!.capitalizeFirst
    placeholder = dict["placeholder"]
    text = dict["text"]
    textAlignment = dict["textAlignment"]!.capitalizeFirst
    minimumFontSize = Int(dict["minimumFontSize"]!)!
    
    super.init(dict: dict)
    
    type = ElementType.UITextField
  }
  
  public override var initString: String {
    var string = super.initString
    if contentMode != "ScaleToFill" { // Default = ScaleToFill
      string += "\(userLabel).contentMode = .\(contentMode)\n"
    }
    if contentHorizontalAlignment != "Left" { // Default = Left
      string += "\(userLabel).contentHorizontalAlignment = .\(contentHorizontalAlignment)\n"
    }
    if contentVerticalAlignment != "Center" { // Default = Center
      string += "\(userLabel).contentVerticalAlignment = .\(contentVerticalAlignment)\n"
    }
//    if borderStyle != "RoundedRect" {
      string += "\(userLabel).borderStyle = .\(borderStyle)\n"
//    }
    if let placeholder = placeholder {
      string += "\(userLabel).placeholder = \"\(placeholder)\"\n"
    }
    if let text = text {
      string += "\(userLabel).text = \"\(text)\"\n"
    }
    if textAlignment != "Natural" { // Default = Natural
      string += "\(userLabel).textAlignment = .\(textAlignment)\n"
    }
    if minimumFontSize != 17 { // Default = 17
      string += "\(userLabel).minimumFontSize = \(minimumFontSize)\n"
    }
//    for color in colors {
//      string += "\(userLabel).\(color.key) = \(color.codeString)\n"
//    }
    if let font = font {
//      if font.codeString != "UIFont.systemFontOfSize(14)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
//      }
    }
    return string
  }
}