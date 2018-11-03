import Foundation

/**
 *  Struct to store everything needed to create code for constraints.
 */
struct Constraint: AttributeCreatable, ConstraintCodeGeneratable {
  let firstItem: String?
  var firstAttribute: String
  let id: String
  let secondItem: String?
  var secondAttribute: String?
  let multiplier: String?
  let constant: String?
  var firstItemName: String? = nil
  var secondItemName: String? = nil
  
  /**
   Init with dictionary from an attributesDict from the 
   storyboard xml.
   
   - parameter dict: attributes dictionary
   
   - returns: initialized instance
   */
  init(dict: [String : String]) {
    firstItem = dict[Key.firstItem.rawValue]
    firstAttribute = dict[Key.firstAttribute.rawValue]!
    id = dict[Key.id.rawValue]!
    secondItem = dict[Key.secondItem.rawValue]
    secondAttribute = dict[Key.secondAttribute.rawValue]
    multiplier = dict[Key.multiplier.rawValue]
    constant = dict[Key.constant.rawValue]
  }
  
  func codeString(useForController: Bool = false, objC: Bool = false) -> String {

    var string = "    "
    if !useForController {
      string += "  "
    }
    if objC {
      string += "["
    }

    string += itemName(from: firstItemName, objC: objC)
    
    string += attribute(firstAttribute, objC: objC)
    
    if objC {
      string += " constraintEqualTo"
    } else {
      string += ".constraint(equalTo:"
    }
    
    if let secondItemName = secondItemName, let secondAttribute = secondAttribute {

      if objC {
        string += "Anchor:"
      }
      
      string += itemName(from: secondItemName, objC: objC)
      
      string += attribute(secondAttribute, objC: objC)
      
      
    } else if secondItem != nil {
//      print(string)
      print(self)
      fatalError()
    } else {
      string += "Constant:"
    }
    if let multiplier = multiplier {
      if objC == false {
        string += ","
      }
      string += " multiplier:\(multiplier)"
    }
    if let constant = constant {
      if let _ = secondItemName {
        if objC == false {
          string += ","
        }
        string += " constant:"
      }
      string += constant
    }
    if useForController {
      if objC {
        string += "].active = YES\n"
      } else {
        string += ").isActive = true\n"
      }
    } else {
      if objC {
        string += "]"
      } else {
        string += ")"
      }
      string += ",\n"
    }
    return string
  }
  
  func itemName(from name: String?, objC: Bool) -> String {
    var string = ""
    if let itemName = name {
      if itemName == "contentView_of_a_tableviewcell" {
        if objC {
          string += "self."
        }
        string += "contentView"
      } else {
        if objC, itemName.count > 0, !itemName.hasSuffix("Margins") {
          string += "self."
        }
        string += itemName
      }
      if itemName.count > 0 {
        string += "."
      } else if objC {
        string += "self."
      }
    }
    return string
  }
  
  func attribute(_ attribute: String, objC: Bool) -> String {
    var string = ""
    if attribute == "baseline" {
      string += "first\(attribute.capitalizeFirst)"
    } else {
      string += attribute
    }
    string += "Anchor"
    return string
  }
}

extension Constraint {
  enum Key: String {
    case firstItem, firstAttribute, id
    case secondItem, secondAttribute, multiplier
    case constant
  }
}

//extension Constraint {
//  
//}
