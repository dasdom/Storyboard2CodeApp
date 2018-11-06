//  Created by dasdom on 28.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTextFieldDelegate {
  
  @IBOutlet weak var dropTextField: DropTextField!
  @IBOutlet var storyboardTextView: NSTextView!
  @IBOutlet var codeTextView: NSTextView!
  @IBOutlet var objCButton: NSButton!
  @IBOutlet var objCCheckButton: NSButton!
  var codeCreator = CodeCreator()
  var objC = false
  
  var swiftCodeStrings: [String: String] = [:] {
    didSet {
      var outputString = ""
      for (_, value) in swiftCodeStrings {
        outputString += value
      }
      codeTextView.string = outputString
    }
  }
  var objCImplementationCodeStrings: [String: String] = [:] {
    didSet {var outputString = ""
      for (_, value) in objCImplementationCodeStrings {
        outputString += value
      }
      codeTextView.string = outputString
    }
  }
  var objCHeaderCodeStrings: [String: String] = [:]
  
  var xmlData: Data? {
    didSet {
      if let data = xmlData {
        codeCreator.generateFileRepresentations(from: data)
        updateUI()
      }
    }
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    dropTextField.addObserver(self, forKeyPath: "droppedFilePath", options: .new, context: nil)
    
    dropTextField.delegate = self
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
  
    if keyPath == "droppedFilePath" {
      guard let path = change?[.newKey] as? String else { return }
      dropTextField.stringValue = path
      
      guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
      
      xmlData = data
      
      storyboardTextView.string = dataString as String
    }
  }
  
  func controlTextDidChange(_ obj: Notification) {
    if let path = ((obj as NSNotification).userInfo?["NSFieldEditor"] as? NSTextView)?.string {
      print(path)
      
      dropTextField.stringValue = path
      
      guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
      
      xmlData = data
      
      storyboardTextView.string = dataString as String
    }
  }
  
  func updateUI() {
    if objC {
      objCImplementationCodeStrings = codeCreator.objCImplementationCodeStrings()
      objCHeaderCodeStrings = codeCreator.objCHeaderCodeStrings()
    } else {
      swiftCodeStrings = codeCreator.swiftCodeStrings()
    }
  }
  
  @IBAction func export(_ sender: AnyObject) {
    let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
    
    if !objC {
      for (key, value) in swiftCodeStrings {
        let outputPath = "\(paths.first!)/\(key).swift"
        do {
          try value.write(toFile: outputPath, atomically: true, encoding: String.Encoding.utf8)
        } catch CocoaError.fileWriteNoPermission {
          print("FileWriteNoPermissionError")
        } catch {
          print("error")
        }
      }
    } else {
      for (key, value) in objCHeaderCodeStrings {
        let outputPath = "\(paths.first!)/\(key)"
        do {
          try value.write(toFile: outputPath, atomically: true, encoding: String.Encoding.utf8)
        } catch CocoaError.fileWriteNoPermission {
          print("FileWriteNoPermissionError")
        } catch {
          print("error")
        }
      }
      for (key, value) in objCImplementationCodeStrings {
        let outputPath = "\(paths.first!)/\(key)"
        do {
          try value.write(toFile: outputPath, atomically: true, encoding: String.Encoding.utf8)
        } catch CocoaError.fileWriteNoPermission {
          print("FileWriteNoPermissionError")
        } catch {
          print("error")
        }
      }
    }
  }
  
  @IBAction func objCCheckButtonChanged(_ sender: NSButton) {
    
    objC = sender.state == NSControl.StateValue.on
    updateUI()
  }
}
