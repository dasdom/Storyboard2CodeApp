//
//  DataLoader.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import XCTest

extension XCTestCase {
  func dataFromResource(withName name: String, andType type: String) -> Data? {
    guard let path = Bundle(for: self.dynamicType.self).pathForResource(name, ofType: type) else { return nil }
    return (try? Data(contentsOf: URL(fileURLWithPath: path)))
  }
}
