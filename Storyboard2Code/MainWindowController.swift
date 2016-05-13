//
//  MainWindowController.swift
//  Storyboard2Code
//
//  Created by dasdom on 28.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTextFieldDelegate {
  
  @IBOutlet weak var dropTextField: DropTextField!
  @IBOutlet var storyboardTextView: NSTextView!
  @IBOutlet var codeTextView: NSTextView!
  var swiftCodeStrings: [String: String] = [:] {
    didSet {
      var outputString = ""
      for (_, value) in swiftCodeStrings {
        outputString += value
      }
      codeTextView.string = outputString
    }
  }
  var xmlData: NSData? {
    didSet {
      if let data = xmlData {
        swiftCodeStrings = CodeCreator().codeStringsFrom(XMLdata: data)
      }
    }
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    dropTextField.addObserver(self, forKeyPath: "droppedFilePath", options: .New, context: nil)
    
    dropTextField.delegate = self
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
  
  override func controlTextDidChange(obj: NSNotification) {
    if let path = (obj.userInfo?["NSFieldEditor"] as? NSTextView)?.string {
      print(path)
      
      dropTextField.stringValue = path
      
      guard let data = NSData(contentsOfFile: path),
        dataString = NSString(data: data, encoding: NSUTF8StringEncoding) else { return }
      
      xmlData = data
      
      storyboardTextView.string = dataString as String
    }
  }
  
  @IBAction func export(sender: AnyObject) {
    let paths = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true)
    
    for (key, value) in swiftCodeStrings {
      let outputPath = "\(paths.first!)/\(key).swift"
      do {
        try value.writeToFile(outputPath, atomically: true, encoding: NSUTF8StringEncoding)
      } catch NSCocoaError.FileWriteNoPermissionError {
        print("FileWriteNoPermissionError")
      } catch {
        print("error")
      }
    }
  }
  
}
