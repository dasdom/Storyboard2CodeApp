import Foundation

public struct ViewController: AttributeCreatable {
  let id: String
  let userLabel: String
  public let customClass: String
  
  public init(dict: [String : String]) {
    id = dict["id"]!
    userLabel = dict["userLabel"]!
    customClass = dict["customClass"]!
  }
}