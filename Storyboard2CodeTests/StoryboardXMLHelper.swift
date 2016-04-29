//
//  StoryboardXMLHelper.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class StoryboardXMLHelper: NSObject, NSXMLParserDelegate {
  
  var attributedDictionary: [NSObject: AnyObject]?
  var elementName: String?
  
  func attributedDictionary(fromData data: NSData, forElement element: String) -> [String: String]? {
    elementName = element
    
    let parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    
    return attributedDictionary as? [String: String]
  }
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if elementName == self.elementName && attributedDictionary == nil {
      attributedDictionary = attributeDict
      parser.abortParsing()
    }
  }
}