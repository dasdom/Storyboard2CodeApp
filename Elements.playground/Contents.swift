//: Playground - noun: a place where people can play

import UIKit

let button = UIButton(type: .System)
button.translatesAutoresizingMaskIntoConstraints = false
button.opaque = false
button.clipsToBounds = true

class View {
  let translatesAutoresizingMaskIntoConstraints: Bool
  let id: String
  let userLabel: String
  let contentMode: String
  var contentModeDefault = "ScaleToFill"
  
  var reflectable: [String] = []

  init(contentMode: String) {
    translatesAutoresizingMaskIntoConstraints = false
    reflectable.append("translatesAutoresizingMaskIntoConstraints")
    
    id = "foo"
    userLabel = "bar"
    
    self.contentMode = contentMode
    if contentMode != contentModeDefault { reflectable.append("contentMode") }
  }
  
  var reflectedSetup: String {
    let mirror = Mirror(reflecting: self)
    var string = ""
    for child in mirror.children {
      if let label = child.label where reflectable.contains(label) {
        let dotOrEmpty = child.value is String ? "." : ""
        string += "\(userLabel).\(label) = \(dotOrEmpty)\(child.value)\n"
      }
    }
    return string
  }
}

let view = View(contentMode: "ScaleToFill")
print(view.reflectedSetup)
