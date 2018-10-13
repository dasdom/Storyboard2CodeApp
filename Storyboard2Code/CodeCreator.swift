//  Created by dasdom on 30.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct CodeCreator {
  
  var fileRepresentations: [FileRepresentation] = []
  
  mutating func generateFileRepresentations(from data: Data) {
    
    let parser = XMLParser(data: data)
    let parserDelegate = StoryboardXMLParserDelegate()
    parser.delegate = parserDelegate
    
    parser.parse()
    
    fileRepresentations = parserDelegate.fileRepresentations
  }
  
  func swiftCodeStrings() -> [String: String] {
    
    var outputDict: [String: String] = [:]
    
    for fileRepresentation in fileRepresentations {
      outputDict[fileRepresentation.mainView.userLabel.capitalizeFirst] = fileRepresentation.swiftCodeString
    }
    
    return outputDict
  }
  
  func objCImplementationCodeStrings() -> [String: String] {
    var outputDict: [String: String] = [:]
    
    for fileRepresentation in fileRepresentations {
      let key = "\(fileRepresentation.mainView.userLabel.capitalizeFirst).m"
      outputDict[key] = fileRepresentation.objCImplementationCode()
    }
    
    return outputDict
  }
  
  func objCHeaderCodeStrings() -> [String: String] {
    var outputDict: [String: String] = [:]
    
    for fileRepresentation in fileRepresentations {
      let key = "\(fileRepresentation.mainView.userLabel.capitalizeFirst).h"
      outputDict[key] = fileRepresentation.objCHeaderCode()
    }
    
    return outputDict
  }
}
