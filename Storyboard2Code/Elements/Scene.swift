//
//  Scene.swift
//  Storyboard2Code
//
//  Created by dasdom on 13.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct Scene {
  let mainView: View
  let viewDict: [String: View]
  let viewMargins: Set<String>
  let constraints: [Constraint]
  let viewController: ViewController
  let controllerConstraints: [Constraint]
  
  var swiftCodeString: String {
    var outputString = "import UIKit\n\nclass "
    outputString += (mainView.userLabel.capitalizeFirst)
    outputString += ": UIView {\n"
    
    for view in viewDict.values {
      outputString += view.propertyString
    }
    
    outputString += "\noverride init(frame: CGRect) {\n"
    
    for view in viewDict.values {
      outputString += view.initString
      outputString += view.setupString
      outputString += "\n"
    }
    
    outputString += "super.init(frame: frame)\n\n"
    outputString += "backgroundColor = UIColor.white()\n\n"
    
    for view in viewDict.values {
      outputString += view.addToSuperString
    }
    
    outputString += "\n"
    
    for string in viewMargins {
      outputString += "\(string)\n"
    }
    
    //outputString += "var layoutConstraints = [NSLayoutConstraint]()\n"
    for constraint in constraints {
      outputString += constraint.codeString
    }
    //outputString += "NSLayoutConstraint.activateConstraints(layoutConstraints)\n"
    
    outputString += "}\n\nconvenience required init(coder aDecoder: NSCoder) {\nself.init()\n}\n\n}"
    
    outputString += "\n\nextension \(viewController.customClass) {\noverride func loadView() {\nview = \(mainView.userLabel.capitalizeFirst)()\n}\n\nfunc setLayoutGuideConstraints() {\nlet contentView = view as! \(mainView.userLabel.capitalizeFirst)\ncontentView."
    
    for constraint in controllerConstraints {
      outputString += constraint.codeString
    }
    
    outputString += "}\n}"
    
    return outputString
  }
}
