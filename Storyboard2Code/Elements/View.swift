import Foundation

public class View: AttributeCreatable, ElementCodeGeneratable {
  public let clipsSubviews: Bool
  public var font: Font? = nil
  public var type = ElementType.UIView
  public var rect: CGRect? = nil
  public var colors: [Color] = []
  public let opaque: Bool
  public let userInteractionEnabled: Bool
  public let contentMode: String
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
    
    var string = "\(userLabel) = \(type.rawValue)()\n"
    string += "\(userLabel).translatesAutoresizingMaskIntoConstraints = \(translatesAutoresizingMaskIntoConstraints)\n"
    if clipsSubviews != true { // Default = YES
      string += "\(userLabel).clipsToBounds = \(clipsSubviews)\n"
    }
    if opaque != false { // Default = false
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
