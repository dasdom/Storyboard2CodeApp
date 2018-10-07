//  Created by dasdom on 13.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct FileRepresentation: CodeGeneratable {
  let mainView: View
  let viewDict: [String: View]
  let viewMargins: Set<ViewMargin>
  let constraints: [Constraint]
  let viewController: ViewController
  let controllerConstraints: [Constraint]?
  
  var className: String {
    return mainView.userLabel.capitalizeFirst
  }
  
  var swiftCodeString: String {
    var outputString = "import UIKit"
    outputString += newLine(2)
    outputString += classDefinition(name: className, superclass: mainView.type.rawValue)
    outputString += startBlock()
    
    let subviews: [View] = viewDict.values.filter { !$0.isMainView }
    
    outputString += properties(for: subviews) + newLine()
    
    outputString += mainView.overrideInit() + startBlock()
    
    outputString += setup(for: subviews)
    
    outputString += mainView.superInit() + newLine(2)
    
    outputString += setup(for: [mainView])
    
    let addString = addToSuperView(for: subviews)
    outputString += addString.isEmpty ? "" : addString + newLine()
    
    viewMargins.forEach { outputString += $0.codeString() + newLine() }
    
    var constraintsString = ""
    //outputString += "var layoutConstraints = [NSLayoutConstraint]()\n
    constraints.forEach { constraintsString += $0.codeString() }
    
    if constraintsString.count > 0 {
      outputString += "NSLayoutConstraint.activate([\n"
      outputString += constraintsString
      outputString += "])"
    }
    //outputString += "NSLayoutConstraint.activateConstraints(layoutConstraints)\n"
    
    outputString += endBlock() + newLine(2)
    
    outputString += initWithCoder()
    
    outputString += viewController.extensionCodeString(for: mainView, constraints: controllerConstraints)
    
    return outputString
  }
  
  func properties(for subviews: [View]) -> String {
    return subviews.reduce("") { $0 + $1.propertyString() + newLine() }
  }
  
  func setup(for subviews: [View]) -> String {
    return subviews.reduce("") { result, element in
      let elementString = element.initString() + element.setupString()
      return result + (elementString.isEmpty ? "" : elementString + newLine())
    }
  }
  
  func addToSuperView(for subviews: [View]) -> String {
    return subviews.reduce("") { $0 + $1.addToSuperString() + newLine() }
  }
  
}

extension FileRepresentation {
  func objCImplementationCode() -> String {
    var output = "#import \"\(className).h\""
    output += newLine(2)
    output += "@implementation \(className)" + newLine()
    output += mainView.overrideInit(objC: true) + newLine()
    output += mainView.superInit(objC: true) + newLine()
    output += "if (self) {" + newLine()
    output += "}" + newLine()
    output += "return self;" + newLine()
    output += "}" + newLine()
    output += end()
    return output
  }
  
  func objCHeaderCode() -> String {
    var output = "#import <UIKit/UIKit.h>"
    output += newLine(2)
    output += interface(name: mainView.userLabel.capitalizeFirst, superclass: mainView.type.rawValue)
    output += newLine()
    output += end()
    return output
  }
}
