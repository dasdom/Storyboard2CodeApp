import Foundation

public struct ViewController: AttributeCreatable {
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
}
