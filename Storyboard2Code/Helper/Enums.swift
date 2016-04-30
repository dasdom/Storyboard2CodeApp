import Foundation

public enum ElementType: String {
  case UIView, UILabel, UITextField, UIButton, UISegmentedControl, UISlider
}

public enum LineBreakMode: String {
  case ByTruncatingTail = "tailTruncation"
  case ByCharWrapping = "charWrapping"
  case ByClipping = "clip"
  case ByTruncatingHead = "headTruncation"
  case ByTruncatingMiddle = "middleTruncation"
  
  public var codeString: String {
    switch self {
    case .ByTruncatingTail: return "ByTruncatingTail"
    case .ByCharWrapping: return "ByCharWrapping"
    case .ByClipping: return "ByClipping"
    case .ByTruncatingHead: return "ByTruncatingHead"
    case .ByTruncatingMiddle: return "ByTruncatingMiddle"
    }
  }
  
}

public enum ContentMode: String {
  case ScaleAspectFill = "scaleToFill"
}