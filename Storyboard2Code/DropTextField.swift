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
    register(forDraggedTypes: [NSFilenamesPboardType, NSURLPboardType])
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
    if let board = sender.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? [String], path = board.first {
      droppedFilePath = path
      return true
    }
    return false
  }
  
  func checkExtension(_ drag: NSDraggingInfo) -> Bool {
    if let board = drag.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? [String], path = board.first {
      let url = URL(fileURLWithPath: path)
      if let fileExtension = url.pathExtension?.lowercased() {
        return fileTypes.contains(fileExtension)
      }
    }
    return false
  }
}
