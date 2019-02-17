//  Created by dasdom on 07/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

final class TableViewCell: View {
  
  var style: Style? = nil
//
//  required init(dict: [String : String]) {
//
//    if let styleName = dict[Key.style.rawValue] {
//      style = Style(stringLiteral: styleName)
//    } else {
//      style = nil
//    }
//
//    super.init(dict: dict)
//
////    type = ElementType.UITableViewCell
//    isMainView = true
//  }
//
  override func superInit(objC: Bool = false) -> String {
    if let style = style {
      if objC {
        return "self = [super initWithStyle:\(style.objCString()) reuseIdentifier:reuseIdentifier];"
      } else {
        return "super.init(style: .\(style), reuseIdentifier: reuseIdentifier)"
      }
    } else {
      if objC {
        return "self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];"
      } else {
        return "super.init(style: style, reuseIdentifier: reuseIdentifier)"
      }
    }
  }

  override func overrideInit(objC: Bool = false) -> String {
    if objC {
      return "- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier"
    } else {
      return "override init(style: UITableViewCellStyle, reuseIdentifier: String?)"
    }
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
    
    func objCString() -> String {
      switch self {
      case .default:
        return "UITableViewCellStyleDefault"
      case .value1:
        return "UITableViewCellStyleValue1"
      case .value2:
        return "UITableViewCellStyleValue2"
      case .subtitle:
        return "UITableViewCellStyleSubtitle"
      }
    }
  }
}
