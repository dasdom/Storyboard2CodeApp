//
//  DropTextField.swift
//  Storyboard2Code
//
//  Created by dasdom on 28.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Cocoa

class DropTextField: NSTextField {
  
  private let fileTypes = ["storyboard"]
  private var fileTypeSupported = false
  dynamic var droppedFilePath: String?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    registerForDraggedTypes([NSFilenamesPboardType, NSURLPboardType])
  }
  
  override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
    if checkExtension(sender) {
      fileTypeSupported = true
      return .Copy
    } else {
      fileTypeSupported = false
      return .None
    }
  }
  
  override func draggingUpdated(sender: NSDraggingInfo) -> NSDragOperation {
    if fileTypeSupported {
      return .Copy
    } else {
      return .None
    }
  }
  
  override func performDragOperation(sender: NSDraggingInfo) -> Bool {
    if let board = sender.draggingPasteboard().propertyListForType(NSFilenamesPboardType) as? [String], path = board.first {
      droppedFilePath = path
      return true
    }
    return false
  }
  
  func checkExtension(drag: NSDraggingInfo) -> Bool {
    if let board = drag.draggingPasteboard().propertyListForType(NSFilenamesPboardType) as? [String], path = board.first {
      let url = NSURL(fileURLWithPath: path)
      if let fileExtension = url.pathExtension?.lowercaseString {
        return fileTypes.contains(fileExtension)
      }
    }
    return false
  }
  
}
