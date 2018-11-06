import Foundation

/**
 *  Conforming types can be initialized with a [String:String]
 *  dictionary from the XML representation of a storyboard.
 */
protocol AttributeCreatable {
  init(dict: [String:String])
}

/**
 *  Conforming types can create code strings to be exported into swift files.
 *
 *  Each element that should be convertable from the storyboard representation
 *  to the code representation hast to implement this protocol.
 */
protocol ElementCodeGeneratable {
  var userLabel: String { get }
  var type: ElementType { get }
  func propertyString(objC: Bool) -> String
  func initString(objC: Bool) -> String
  func setupString(objC: Bool) -> String
  func addToSuperString(objC: Bool) -> String
  var superViewName: String? { get }
  var isMainView: Bool { get set }
  var isArrangedSubview: Bool { get set }

  func setup(_ property: String, value: String, isEnumValue: Bool, objC: Bool) -> String
}

extension ElementCodeGeneratable {
  /// Default implementation of the property declaration string
  func propertyString(objC: Bool = false) -> String {
    guard !isMainView else { return "" }
    guard userLabel != "contentView_of_a_tableviewcell" else { return "" }
    
    if objC {
      return "@property (nonatomic) \(type.rawValue) *\(userLabel);"
    } else {
      return "  let \(userLabel): \(type.rawValue)"
    }
  }
  
  /// Default implementation of the addToSuperview string
  func addToSuperString(objC: Bool = false) -> String {
    guard isMainView == false && isArrangedSubview == false else { return "" }
    
    var string = "    "
    if let superViewName = superViewName {
      switch (objC, superViewName) {
      case (true, "contentView_of_a_tableviewcell"):
        string += "[self.contentView "
      case (true, _):
        string += "[\(superViewName) "
      case (false, "contentView_of_a_tableviewcell"):
        string += "self.contentView."
      case (false, _):
        string += "\(superViewName)."
      }
    }
    if objC {
      if string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count < 1 {
        string += "[self "
      }
      string += "addSubview:_\(userLabel)];"
    } else {
      string += "addSubview(\(userLabel))"
    }
    return string
  }
  
  /**
   Helper method to make the setup code generation more readable.
   
   - parameter property:    name of the property
   - parameter value:       value of the property
   - parameter isEnumValue: true if a dot should be added before the value
   
   - returns: setup string
   */
  func setup(_ property: String, value: String, isEnumValue: Bool = false, objC: Bool = false) -> String {
    let dotOrEmpty = isEnumValue ? "." : ""
    var result = "    "
    if userLabel.count > 0 {
      if objC {
        result += "_"
      }
      result += "\(userLabel)."
    }
    result += "\(property) = \(dotOrEmpty)\(value)"
    if objC {
      result += ";"
    }
    result += "\n"
    return result
  }
  
}

protocol Reflectable {
  func reflectable() -> [String]
  func stringFromChild(target: String, label: String?, value: Any, reflectable: [String], objC: Bool) -> String
}

extension Reflectable {
  func stringFromChild(target: String, label: String?, value: Any, reflectable: [String], objC: Bool = false) -> String {
    
    guard let label = label, reflectable.contains(label), "\(value)" != "nil" else {
      return ""
    }
    
    let optionalMirror = Mirror(reflecting: value)
    if optionalMirror.children.count > 0 {
      for child in optionalMirror.children {
        return stringFromChild(target: target, label: label, value: child.value, reflectable: reflectable, objC: objC)
      }
    } else {
      
      /// add a '.' when the value seems to be an enum value
      let dotOrEmpty: String
      if let stringValue = value as? String, let _ = Float(stringValue) {
        dotOrEmpty = ""
      } else if let _ = value as? String, objC == false {
        dotOrEmpty = "."
      } else {
        dotOrEmpty = ""
      }
      var result = "    "
      if target.count > 0 {
        if target == "contentView_of_a_tableviewcell" {
          result += "self.contentView."
        } else {
        if objC {
          result += "_"
        }
        result += "\(target)."
        }
      } else if objC {
        result += "self."
      }
      result += "\(label) = \(dotOrEmpty)\(value)"
      if objC {
        result += ";"
      }
      result += "\n"
      return result
    }
    return ""
  }
}

protocol CodeGeneratable {
  func newLine(_ count: Int) -> String
  func classDefinition(name: String, superclass: String) -> String
  func startBlock() -> String
  func endBlock() -> String
  func initWithCoder() -> String
  func interface(name: String, superclass: String) -> String
  func end() -> String
}

extension CodeGeneratable {
  func newLine(_ count: Int = 1) -> String {
    return Array(repeating: "\n", count: count).joined()
  }
  
  func classDefinition(name: String, superclass: String) -> String {
    return "class \(name): \(superclass)"
  }
  
  func startBlock() -> String {
    return " {\n"
  }
  
  func endBlock() -> String {
    return "\n}"
  }
  
  func initWithCoder() -> String {
    var string = "required init?(coder aDecoder: NSCoder)"
    string += startBlock()
    string += "fatalError(\"init(coder:) has not been implemented\")"
    string += endBlock() + endBlock() + newLine(2)
    return string
  }
  
  func interface(name: String, superclass: String) -> String {
    return "@interface \(name) : \(superclass)"
  }
  
  func end() -> String {
    return "@end"
  }
}

/**
 *  Conforming types provide attribute code generation.
 */
protocol AttributeCodeGeneratable {
  func codeString(objC: Bool) -> String
}

/**
 *  Conforming types provide control state code generation.
 */
protocol ControlStateCodeGeneratable {
  func codeString(_ userLabel: String) -> String
}

/**
 *  Conforming types provide constraint code generation.
 */
protocol ConstraintCodeGeneratable {
  func codeString(useForController: Bool, objC: Bool) -> String
}

/**
 *  Conforming types provide generated code for classes.
 */
protocol ClassCodeCreatable {
  var swiftCodeString: String { get }
}
