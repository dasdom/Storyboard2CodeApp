import UIKit

let elementName = "label"
var attributes = ["contentMode": "left", "horizontalHuggingPriority": "251", "verticalHuggingPriority": "251", "text": "Please log in", "id": "jKT-D6-stw", "userLabel": "label"]

enum ValueFormat {
  case string
  case number
  case enumCase
  case bool
  
  func code(for raw: String) -> String {
    switch self {
    case .string:
      return "\"\(raw)\""
    case .number:
      return raw
    case .enumCase:
      return ".\(raw)"
    case .bool:
      return raw == "YES" ? "true" : "false"
    }
  }
}

struct PropertyConfig {
  let key: String
  let valueFormat: ValueFormat
  let prefix: String = ""
}

struct Property {
  let userLabel: String
  let key: String
  let value: String
  let valueFormat: ValueFormat
//  let prefix: String = ""
  
  init(userLabel: String, config: PropertyConfig, attributes: [String: String]) {
    self.userLabel = userLabel
    self.key = config.key
    guard let value = attributes[config.key] else { fatalError() }
    self.value = value
    valueFormat = config.valueFormat
  }
  
  func code() -> String {
    return "\(userLabel).\(key) = " + valueFormat.code(for: value)
  }
}

class View {
  let id: String
  let userLabel: String
  let properties: [Property]
  let elementType: ElementType
  
  init(id: String, elementType: ElementType, userLabel: String, properties: [Property]) {
    self.id = id
    self.elementType = elementType
    self.userLabel = userLabel
    self.properties = properties
  }
  
  func initCode() -> String {
    return "let \(userLabel) = \(elementType.className)()"
  }
}

struct Builder {
  
  var propertyConfigs: [PropertyConfig]
  
   func build(elementType: ElementType, attributes: [String: String]) -> View {
   
    guard let id = attributes["id"] else { fatalError() }
    let properties = propertyConfigs.compactMap { config in
      Property(userLabel: userLabel(from: attributes), config: config, attributes: attributes)
    }
    
    return View(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
   }
  
  func userLabel(from dict: [String: String]) -> String {
    var result = ""
    if let userLabel = dict["userLabel"] {
      result = userLabel
    } else if let id = dict["id"] {
      result = "id_" + id.replacingOccurrences(of: "-", with: "")
    } else {
      assert(false, "Missing id should never happen.")
    }
    return result
  }
}

enum ElementType: String {
  case label
  
  var className: String {
    switch self {
    case .label:
      return "UILabel"
    }
  }
}

if let elementType = ElementType(rawValue: elementName) {
  let labelBuilder = Builder(propertyConfigs: [PropertyConfig(key: "contentMode", valueFormat: .enumCase),
                                               PropertyConfig(key: "text", valueFormat: .string)])
  let view = labelBuilder.build(elementType: elementType, attributes: attributes)
  print(view.initCode())
  
  for property in view.properties {
    print(property.code())
  }
}




