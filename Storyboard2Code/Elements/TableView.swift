//  Created by dasdom on 25.06.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class TableView: ScrollView {
  
  let separatorStyle: String?
  var separatorStyleDefault = "default"
  let sectionIndexMinimumDisplayRowCount: String?
  let allowsSelectionDuringEditing: Bool?
  let allowsMultipleSelection: Bool?
  let rowHeight: String?
  let sectionHeaderHeight: String?
  let sectionFooterHeight: String?
  
  required init(dict: [String : String]) {
    
    separatorStyle = dict["separatorStyle"]
    sectionIndexMinimumDisplayRowCount = dict["sectionIndexMinimumDisplayRowCount"]
    allowsSelectionDuringEditing = dict["allowsSelectionDuringEditing"].flatMap { $0 == "YES" }
    allowsMultipleSelection = dict["allowsMultipleSelection"].flatMap { $0 == "YES" }
    rowHeight = dict["rowHeight"]
    sectionHeaderHeight = dict["sectionHeaderHeight"]
    sectionFooterHeight = dict["sectionFooterHeight"]

    print(dict)
    super.init(dict: dict)

    alwaysBounceVerticalDefault = true
    
    type = ElementType.UITableView
  }
  
//  override var selfNameForMessaging: String {
//    return ""
//  }
  
  var swiftCodeString: String {
    var outputString = "import UIKit\n\n"
    outputString += "class \(userLabel.capitalizeFirst): UITableView {\n\n"
    outputString += "override init(frame: CGRect, style: UITableViewStyle) {\n\n"
    
    outputString += "super.init(frame: frame, style: style)\n"
    
    outputString += reflectedSetup
    
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkText()") { // Defaults
        outputString += "\(color.key) = \(color.codeString)\n"
      }
    }
    
    outputString += "}\n\n"

    outputString += "required init?(coder aDecoder: NSCoder) {\nfatalError(\"init(coder:) has not been implemented\")\n}"
    return outputString
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    if separatorStyle != separatorStyleDefault { temp.append("separatorStyle") }
    temp.append("sectionIndexMinimumDisplayRowCount")
    temp.append("allowsSelectionDuringEditing")
    temp.append("allowsMultipleSelection")
    temp.append("rowHeight")
    temp.append("sectionHeaderHeight")
    temp.append("sectionFooterHeight")
    print(temp)
    return temp
  }
}
