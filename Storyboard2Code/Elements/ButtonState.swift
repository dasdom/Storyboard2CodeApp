//
//  ButtonState.swift
//  Storyboard2Code
//
//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public struct ButtonState: AttributeCreatable, ControlStateCodeGeneratable {
  public let key: String
  public let title: String?
  public var titleColor: Color? = nil
  
  public init(dict: [String : String]) {
    key = dict["key"]!.capitalizedString
    title = dict["title"]
  }
  
  public func codeString(userLabel: String) -> String {
    var string = ""
    if let title = title {
      string += "\(userLabel).setTitle(\"\(title)\", forState: .\(key))\n"
    }
    if let titleColor = titleColor {
      string += "\(userLabel).setTitleColor(\(titleColor.codeString), forState: .\(key))\n"
    }
    return string
  }
}