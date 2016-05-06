import Foundation

public class View: AttributeCreatable, ElementCodeGeneratable {
  public let clipsSubviews: Bool?
  var clipsSubviewsDefault = false
  public var font: Font? = nil
  public var type = ElementType.UIView
  public var rect: CGRect? = nil
  public var colors: [Color] = []
  public let opaque: Bool?
  var opaqueDefault = true
  public let userInteractionEnabled: Bool?
  var userInteractionEnabledDefault = true
  public let contentMode: String
  var contentModeDefault = "ScaleToFill"
  public let translatesAutoresizingMaskIntoConstraints: Bool
  public let autoresizesSubviews: Bool?
  public let clearsContextBeforeDrawing: Bool?
  public let tag: Int?
  
  public let id: String
  public let userLabel: String
  public var superViewName: String?
  public var isMainView: Bool = false
  
  required public init(dict: [String : String]) {
    translatesAutoresizingMaskIntoConstraints = dict["translatesAutoresizingMaskIntoConstraints"] == "YES"
    opaque                      = dict["opaque"].flatMap { $0 == "YES" }
    contentMode                 = dict["contentMode"]!.capitalizeFirst
    clipsSubviews               = dict["clipsSubviews"].flatMap { $0 == "YES" }
    userInteractionEnabled      = dict["userInteractionEnabled"].flatMap { $0 == "YES" }
    autoresizesSubviews         = dict["autoresizesSubviews"].flatMap { $0 == "YES" }
    clearsContextBeforeDrawing  = dict["clearsContextBeforeDrawing"].flatMap { $0 == "YES" }
    
    if let tagString = dict["tag"] {
      tag = Int(tagString)
    } else {
      tag = nil
    }
    
    id = dict["id"]!
    
    guard let temp = dict["userLabel"] else { print("userLabel missing in storyboard"); fatalError() }
    userLabel = temp
  }
  
  
  public var initString: String {
    guard isMainView == false else { return "" }
    return "\(userLabel) = \(type.rawValue)()\n"
  }
  
  public var setupString: String {
    guard isMainView == false else { return "" }
    var string = ""
    string += reflectedSetup
    if let clips = clipsSubviews where clips != clipsSubviewsDefault {
      string += setup("clipsToBounds", value: "\(clips)")
    }
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkTextColor()") { // Defaults
        string += "\(userLabel).\(color.key) = \(color.codeString)\n"
      }
    }
    return string
  }
  
  func reflectable() -> [String] {
    var temp: [String] = ["translatesAutoresizingMaskIntoConstraints"]
    if opaque != opaqueDefault { temp.append("opaque") }
    if contentMode != contentModeDefault { temp.append("contentMode") }
    if userInteractionEnabled != userInteractionEnabledDefault { temp.append("userInteractionEnabled") }
    temp.append("autoresizesSubviews")
    temp.append("clearsContextBeforeDrawing")
    temp.append("tag")
    return temp
  }
  
  var reflectedSetup: String {
    /// Get setup string from child in a mirror
    func stringFromChild(label: String?, value: Any, reflectable: [String]) -> String {
     
      if let label = label where reflectable.contains(label) {
        let optionalMirror = Mirror(reflecting: value)
        if optionalMirror.children.count > 0 {
          for child in optionalMirror.children {
            return stringFromChild(label, value: child.value, reflectable: reflectable)
          }
        } else {
          if "\(value)" == "nil" {
            return ""
          }
          /// add a '.' when the value seems to be an enum value
          let dotOrEmpty: String
          if let stringValue = value as? String, _ = Float(stringValue) {
            dotOrEmpty = ""
          } else if let _ = value as? String {
            dotOrEmpty = "."
          } else {
            dotOrEmpty = ""
          }
          return "\(self.userLabel).\(label) = \(dotOrEmpty)\(value)\n"
        }
      }
      return ""
    }
    
    let reflectableNames = reflectable()
    let mirror = Mirror(reflecting: self)
    var string = ""
    if let superclassMirror = mirror.superclassMirror() {
      for child in superclassMirror.children {
        string += stringFromChild(child.label, value: child.value, reflectable: reflectableNames)
      }
    }
    for child in mirror.children {
      string += stringFromChild(child.label, value: child.value, reflectable: reflectableNames)
    }
    return string
  }
}
