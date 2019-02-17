//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct Property {
  let userLabel: String
  let keyMapping: KeyMapping
  let value: String
  let valueFormat: ValueFormat
  let defaultValue: String?
  //  let prefix: String = ""
  let mapValue: (String, Bool) -> String
  let mapKeyAndValue: ((String, String, Bool) -> String)? // For content hugging and compression

  func propertyReplacing(value newValue: String) -> Property {
    return Property(userLabel: userLabel, keyMapping: keyMapping, value: newValue, valueFormat: valueFormat, mapValue: mapValue, mapKeyAndValue: mapKeyAndValue)
  }
  
  init?(userLabel: String, config: PropertyConfig, attributes: [String: String]) {
    self.userLabel = userLabel
    keyMapping = config.keyMapping
    guard let value = attributes[config.keyMapping.key] else { return nil }
    self.value = value
    valueFormat = config.valueFormat
    defaultValue = config.defaultValue
    mapValue = config.mapValue
    mapKeyAndValue = config.mapKeyAndValue
  }
  
  private init(userLabel: String,
               keyMapping: KeyMapping,
               value: String,
               valueFormat: ValueFormat,
               defaultValue: String? = nil,
               mapValue: @escaping (String, Bool) -> String,
               mapKeyAndValue: ((String, String, Bool) -> String)?) {
    
    self.userLabel = userLabel
    self.keyMapping = keyMapping
    self.value = value
    self.valueFormat = valueFormat
    self.defaultValue = defaultValue
    self.mapValue = mapValue
    self.mapKeyAndValue = mapKeyAndValue
  }
  
  func code(forMainView: Bool, objC: Bool = false) -> String {
    
    if let defaultValue = defaultValue, defaultValue == value {
      return ""
    }
    
    var code = ""
    if objC {
      if case .method = valueFormat {
        code += "["
      }
      if forMainView {
        code += "self."
      } else {
        code += "_"
      }
    }
    if !forMainView {
      code += "\(userLabel)"
      if case .method = valueFormat, objC {
        code += " "
      } else {
        code += "."
      }
    }
    if let mapKeyAndValue = mapKeyAndValue {
      code += mapKeyAndValue(keyMapping.key, value, objC)
    } else {
      code += "\(keyMapping.code(objC: objC)) = " + valueFormat.code(for: self.mapValue(value, objC), objC: objC)
    }
    if objC { code += ";" }
    code += "\n"
    return code
  }
  
  
}
