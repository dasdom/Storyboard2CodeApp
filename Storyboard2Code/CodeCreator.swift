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
    
    for tableView in parserDelegate.tableViews {
      outputDict[tableView.userLabel.capitalizeFirst] = tableView.swiftCodeString
    }
    
    return outputDict
  }
}
