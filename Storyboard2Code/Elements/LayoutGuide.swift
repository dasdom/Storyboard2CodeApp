import Foundation

public struct LayoutGuide: AttributeCreatable {
  public let type: String
  public let id: String
  
  public init(dict: [String : String]) {
    type = dict[Key.type.rawValue]!
    id = dict[Key.id.rawValue]!
  }
}

extension LayoutGuide {
  fileprivate enum Key: String {
    case type, id
  }
}
