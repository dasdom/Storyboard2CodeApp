//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

enum ElementType: String {
  case view, label, textField, button, segmentedControl, slider, scrollView, tableView, imageView, tableViewCell, tableViewCellContentView, stackView
  
  var className: String {
    switch self {
    case .label:
      return "UILabel"
    case .view:
      return "UIView"
    case .textField:
      return "UITextField"
    case .button:
      return "UIButton"
    case .segmentedControl:
      return "UISegmentedControl"
    case .slider:
      return "UISlider"
    case .scrollView:
      return "UIScrollView"
    case .tableView:
      return "UITableView"
    case .imageView:
      return "UIImageView"
    case .tableViewCell:
      return "UITableViewCell"
    case .tableViewCellContentView:
      return "UIView"
    case .stackView:
      return "UIStackView"
    }
  }
}
