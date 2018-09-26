//  Created by dasdom on 26/12/2016.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct TextInputTraits: AttributeCreatable, Reflectable {
  
  let autocapitalizationType: String?
  let autocorrectionType: String?
  let spellCheckingType: String?
  let keyboardType: String?
  let keyboardAppearance: String?
  let returnKeyType: String?
  let enablesReturnKeyAutomatically: Bool?
  let isSecureTextEntry: Bool?
  
  init(dict: [String : String]) {
    
    autocapitalizationType = dict["autocapitalizationType"]
    autocorrectionType = dict["autocorrectionType"]
    spellCheckingType = dict["spellCheckingType"]
    keyboardType = dict["keyboardType"]
    keyboardAppearance = dict["keyboardAppearance"]
    returnKeyType = dict["returnKeyType"]
    enablesReturnKeyAutomatically = dict["enablesReturnKeyAutomatically"].flatMap { $0 == "YES" }
    isSecureTextEntry = dict["secureTextEntry"].flatMap { $0 == "YES" }
  }
  
  func reflectable() -> [String] {
    var temp: [String] = []
    temp.append("autocapitalizationType")
    temp.append("autocorrectionType")
    temp.append("spellCheckingType")
    temp.append("keyboardType")
    temp.append("keyboardAppearance")
    temp.append("returnKeyType")
    temp.append("enablesReturnKeyAutomatically")
    temp.append("isSecureTextEntry")
    return temp
  }
  
  func setupString(for element: String) -> String {
    
    let reflectableNames = reflectable()
    let mirror = Mirror(reflecting: self)
    var string = ""
    for child in mirror.children {
      string += stringFromChild(target: element, label: child.label, value: child.value, reflectable: reflectableNames)
    }
    return string
  }
}
