import Foundation

final class TextField: View {
  var textInputTraits: TextInputTraits?
  
  override func defaultValues() -> [KeyMapping : String] {
    return [.isPrefix("opaque"): "NO",
            .key("contentHorizontalAlignment"): "left",
            .key("contentVerticalAlignment"): "center",
            .key("minimumFontSize"): "14",]
  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)

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
