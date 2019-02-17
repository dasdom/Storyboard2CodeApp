import Foundation

/// Class to store everything needed to generate UIView code
class View: AttributeCreatable, ElementCodeGeneratable, CodeGeneratable {
  
  var font: Font? = nil

  var frame: CGRect? = nil
  private(set) var colors: [Color] = []

  let id: String
  let userLabel: String
  private var properties: [Property]
  let elementType: ElementType
  
  /// Used to generate code like `fooView.addSubview(barView)`
  var superViewName: String?
  
  var isMainView: Bool = false
  var isArrangedSubview: Bool = false
  
  func defaultValues() -> [KeyMapping : String] {
    return [:]
  }
  
  init(id: String, elementType: ElementType, userLabel: String, properties: [Property]) {
    self.id = id
    self.elementType = elementType
    self.userLabel = userLabel
    self.properties = properties
  }
  
  required init(dict: [String : String]) {
    
    self.id = "42"
    self.elementType = .view
    self.userLabel = "notImplementedYet"
    self.properties = []
  }
  
  func superInit(objC: Bool = false) -> String {
    if objC {
      return "  self = [super initWithFrame:frame];"
    } else {
      return "    super.init(frame: frame)"
    }
  }
  
  func overrideInit(objC: Bool = false) -> String {
    if objC {
      return "- (instancetype)initWithFrame:(CGRect)frame"
    } else {
      return "  override init(frame: CGRect)"
    }
  }
  
  var viewControllerExtension: String {
    var string = "override func loadView()" + startBlock()
    string += "view = \(userLabel.capitalizeFirst)()" + endBlock()
    return string
  }
  
  func initString(objC: Bool = false) -> String {
    guard isMainView == false else { return "" }
    if objC {
      return "    _\(userLabel) = [[\(elementType.className) alloc] init];\n"
    } else {
      return "    \(userLabel) = \(elementType.className)()\n"
    }
  }
  
  func setupString(objC: Bool = false) -> String {
//    guard isMainView == false else { return "" }
    let properties = objC ? configuredPropertiesForObjC(from: self.properties) : self.properties
    
    var string = ""

    for property in properties {
      if defaultValues()[property.keyMapping] != property.value {
        string += property.code(forMainView: isMainView, objC: objC)
      }
    }
    
    for color in colors {
      if !(color.key == "textColor" && color.codeString() == "UIColor.darkText") { // Defaults
        string += "    "
        if !isMainView {
          string += userLabel + "."
        }
        string += "\(color.key) = \(color.codeString())\n"
      }
    }
    
    return string
  }
  
  func configuredPropertiesForObjC(from properties: [Property]) -> [Property] {
    
    return properties.map { property -> Property in
      
      switch property.keyMapping {
      case .key("contentMode"):
        return property.propertyReplacing(value: "UIViewContentMode\(property.value.capitalizeFirst)")
      case .key("textAlignment"):
        return property.propertyReplacing(value: "NSTextAlignment\(property.value.capitalizeFirst)")
      default:
        return property
      }
      
//      if case KeyMapping.key("contentMode") = property.keyMapping {
//        return property.propertyReplacing(value: "UIViewContentMode\(property.value.capitalizeFirst)")
//      } else {
//        return property
//      }
    }
  }
  
  var selfNameForMessaging: String {
    return isMainView ? "" : "\(self.userLabel)"
  }
  
  func add(color: Color) {
    colors.append(color)
  }
  
  func set(text: String) {
    let config = PropertyConfig(keyMapping: .key("text"), valueFormat: .string)
    if let textProperty = Property(userLabel: userLabel, config: config, attributes: ["text": text]) {
      properties.append(textProperty)
    }
  }
}
