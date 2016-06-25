//
//  CodeCreator.swift
//  Storyboard2Code
//
//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct CodeCreator {
  func codeStringsFrom(XMLdata data: Data) -> [String: String] {
    
    let parser = XMLParser(data: data)
    let parserDelegate = StoryboardXMLParserDelegate()
    parser.delegate = parserDelegate
    
    parser.parse()
    
    var outputDict: [String: String] = [:]
    
    for scene in parserDelegate.scenes {
      outputDict[scene.mainView.userLabel.capitalizeFirst] = scene.swiftCodeString
    }
    
//    var outputString = "import UIKit\n\nclass "
//    outputString += (parserDelegate.mainView?.userLabel.capitalizeFirst)!
//    outputString += ": UIView {\n"
//    
//    for view in parserDelegate.viewDict.values {
//      outputString += view.propertyString
//    }
//    
//    outputString += "\noverride init(frame: CGRect) {\n"
//    
//    for view in parserDelegate.viewDict.values {
//      outputString += view.initString
//      outputString += view.setupString
//      outputString += "\n"
//    }
//    
//    outputString += "super.init(frame: frame)\n\n"
//    outputString += "backgroundColor = UIColor.whiteColor()\n\n"
//    
//    for view in parserDelegate.viewDict.values {
//      outputString += view.addToSuperString
//    }
//    
//    outputString += "\n"
//    
//    for string in parserDelegate.viewMargins {
//      outputString += "\(string)\n"
//    }
//    
//    //outputString += "var layoutConstraints = [NSLayoutConstraint]()\n"
//    for constraint in parserDelegate.constraints {
//      outputString += constraint.codeString
//    }
//    //outputString += "NSLayoutConstraint.activateConstraints(layoutConstraints)\n"
//    
//    outputString += "}\n\nconvenience required init(coder aDecoder: NSCoder) {\nself.init()\n}\n\n}"
//    
//    outputString += "\n\nextension \(parserDelegate.viewController!.customClass) {\noverride func loadView() {\nview = \(parserDelegate.mainView!.userLabel.capitalizeFirst)()\n}\n\nfunc setLayoutGuideConstraints() {\nlet contentView = view as! \(parserDelegate.mainView!.userLabel.capitalizeFirst)\ncontentView."
//    
//    for constraint in parserDelegate.controllerConstraints {
//      outputString += constraint.codeString
//    }
//    
//    outputString += "}\n}"
    
    return outputDict
  }
}
