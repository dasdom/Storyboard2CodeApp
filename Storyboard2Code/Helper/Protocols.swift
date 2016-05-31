import Foundation

/**
 *  Conforming types can be initialized with a [String:String]
 *  dictionary from the XML representation of a storyboard.
 */
public protocol AttributeCreatable {
  init(dict: [String:String])
}

/**
 *  Conforming types can create code strings to be exported into swift files.
 *
 *  Each element that should be convertable from the storyboard representation
 *  to the code representation hast to implement this protocol.
 */
public protocol ElementCodeGeneratable {
  var userLabel: String { get }
  var type: ElementType { get }
  var propertyString: String { get }
  var initString: String { get }
  var setupString: String { get }
  var addToSuperString: String { get }
  var superViewName: String? { get }
  var isMainView: Bool { get set }
  func setup(property: String, value: String, isEnumValue: Bool) -> String
}

public extension ElementCodeGeneratable {
  /// Default implementation of the property declaration string
  var propertyString: String {
    guard isMainView == false else { return "" }
    
    return "let \(userLabel): \(type.rawValue)\n"
  }
  
  /// Default implementation of the addToSuperview string
  var addToSuperString: String {
    guard isMainView == false else { return "" }
    
    var string = ""
    if let superViewName = superViewName {
      string += "\(superViewName)."
    }
    string += "addSubview(\(userLabel))\n"
    return string
  }
  
  /**
   Helper method to make the setup code generation more readable.
   
   - parameter property:    name of the property
   - parameter value:       value of the property
   - parameter isEnumValue: true if a dot should be added before the value
   
   - returns: setup string
   */
  func setup(property: String, value: String, isEnumValue: Bool = false) -> String {
    let dotOrEmpty = isEnumValue ? "." : ""
    return "\(userLabel).\(property) = \(dotOrEmpty)\(value)\n"
  }
}

/**
 *  Conforming types provide attribute code generation.
 */
public protocol AttributeCodeGeneratable {
  var codeString: String { get }
}

/**
 *  Conforming types provide control state code generation.
 */
public protocol ControlStateCodeGeneratable {
  func codeString(userLabel: String) -> String
}

/**
 *  Conforming types provide constraint code generation.
 */
public protocol ConstraintCodeGeneratable {
  var codeString: String { get }
}

/**
 *  Conforming types provide generated code for classes.
 */
public protocol ClassCodeCreatable {
  var swiftCodeString: String { get }
}