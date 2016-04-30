//
//  MainWindowController.swift
//  Storyboard2Code
//
//  Created by dasdom on 28.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  @IBOutlet weak var dropTextField: DropTextField!
  @IBOutlet var storyboardTextView: NSTextView!
  @IBOutlet var codeTextView: NSTextView!
  var xmlData: NSData? {
    didSet {
      if let data = xmlData {
//        let codeString = codeStringFrom(XMLdata: data)
        let codeString = CodeCreator().codeStringFrom(XMLdata: data)
        let attributedText = codeTextView.attributedString()
        codeTextView.insertText(codeString, replacementRange: NSMakeRange(0, attributedText.length))
      }
    }
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    dropTextField.addObserver(self, forKeyPath: "droppedFilePath", options: .New, context: nil)
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == "droppedFilePath" {
      guard let path = change?["new"] as? String else { return }
      dropTextField.stringValue = path
      
      guard let data = NSData(contentsOfFile: path),
        dataString = NSString(data: data, encoding: NSUTF8StringEncoding) else { return }
      
      xmlData = data
      
      let attributedText = storyboardTextView.attributedString()
      storyboardTextView.insertText(dataString, replacementRange: NSMakeRange(0, attributedText.length))
    }
  }
  
//  func codeStringFrom(XMLdata data: NSData) -> String {
//    
//    let parser = NSXMLParser(data: data)
//    let parserDelegate = StoryboardXMLParserDelegate()
//    parser.delegate = parserDelegate
//    
//    parser.parse()
//    
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
//    
//    return outputString
//  }
}
