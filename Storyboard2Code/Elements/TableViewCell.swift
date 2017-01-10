//  Created by dasdom on 07/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

final class TableViewCell: View {
  
  required init(dict: [String : String]) {
    
    super.init(dict: dict)
    
    type = ElementType.UITableViewCell
  }
  
  override var superInit: String {
    return "super.init(style: style, reuseIdentifier: reuseIdentifier)"
  }
  
  override var overrideInit: String {
    return "override init(style: UITableViewCellStyle, reuseIdentifier: String?)"
  }
  
  override var viewControllerExtension: String {
    var string = "override func viewDidLoad()" + startBlock()
    string += "super.viewDidLoad()" + newLine(2)
    string += "tableView.register(\(userLabel.capitalizeFirst).self, forCellReuseIdentifier: \"\(userLabel.capitalizeFirst)\")" + endBlock()
    return string
  }
}
