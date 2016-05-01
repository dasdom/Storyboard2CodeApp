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
        codeTextView.string = CodeCreator().codeStringFrom(XMLdata: data)
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
      
      storyboardTextView.string = dataString as String
    }
  }
}
