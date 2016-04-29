import Foundation

public struct LayoutGuide: AttributeCreatable {
  public let type: String
  public let id: String
  
  public init(dict: [String : String]) {
    type = dict["type"]!
    id = dict["id"]!
  }
}