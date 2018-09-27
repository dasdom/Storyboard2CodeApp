import Foundation

/// Class to store everything needed to generate UIView code
class View: AttributeCreatable, ElementCodeGeneratable, Reflectable, CodeGeneratable {
  let clipsSubviews: Bool?
  var clipsSubviewsDefault = false
  var font: Font? = nil
  var type = ElementType.UIView
  var rect: CGRect? = nil
  var colors: [Color] = []
  let isOpaque: Bool?
  var opaqueDefault = true
  let userInteractionEnabled: Bool?
  var userInteractionEnabledDefault = true
  let contentMode: String?
  var contentModeDefault = "scaleToFill"
  let translatesAutoresizingMaskIntoConstraints: Bool?
  var translatesAutoresizingMaskIntoConstraintsDefault = true
  let autoresizesSubviews: Bool?
  let clearsContextBeforeDrawing: Bool?
  let tag: Int?
  
  let id: String
  let userLabel: String
  
  /// Used to generate code like `fooView.addSubview(barView)`
  var superViewName: String?
  var isMainView: Bool = false
  
  required init(dict: [String : String]) {
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
    
    guard let userLabelFromDict = dict["userLabel"] else {
      print("userLabel missing in storyboard")
      print("init dict: \(dict)")
      fatalError()
    }
    userLabel = userLabelFromDict
  }
  
  var superInit: String {
    return "super.init(frame: frame)"
  }
  
  var overrideInit: String {
    return "override init(frame: CGRect)"
  }
  
  var viewControllerExtension: String {
    var string = "override func loadView()" + startBlock()
    string += "view = \(userLabel.capitalizeFirst)()" + endBlock()
    return string
  }
  
  var initString: String {
    guard isMainView == false else { return "" }
    return "\(userLabel) = \(type.rawValue)()\n"
  }
  
  var setupString: String {
//    guard isMainView == false else { return "" }
    var string = ""
    string += reflectedSetup
    if let clips = clipsSubviews, clips != clipsSubviewsDefault {
      string += setup("clipsToBounds", value: "\(clips)")
    }
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkText") { // Defaults
        if !isMainView {
          string += userLabel + "."
        }
        string += "\(color.key) = \(color.codeString)\n"
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
