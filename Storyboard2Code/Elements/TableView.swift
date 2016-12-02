//  Created by dasdom on 25.06.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class TableView: ScrollView, CodeGeneratable {
  
  let separatorStyle: String?
  var separatorStyleDefault = "default"
  let sectionIndexMinimumDisplayRowCount: String?
  let allowsSelectionDuringEditing: Bool?
  let allowsMultipleSelection: Bool?
  let rowHeight: String?
  let sectionHeaderHeight: String?
  let sectionFooterHeight: String?
  var isEmbeddedTableView = false
  
  required init(dict: [String : String]) {
    
    separatorStyle = dict["separatorStyle"]
    sectionIndexMinimumDisplayRowCount = dict["sectionIndexMinimumDisplayRowCount"]
    allowsSelectionDuringEditing = dict["allowsSelectionDuringEditing"].flatMap { $0 == "YES" }
    allowsMultipleSelection = dict["allowsMultipleSelection"].flatMap { $0 == "YES" }
    rowHeight = dict["rowHeight"]
    sectionHeaderHeight = dict["sectionHeaderHeight"]
    sectionFooterHeight = dict["sectionFooterHeight"]

    super.init(dict: dict)

    alwaysBounceVerticalDefault = true
    
    type = ElementType.UITableView
  }
  
  override var selfNameForMessaging: String {
    return isEmbeddedTableView ? super.selfNameForMessaging : ""
  }
  
  var swiftCodeString: String {
    var outputString = "import UIKit" + newLine(2)
    outputString += classDefinition(name: userLabel.capitalizeFirst, superclass: "UITableView") + startBlock() + newLine()
    outputString += "override init(frame: CGRect, style: UITableViewStyle)" + startBlock() + newLine()
    
    outputString += "super.init(frame: frame, style: style)" + newLine()
    
    outputString += reflectedSetup
    
    for color in colors {
      if !(color.key == "textColor" && color.codeString == "UIColor.darkText()") { // Defaults
        outputString += "\(color.key) = \(color.codeString)\n"
      }
    }
    
    outputString += endBlock() + newLine()

    outputString += initWithCoder()
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
