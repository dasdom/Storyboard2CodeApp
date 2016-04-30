import Foundation

public class View: AttributeCreatable, ElementCodeGeneratable {
  public let clipsSubviews: Bool
  var clipsSubviewsDefault = true
  public var font: Font? = nil
  public var type = ElementType.UIView
  public var rect: CGRect? = nil
  public var colors: [Color] = []
  public let opaque: Bool
  var opaqueDefault = false
  public let userInteractionEnabled: Bool
  var userInteractionEnabledDefault = true
  public let contentMode: String
  var contentModeDefault = "ScaleToFill"
  public let translatesAutoresizingMaskIntoConstraints: Bool
  public let id: String
  public let userLabel: String
  public var superViewName: String?
  public var isMainView: Bool = false
  
  var reflectable: [String] = []
  
  required public init(dict: [String : String]) {
    var label = "translatesAutoresizingMaskIntoConstraints"
    translatesAutoresizingMaskIntoConstraints = dict[label] == "YES"
    reflectable.append(label)
   
    label = "opaque"
    opaque = dict[label] == "YES"
    if opaque != opaqueDefault { reflectable.append(label) }

    label = "contentMode"
    contentMode = dict[label]!.capitalizeFirst
    if contentMode != contentModeDefault { reflectable.append(label) }

    label = "clipsSubviews"
    clipsSubviews = dict[label] == "YES"
    if clipsSubviews != clipsSubviewsDefault { reflectable.append(label) }
    
    label = "userInteractionEnabled"
    userInteractionEnabled = dict[label] == "YES"
    if userInteractionEnabled != userInteractionEnabledDefault { reflectable.append(label) }
    
    id = dict["id"]!
    
    guard let temp = dict["userLabel"] else { print("userLabel missing in storyboard"); fatalError() }
    userLabel = temp
  }
  
  public var initString: String {
    guard isMainView == false else { return "" }
    return "\(userLabel) = \(type.rawValue)()\n"
  }
  
  public var setupString: String {
    var string = ""
    string += reflectedSetup
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkTextColor()") { // Defaults
        string += "\(userLabel).\(color.key) = \(color.codeString)\n"
      }
    }
    return string
  }
  
  var reflectedSetup: String {
    /// Get setup string from child in a mirror
    func stringFromChild(label: String?, value: Any) -> String {
      if let label = label where self.reflectable.contains(label) {
        let optionalMirror = Mirror(reflecting: value)
        if optionalMirror.children.count > 0 {
          for child in optionalMirror.children {
            return stringFromChild(label, value: child.value)
          }
        } else {
          let dotOrEmpty = value is String ? "." : ""
          return "\(self.userLabel).\(label) = \(dotOrEmpty)\(value)\n"
        }
      }
      return ""
    }
    
    let mirror = Mirror(reflecting: self)
    var string = ""
    if let superclassMirror = mirror.superclassMirror() {
      for child in superclassMirror.children {
        string += stringFromChild(child.label, value: child.value)
      }
    }
    for child in mirror.children {
      string += stringFromChild(child.label, value: child.value)
    }
    return string
  }
}
