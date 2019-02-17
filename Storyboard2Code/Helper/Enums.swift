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
 - UIImageView:        UIImageView
 - UITableViewCell:    UITableViewCell
 */
//enum ElementType: String {
//  case UIView, UILabel, UITextField, UIButton, UISegmentedControl, UISlider, UIScrollView, UITableView, UIImageView, UITableViewCell, UIStackView
//}

enum Element: String {
  case view, label, textField, button, segmentedControl, slider, scrollView, tableView, imageView, stackView
  
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
    case .imageView: return ImageView(dict: dict)
    case .stackView: return StackView(dict: dict)
    }
  }
}

/**
 * Enum to store a linebreak mode. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
enum LineBreakMode: String {
  case tailTruncation
  case charWrapping
  case clip
  case headTruncation
  case middleTruncation
  
  static var mapValue = { (value: String, objC: Bool) -> String in
    let lineBreakMode = LineBreakMode(rawValue: value)
    return lineBreakMode?.codeString(objC: objC) ?? ""
  }
  
  func codeString(objC: Bool = false) -> String {
    if objC {
      switch self {
      case .tailTruncation: return "NSLineBreakByTruncatingTail"
      case .charWrapping: return "NSLineBreakByCharWrapping"
      case .clip: return "NSLineBreakByClipping"
      case .headTruncation: return "NSLineBreakByTruncatingHead"
      case .middleTruncation: return "NSLineBreakByTruncatingMiddle"
      }
    } else {
      switch self {
      case .tailTruncation: return "byTruncatingTail"
      case .charWrapping: return "byCharWrapping"
      case .clip: return "byClipping"
      case .headTruncation: return "byTruncatingHead"
      case .middleTruncation: return "byTruncatingMiddle"
      }
    }
  }
}

/**
 * Enum to store the keyboard appearance. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
enum KeyboardAppearance: String {
  case dark = "alert"
  
  var codeString: String {
    switch self {
    case .dark: return "dark"
    }
  }
}

/**
 * Enum to store the content mode. It is needed because the string
 * in the storyboard is different to the string to be used in code.
 */
enum ContentMode: String {
  case ScaleAspectFill = "scaleToFill"
}
