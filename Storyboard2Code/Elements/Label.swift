import Foundation

final class Label: View {
  
  override func defaultValues() -> [KeyMapping : String] {
      return [.isPrefix("opaque"): "NO",
              .key("userInteractionEnabled"): "NO",
              .key("contentMode"): "left",
              .key("horizontalHuggingPriority"): "251",
              .key("verticalHuggingPriority"): "251"]
  }

  var text: String?
}
