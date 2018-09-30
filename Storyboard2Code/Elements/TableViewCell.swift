//  Created by dasdom on 07/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

final class TableViewCell: View {
  
  let style: Style?
  
  required init(dict: [String : String]) {
    
    if let styleName = dict[Key.style.rawValue] {
      style = Style(stringLiteral: styleName)
    } else {
      style = nil
    }
    
    super.init(dict: dict)
    
    type = ElementType.UITableViewCell
    isMainView = true
  }
  
  override var superInit: String {
    if let style = style {
      return "super.init(style: .\(style), reuseIdentifier: reuseIdentifier)"
    } else {
      return "super.init(style: style, reuseIdentifier: reuseIdentifier)"
    }
  }
  
  override var overrideInit: String {
    return "override init(style: UITableViewCellStyle, reuseIdentifier: String?)"
  }
  
  override var viewControllerExtension: String {
    return ""
  }
}

extension TableViewCell {
  enum Key: String {
    case style
  }
  
  enum Style: ExpressibleByStringLiteral {
    case `default`
    case value1
    case value2
    case subtitle
    
    typealias StringLiteralType = String
    init(stringLiteral value: TableViewCell.Style.StringLiteralType) {
      switch value {
      case "IBUITableViewCellStyleValue1":
        self = .value1
      case "IBUITableViewCellStyleValue2":
        self = .value2
      case "IBUITableViewCellStyleSubtitle":
        self = .subtitle
      default:
        self = .default
      }
    }
  }
}
