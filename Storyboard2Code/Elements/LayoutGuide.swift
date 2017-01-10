import Foundation

struct LayoutGuide: AttributeCreatable {
  let type: String
  let id: String
  
  init(dict: [String : String]) {
    type = dict[Key.type.rawValue]!
    id = dict[Key.id.rawValue]!
  }
}

extension LayoutGuide {
  fileprivate enum Key: String {
    case type, id
  }
}
