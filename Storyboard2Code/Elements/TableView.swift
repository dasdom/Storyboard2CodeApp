//
//  TableView.swift
//  Storyboard2Code
//
//  Created by dasdom on 25.06.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct TableView: AttributeCreatable {
  
  let userLabel: String
  
  init(dict: [String : String]) {
    guard let temp = dict["userLabel"] else { print("userLabel missing in storyboard"); fatalError() }
    userLabel = temp
  }
  
  var swiftCodeString: String {
    var outputString = "import UIKit\n\n"
    outputString += "class \(userLabel.capitalizeFirst): UITableView {\n\n"
    outputString += "override init(frame: CGRect, style: UITableViewStyle) {\n\n"
    
    
    outputString += "required init?(coder aDecoder: NSCoder) {\nfatalError(\"init(coder:) has not been implemented\")\n}"
    return outputString
  }
}
