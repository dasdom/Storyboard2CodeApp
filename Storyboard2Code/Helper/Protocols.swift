import Foundation

public protocol AttributeCreatable {
  init(dict: [String:String])
}

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
  var propertyString: String {
    guard isMainView == false else { return "" }

    return "let \(userLabel): \(type.rawValue)\n"
  }
  
  var addToSuperString: String {
    guard isMainView == false else { return "" }

    var string = ""
    if let superViewName = superViewName {
      string += "\(superViewName)."
    }
    string += "addSubview(\(userLabel))\n"
    return string
  }
  
  func setup(property: String, value: String, isEnumValue: Bool = false) -> String {
    let dotOrEmpty = isEnumValue ? "." : ""
    return "\(userLabel).\(property) = \(dotOrEmpty)\(value)\n"
  }
}

public protocol AttributeCodeGeneratable {
  var codeString: String { get }
}

public protocol ControlStateCodeGeneratable {
  func codeString(userLabel: String) -> String
}

public protocol ConstraintCodeGeneratable {
  var codeString: String { get }
}