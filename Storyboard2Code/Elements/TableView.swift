//  Created by dasdom on 25.06.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

final class TableView: ScrollView {
  
  var cells: [TableViewCell] = []
  
  required init(dict: [String : String]) {
    
    cells = []
    
    super.init(dict: dict)

  }
  
  override init(id: String, elementType: ElementType, userLabel: String, properties: [Property]) {
    super.init(id: id, elementType: elementType, userLabel: userLabel, properties: properties)
  }
  
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
    
    for color in colors {
      if !(color.key == "textColor" && color.codeString() == "UIColor.darkText()") { // Defaults
        outputString += "\(color.key) = \(color.codeString)\n"
      }
    }
    
    outputString += endBlock() + newLine()

    outputString += initWithCoder()
    return outputString
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
