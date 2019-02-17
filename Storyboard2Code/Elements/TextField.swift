import Foundation

final class TextField: View {
//  let contentHorizontalAlignment: String?
//  var contentHorizontalAlignmentDefault = "left"
//  let contentVerticalAlignment: String?
//  var contentVerticalAlignmentDefault = "center"
//  let borderStyle: String?
//  var borderStyleDefault = "none"
//  let placeholder: String?
//  let text: String?
//  let textAlignment: String?
//  var textAlignmentDefault = "natural"
//  let minimumFontSize: Int?
//  let clearsOnBeginEditing: Bool?
//  let clearButtonMode: String?
////  public var autocapitalizationType: String?
//  var autocorrectionType: String?
//  var spellCheckingType: String?
//  var keyboardType: String?
//  var keyboardAppearance: String?
//  var returnKeyType: String?
//  var enablesReturnKeyAutomatically: Bool?
//  var secureTextEntry: Bool?
  var textInputTraits: TextInputTraits?
  
  override func defaultValues() -> [KeyMapping : String] {
    return [.isPrefix("opaque"): "NO",]
  }
  
//  required init(dict: [String : String]) {
//    contentHorizontalAlignment  = dict["contentHorizontalAlignment"]
//    contentVerticalAlignment    = dict["contentVerticalAlignment"]
//    borderStyle                 = dict["borderStyle"]
//    placeholder                 = dict["placeholder"]
//    text                        = dict["text"]
//    textAlignment               = dict["textAlignment"]
//    minimumFontSize             = dict["minimumFontSize"] != nil ? Int(dict["minimumFontSize"]!) : nil
//    clearsOnBeginEditing        = dict["clearsOnBeginEditing"].flatMap { $0 == "YES" }
//    clearButtonMode             = dict["clearButtonMode"]
//
//    super.init(dict: dict)
//
////    clipsSubviewsDefault = true
//
////    type = ElementType.UITextField
//  }
  
//  override func reflectable() -> [String] {
//    var temp = super.reflectable()
//    if contentHorizontalAlignment != contentHorizontalAlignmentDefault { temp.append("contentHorizontalAlignment") }
//    if contentVerticalAlignment != contentVerticalAlignmentDefault { temp.append("contentVerticalAlignment") }
//    if borderStyle != borderStyleDefault { temp.append("borderStyle") }
//    if textAlignment != textAlignmentDefault { temp.append("textAlignment") }
//    temp.append("clearsOnBeginEditing")
//    temp.append("clearButtonMode")
////    temp.append("autocapitalizationType")
//    temp.append("autocorrectionType")
//    temp.append("spellCheckingType")
//    temp.append("keyboardType")
//    temp.append("keyboardAppearance")
//    temp.append("returnKeyType")
//    temp.append("enablesReturnKeyAutomatically")
//    temp.append("secureTextEntry")
//    temp.append("minimumFontSize")
//
//    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
//    temp = temp.filter { $0 != "isOpaque" }
//    return temp
//  }
  
//  public override var initString: String {
//    var string = super.initString
//    return string
//  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)
//    if let placeholder = placeholder {
//      string += "\(userLabel).placeholder = \"\(placeholder)\"\n"
//    }
//    if let text = text {
//      string += "\(userLabel).text = \"\(text)\"\n"
//    }
    if let font = font {
      //      if font.codeString != "UIFont.systemFontOfSize(14)" { // Default
      string += "    \(userLabel).font = \(font.codeString())\n"
      //      }
    }
    if let textInputTraits = textInputTraits {
      string += textInputTraits.setupString(for: userLabel)
    }
    return string
  }
}
