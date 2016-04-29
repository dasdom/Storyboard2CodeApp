//
//  DataLoader.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest

extension XCTestCase {
  func dataFromResource(withName name: String, andType type: String) -> NSData? {
    guard let path = NSBundle(forClass: self.dynamicType.self).pathForResource(name, ofType: type) else { return nil }
    return NSData(contentsOfFile: path)
  }
}