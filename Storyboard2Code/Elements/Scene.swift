//  Created by dasdom on 13.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct Scene: CodeGeneratable {
  let mainView: View
  let viewDict: [String: View]
  let viewMargins: Set<String>
  let constraints: [Constraint]
  let viewController: ViewController
  let controllerConstraints: [Constraint]
  
  var swiftCodeString: String {
    var outputString = "import UIKit"
    outputString += newLine(2)
    outputString += classDefinition(name: mainView.userLabel.capitalizeFirst, superclass: mainView.type.rawValue)
    outputString += startBlock()
    
    let subviews: [View] = viewDict.values.filter { !$0.isMainView }
    
    outputString += properties(for: subviews) + newLine()
    
    outputString += mainView.overrideInit + startBlock()
    
    outputString += setup(for: subviews)
    
    outputString += mainView.superInit + newLine(2)
//    outputString += "backgroundColor = UIColor.white" + newLine(2)
    
    outputString += setup(for: [mainView])
    
    outputString += addToSuperView(for: subviews) + newLine()
    
    viewMargins.forEach { outputString += $0 + newLine() }
    
    //outputString += "var layoutConstraints = [NSLayoutConstraint]()\n"
    constraints.forEach { outputString += $0.codeString }
    //outputString += "NSLayoutConstraint.activateConstraints(layoutConstraints)\n"
    
    outputString += endBlock() + newLine(2)
    
    outputString += initWithCoder()
    
    outputString += viewController.extensionCodeString(for: mainView, constraints: controllerConstraints)
    
    return outputString
  }
  
  func properties(for subviews: [View]) -> String {
    return subviews.reduce("") { $0 + $1.propertyString + newLine() }
  }
  
  func setup(for subviews: [View]) -> String {
    return subviews.reduce("") { $0 + $1.initString + $1.setupString + newLine() }
  }
  
  func addToSuperView(for subviews: [View]) -> String {
    return subviews.reduce("") { $0 + $1.addToSuperString + newLine() }
  }
  
}
