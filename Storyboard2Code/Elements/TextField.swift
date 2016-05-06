import Foundation

public class TextField: View {
  public let contentHorizontalAlignment: String
  var contentHorizontalAlignmentDefault = "Left"
  public let contentVerticalAlignment: String
  var contentVerticalAlignmentDefault = "Center"
  public let borderStyle: String
  var borderStyleDefault = "None"
  public let placeholder: String?
  public let text: String?
  public let textAlignment: String
  var textAlignmentDefault = "Natural"
  public let minimumFontSize: Int
  public let clearsOnBeginEditing: Bool?
  public let clearButtonMode: String?
  public var autocapitalizationType: String?
  public var autocorrectionType: String?
  public var spellCheckingType: String?
  public var keyboardType: String?
  public var keyboardAppearance: String?
  public var returnKeyType: String?
  public var enablesReturnKeyAutomatically: Bool?
  public var secureTextEntry: Bool?
  
  public required init(dict: [String : String]) {
    contentHorizontalAlignment  = dict["contentHorizontalAlignment"]!.capitalizeFirst
    contentVerticalAlignment    = dict["contentVerticalAlignment"]!.capitalizeFirst
    borderStyle                 = dict["borderStyle"]!.capitalizeFirst
    placeholder                 = dict["placeholder"]
    text                        = dict["text"]
    textAlignment               = dict["textAlignment"]!.capitalizeFirst
    minimumFontSize             = Int(dict["minimumFontSize"]!)!
    clearsOnBeginEditing        = dict["clearsOnBeginEditing"].flatMap { $0 == "YES" }
    clearButtonMode             = dict["clearButtonMode"]?.capitalizeFirst
    
    super.init(dict: dict)
    clipsSubviewsDefault = true
    
    type = ElementType.UITextField
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    if contentHorizontalAlignment != contentHorizontalAlignmentDefault { temp.append("contentHorizontalAlignment") }
    if contentVerticalAlignment != contentVerticalAlignmentDefault { temp.append("contentVerticalAlignment") }
    if borderStyle != borderStyleDefault { temp.append("borderStyle") }
    if textAlignment != textAlignmentDefault { temp.append("textAlignment") }
    temp.append("clearsOnBeginEditing")
    temp.append("clearButtonMode")
    temp.append("autocapitalizationType")
    temp.append("autocorrectionType")
    temp.append("spellCheckingType")
    temp.append("keyboardType")
    temp.append("keyboardAppearance")
    temp.append("returnKeyType")
    temp.append("enablesReturnKeyAutomatically")
    temp.append("secureTextEntry")
    temp.append("minimumFontSize")
    
    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
    temp = temp.filter { $0 != "opaque" }
    return temp
  }
  
  public override var initString: String {
    var string = super.initString
    if let placeholder = placeholder {
      string += "\(userLabel).placeholder = \"\(placeholder)\"\n"
    }
    if let text = text {
      string += "\(userLabel).text = \"\(text)\"\n"
    }
    if let font = font {
//      if font.codeString != "UIFont.systemFontOfSize(14)" { // Default
        string += "\(userLabel).font = \(font.codeString)\n"
//      }
    }
    return string
  }
}