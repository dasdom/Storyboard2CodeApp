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
 - UITableView:        UITableView
 */
public enum ElementType: String {
  case UIView, UILabel, UITextField, UIButton, UISegmentedControl, UISlider, UIScrollView, UITableView
}

public enum Element: String {
  case view, label, textField, button, segmentedControl, slider, scrollView, tableView
  
  func create(from dict: [String:String]) -> View {
    switch self {
    case .view: return View(dict: dict)
    case .label: return Label(dict: dict)
    case .textField: return TextField(dict: dict)
    case .button: return Button(dict: dict)
    case .segmentedControl: return SegmentedControl(dict: dict)
    case .slider: return Slider(dict: dict)
    case .scrollView: return ScrollView(dict: dict)
    case .tableView: return TableView(dict: dict)
    }
  }
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
    case .ByTruncatingTail: return "byTruncatingTail"
    case .ByCharWrapping: return "byCharWrapping"
    case .ByClipping: return "byClipping"
    case .ByTruncatingHead: return "byTruncatingHead"
    case .ByTruncatingMiddle: return "byTruncatingMiddle"
    }
  }
}

/**
 * Enum to store the keyboard appearance. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
public enum KeyboardAppearance: String {
  case dark = "alert"
  
  public var codeString: String {
    switch self {
    case .dark: return "dark"
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
