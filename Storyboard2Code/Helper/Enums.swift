import Foundation

/**
 Supported storyboard elements
 
 - UIView:             UIView
 - UILabel:            UILabel
 - UITextField:        UITextField
 - UIButton:           UIButton
 - UISegmentedControl: UISegmentedControl
 - UISlider:           UISlider
 - UIScrollView:       UIScrollView
 */
public enum ElementType: String {
  case UIView, UILabel, UITextField, UIButton, UISegmentedControl, UISlider, UIScrollView
}

/**
 * Enum to store a linebreak mode. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
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

/**
 * Enum to store the keyboard appearance. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
public enum KeyboardAppearance: String {
  case Dark = "alert"
  
  public var codeString: String {
    switch self {
    case .Dark: return "Dark"
    }
  }
}

/**
 * Enum to store the content mode. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
public enum ContentMode: String {
  case ScaleAspectFill = "scaleToFill"
}