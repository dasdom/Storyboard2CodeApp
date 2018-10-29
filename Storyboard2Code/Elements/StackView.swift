//  Created by dasdom on 25.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

final class StackView : View {
  var axis: String?
  
  var arrangedSubviews: [View] = []
  
  required init(dict: [String : String]) {
    
    axis = dict["axis"]
    
    super.init(dict: dict)

    type = ElementType.UIStackView
  }
  
  override func initString(objC: Bool = false) -> String {
    if arrangedSubviews.count < 1 {
      return super.initString(objC: objC)
    }
    
    var initString = ""
    
    initString += "    \(userLabel) = \(type.rawValue)(arrangedSubviews: ["
    
    let arrangedSubviewNames = arrangedSubviews.map { view in
      return view.userLabel
    }
    initString += arrangedSubviewNames.joined(separator: ", ")
    
    initString += "])\n"

    return initString
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    temp.append("axis")
    return temp
  }
  
  override func configureForObjC() {
    super.configureForObjC()
  }
}

