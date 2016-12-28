import Foundation

/// Class to store everything needed to generate UIView code
public class View: AttributeCreatable, ElementCodeGeneratable, Reflectable {
  public let clipsSubviews: Bool?
  var clipsSubviewsDefault = false
  public var font: Font? = nil
  public var type = ElementType.UIView
  public var rect: CGRect? = nil
  public var colors: [Color] = []
  public let isOpaque: Bool?
  var opaqueDefault = true
  public let userInteractionEnabled: Bool?
  var userInteractionEnabledDefault = true
  public let contentMode: String?
  var contentModeDefault = "scaleToFill"
  public let translatesAutoresizingMaskIntoConstraints: Bool?
  var translatesAutoresizingMaskIntoConstraintsDefault = true
  public let autoresizesSubviews: Bool?
  public let clearsContextBeforeDrawing: Bool?
  public let tag: Int?
  
  public let id: String
  public let userLabel: String
  public var superViewName: String?
  public var isMainView: Bool = false
  
  required public init(dict: [String : String]) {
    translatesAutoresizingMaskIntoConstraints = dict["translatesAutoresizingMaskIntoConstraints"].flatMap  { $0 == "YES" }
    isOpaque                    = dict["opaque"].flatMap { $0 == "YES" }
    contentMode                 = dict["contentMode"]
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
  
  public var superInit: String {
    return "super.init(frame: frame)"
  }
  
  public var overrideInit: String {
    return "override init(frame: CGRect)"
  }
  
  public var initString: String {
    guard isMainView == false else { return "" }
    return "\(userLabel) = \(type.rawValue)()\n"
  }
  
  public var setupString: String {
//    guard isMainView == false else { return "" }
    var string = ""
    string += reflectedSetup
    if let clips = clipsSubviews, clips != clipsSubviewsDefault {
      string += setup("clipsToBounds", value: "\(clips)")
    }
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkText") { // Defaults
        string += "\(userLabel).\(color.key) = \(color.codeString)\n"
      }
    }
    return string
  }
  
  /**
   Retuns an array of property names of properties that can be used to
   generate code using reflection.
   
   - returns: array of property names
   */
  func reflectable() -> [String] {
    var temp: [String] = []
    if translatesAutoresizingMaskIntoConstraints != translatesAutoresizingMaskIntoConstraintsDefault { temp.append("translatesAutoresizingMaskIntoConstraints") }
    if isOpaque != opaqueDefault { temp.append("isOpaque") }
    if contentMode != contentModeDefault { temp.append("contentMode") }
    if userInteractionEnabled != userInteractionEnabledDefault { temp.append("userInteractionEnabled") }
    temp.append("autoresizesSubviews")
    temp.append("clearsContextBeforeDrawing")
    temp.append("tag")
    return temp
  }
  
  var selfNameForMessaging: String {
    return isMainView ? "" : "\(self.userLabel)"
  }
  
  var reflectedSetup: String {
    /// Get setup string from child in a mirror
//    func stringFromChild(_ label: String?, value: Any, reflectable: [String]) -> String {
//     
//      if let label = label, reflectable.contains(label) {
//        let optionalMirror = Mirror(reflecting: value)
//        if optionalMirror.children.count > 0 {
//          for child in optionalMirror.children {
//            return stringFromChild(label, value: child.value, reflectable: reflectable)
//          }
//        } else {
//          if "\(value)" == "nil" {
//            return ""
//          }
//          /// add a '.' when the value seems to be an enum value
//          let dotOrEmpty: String
//          if let stringValue = value as? String, let _ = Float(stringValue) {
//            dotOrEmpty = ""
//          } else if let _ = value as? String {
//            dotOrEmpty = "."
//          } else {
//            dotOrEmpty = ""
//          }
//          return "\(self.selfNameForMessaging)\(label) = \(dotOrEmpty)\(value)\n"
//        }
//      }
//      return ""
//    }
    
    let reflectableNames = reflectable()
    let mirror = Mirror(reflecting: self)
    var string = ""
    if let superclassMirror = mirror.superclassMirror {
      if let superSuperClassMirror = superclassMirror.superclassMirror {
        for child in superSuperClassMirror.children {
          string += stringFromChild(target: selfNameForMessaging, label: child.label, value: child.value, reflectable: reflectableNames)
        }
      }
      for child in superclassMirror.children {
        string += stringFromChild(target: selfNameForMessaging, label:child.label, value: child.value, reflectable: reflectableNames)
      }
    }
    for child in mirror.children {
      string += stringFromChild(target: selfNameForMessaging, label:child.label, value: child.value, reflectable: reflectableNames)
    }
    return string
  }
}
