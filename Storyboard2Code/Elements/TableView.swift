//  Created by dasdom on 25.06.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

final class TableView: ScrollView {
  
  let separatorStyle: String?
  var separatorStyleDefault = "default"
  let sectionIndexMinimumDisplayRowCount: String?
  let allowsSelectionDuringEditing: Bool?
  let allowsMultipleSelection: Bool?
  let rowHeight: String?
  let sectionHeaderHeight: String?
  let sectionFooterHeight: String?
  var cells: [TableViewCell]  
//  var isEmbeddedTableView = false
  
  required init(dict: [String : String]) {
    
    separatorStyle = dict["separatorStyle"]
    sectionIndexMinimumDisplayRowCount = dict["sectionIndexMinimumDisplayRowCount"]
    allowsSelectionDuringEditing = dict["allowsSelectionDuringEditing"].flatMap { $0 == "YES" }
    allowsMultipleSelection = dict["allowsMultipleSelection"].flatMap { $0 == "YES" }
    rowHeight = dict["rowHeight"]
    sectionHeaderHeight = dict["sectionHeaderHeight"]
    sectionFooterHeight = dict["sectionFooterHeight"]
    
    cells = []
    
    super.init(dict: dict)

    alwaysBounceVerticalDefault = true
    
    type = ElementType.UITableView
  }
  
//  override var selfNameForMessaging: String {
//    return isEmbeddedTableView ? super.selfNameForMessaging : ""
//  }
  
  public override func superInit(objC: Bool = false) -> String {
    return "super.init(frame: frame, style: style)"
  }
  
  public override func overrideInit(objC: Bool = false) -> String {
    return "override init(frame: CGRect, style: UITableViewStyle) {"
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
  
  override var viewControllerExtension: String {
    var string = "override func loadView()" + startBlock()
    string += "view = \(userLabel.capitalizeFirst)()"
    if cells.count > 0 {
      string += "\n"
      for cell in cells {
        let cellClassName = cell.userLabel.capitalizeFirst
        string += "\ntableView.register(\(cellClassName).self, forCellReuseIdentifier: \"\(cellClassName)\")"
      }
    }
    string += endBlock()
    return string
  }
}
