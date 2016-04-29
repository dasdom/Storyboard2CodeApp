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
  public let contentMode: String
  var contentModeDefault = "ScaleToFill"
  public let translatesAutoresizingMaskIntoConstraints: Bool
  public let id: String
  public let userLabel: String
  public var superViewName: String?
  public var isMainView: Bool = false
  
  required public init(dict: [String : String]) {
    clipsSubviews = dict["clipsSubviews"] == "YES"
    opaque = dict["opaque"] == "YES"
    userInteractionEnabled = dict["userInteractionEnabled"] == "YES"
    contentMode = dict["contentMode"]!.capitalizeFirst
    translatesAutoresizingMaskIntoConstraints = dict["translatesAutoresizingMaskIntoConstraints"] == "YES"
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
    string += "\(userLabel).translatesAutoresizingMaskIntoConstraints = \(translatesAutoresizingMaskIntoConstraints)\n"
    if contentMode != contentModeDefault {
      string += "\(userLabel).contentMode = .\(contentMode)\n"
    }
    if clipsSubviews != clipsSubviewsDefault {
      string += "\(userLabel).clipsToBounds = \(clipsSubviews)\n"
    }
    if opaque != opaqueDefault {
      string += "\(userLabel).opaque = \(opaque)\n"
    }
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkTextColor()") { // Defaults
        string += "\(userLabel).\(color.key) = \(color.codeString)\n"
      }
    }
    return string
  }
}
