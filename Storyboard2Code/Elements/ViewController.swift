import Foundation

public class ViewController: AttributeCreatable, CodeGeneratable {
  let id: String
//  let userLabel: String
  public let customClass: String
  
  public required init(dict: [String : String]) {
    id = dict[Key.id.rawValue]!
//    userLabel = dict["userLabel"]!
    if let theClass = dict[Key.customClass.rawValue] {
      customClass = theClass
    } else {
      customClass = ""
      assert(false, "You need to set the class of the view controller in the scene.")
    }
  }
  
  func extensionCodeString(for view: View, constraints: [Constraint]?) -> String {
    
    var string = ""
    if view.viewControllerExtension.count > 0 {
      string += "extension \(customClass)" + startBlock()
      string += view.viewControllerExtension
    }
    
    if let constraints = constraints, constraints.count > 0 {
      if string.count < 1 {
        string += "extension \(customClass)" + startBlock()
      }
      string += newLine(2)
      string += "func setLayoutGuideConstraints()" + startBlock()
      string += "let contentView = view as! \(view.userLabel.capitalizeFirst)" + newLine()
      string += "contentView."
      
      string += constraints.reduce("") { $0 + $1.codeString(useForController: true) }
      string += "}"
    }
    
    if string.count > 0 {
      string += endBlock()
    }
    
    return string
  }
}

extension ViewController {
  fileprivate enum Key: String {
    case id, customClass
  }
}
