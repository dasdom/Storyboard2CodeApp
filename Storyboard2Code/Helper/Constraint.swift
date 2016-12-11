import Foundation

/**
 *  Struct to store everything needed to create code for constraints.
 */
public struct Constraint: AttributeCreatable, ConstraintCodeGeneratable {
  public let firstItem: String?
  public var firstAttribute: String
  public let id: String
  public let secondItem: String?
  public var secondAttribute: String?
  public let multiplier: String?
  public let constant: String?
//  public var mainViewName: String? = nil
  public var firstItemName: String? = nil
  public var secondItemName: String? = nil
  
  /**
   Init with dictionary from an attributesDict from the 
   storyboard xml.
   
   - parameter dict: attributes dictionary
   
   - returns: initialized instance
   */
  public init(dict: [String : String]) {
    firstItem = dict[Key.firstItem.rawValue]
    firstAttribute = dict[Key.firstAttribute.rawValue]!
    id = dict[Key.id.rawValue]!
    secondItem = dict[Key.secondItem.rawValue]
    secondAttribute = dict[Key.secondAttribute.rawValue]
    multiplier = dict[Key.multiplier.rawValue]
    constant = dict[Key.constant.rawValue]
  }
  
  /// The string to generate code.
  public var codeString: String {
//    guard let firstItemName = firstItemName else { fatalError() }
    
//    var string = "layoutConstraints.append(\(firstItemName)"
    var string = ""
    if let firstItemName = firstItemName {
      string += firstItemName
    }
    if (firstItemName?.characters.count ?? 0) > 0 {
      string += "."
    }
    if firstAttribute == "baseline" {
      string += "first\(firstAttribute.capitalizeFirst)"
    } else {
      string += firstAttribute
    }
    string += "Anchor.constraint(equalTo"
    if let secondItemName = secondItemName, let secondAttribute = secondAttribute {
      string += ": \(secondItemName)"
      if secondItemName.characters.count > 0 {
        string += "."
      }
      if secondAttribute == "baseline" {
        string += "first\(secondAttribute.capitalizeFirst)"
      } else {
        string += secondAttribute
      }
      string += "Anchor"
    } else if secondItem != nil {
//      print(string)
      print(self)
      fatalError()
    } else {
      string += "Constant: "
    }
    if let multiplier = multiplier {
      string += ", multiplier: \(multiplier)"
    }
    if let constant = constant {
      if let _ = secondItemName {
        string += ", constant: "
      }
      string += constant
    }
    string += ").isActive = true\n"
//    string += "))\n"
    return string
  }
}

extension Constraint {
  fileprivate enum Key: String {
    case firstItem, firstAttribute, id
    case secondItem, secondAttribute, multiplier
    case constant
  }
}
