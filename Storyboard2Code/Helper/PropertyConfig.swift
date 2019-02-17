//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct PropertyConfig {
  let keyMapping: KeyMapping
  let valueFormat: ValueFormat
  let defaultValue: String?
  let mapValue: (String, Bool) -> String
  let mapKeyAndValue: ((String, String, Bool) -> String)? // For content hugging and compression

  init(keyMapping: KeyMapping, valueFormat: ValueFormat, defaultValue: String? = nil, mapValue: @escaping (String, Bool) -> String = { value, _ in return value }, mapKeyAndValue: ((String, String, Bool) -> String)? = nil) {
    
    self.keyMapping = keyMapping
    self.valueFormat = valueFormat
    self.defaultValue = defaultValue
    self.mapValue = mapValue
    self.mapKeyAndValue = mapKeyAndValue
  }
}
