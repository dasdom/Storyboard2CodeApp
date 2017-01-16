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
    
    for fileRepresentation in parserDelegate.fileRepresentations {
      outputDict[fileRepresentation.mainView.userLabel.capitalizeFirst] = fileRepresentation.swiftCodeString
    }
    
//    for tableView in parserDelegate.tableViews {
//      outputDict[tableView.userLabel.capitalizeFirst] = tableView.swiftCodeString
//    }
    
    return outputDict
  }
}
