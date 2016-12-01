//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public struct ButtonState: AttributeCreatable, ControlStateCodeGeneratable {
  public let key: String
  public let title: String?
  public var titleColor: Color? = nil
  
  public init(dict: [String : String]) {
    key = dict["key"]!
    title = dict["title"]
  }
  
  public func codeString(_ userLabel: String) -> String {
    var string = ""
    if let title = title {
      string += "\(userLabel).setTitle(\"\(title)\", for: .\(key))\n"
    }
    if let titleColor = titleColor {
      string += "\(userLabel).setTitleColor(\(titleColor.codeString), for: .\(key))\n"
    }
    return string
  }
}
