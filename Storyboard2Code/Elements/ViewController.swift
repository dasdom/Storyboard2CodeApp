import Foundation

public struct ViewController: AttributeCreatable, CodeGeneratable {
  let id: String
//  let userLabel: String
  public let customClass: String
  
  public init(dict: [String : String]) {
    id = dict["id"]!
//    userLabel = dict["userLabel"]!
    if let theClass = dict["customClass"] {
      customClass = theClass
    } else {
      customClass = ""
      assert(false, "You need to set the class of the view controller in the scene.")
    }
  }
  
  func extensionCodeString(for view: View, constraints: [Constraint]) -> String {
    var string = "extension \(customClass)" + startBlock()
    string += "override func loadView()" + startBlock()
    string += "view = \(view.userLabel.capitalizeFirst)()" + endBlock() + newLine(2)
    string += "func setLayoutGuideConstraints()" + startBlock()
    string += "let contentView = view as! \(view.userLabel.capitalizeFirst)" + newLine()
    string += "contentView."
    
    string += constraints.reduce("") { $0 + $1.codeString }
    
    string += "}" + endBlock()
    return string
  }
}
