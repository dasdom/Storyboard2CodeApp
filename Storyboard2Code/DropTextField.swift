//  Created by dasdom on 28.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Cocoa

class DropTextField: NSTextField {
  
  private let fileTypes = ["storyboard"]
  private var fileTypeSupported = false
  @objc dynamic var droppedFilePath: String?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    registerForDraggedTypes(convertToNSPasteboardPasteboardTypeArray([NSPasteboard.PasteboardType.fileURL.rawValue, NSPasteboard.PasteboardType.URL.rawValue]))
  }
  
  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    if checkExtension(sender) {
      fileTypeSupported = true
      return .copy
    } else {
      fileTypeSupported = false
      return NSDragOperation()
    }
  }
  
  override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
    if fileTypeSupported {
      return .copy
    } else {
      return NSDragOperation()
    }
  }
  
  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
    if let board = sender.draggingPasteboard.propertyList(forType: convertToNSPasteboardPasteboardType(NSPasteboard.PasteboardType.fileURL.rawValue)) as? [String], let path = board.first {
      droppedFilePath = path
      return true
    }
    return false
  }
  
  func checkExtension(_ drag: NSDraggingInfo) -> Bool {
    if let board = drag.draggingPasteboard.propertyList(forType: convertToNSPasteboardPasteboardType(NSPasteboard.PasteboardType.fileURL.rawValue)) as? [String], let path = board.first {
      let url = URL(fileURLWithPath: path)
      let fileExtension = url.pathExtension.lowercased()
      return fileTypes.contains(fileExtension)
    }
    return false
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSPasteboardPasteboardTypeArray(_ input: [String]) -> [NSPasteboard.PasteboardType] {
	return input.map { key in NSPasteboard.PasteboardType(key) }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSPasteboardPasteboardType(_ input: String) -> NSPasteboard.PasteboardType {
	return NSPasteboard.PasteboardType(rawValue: input)
}
