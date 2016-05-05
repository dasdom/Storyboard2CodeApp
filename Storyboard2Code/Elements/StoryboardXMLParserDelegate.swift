//
//  StoryboardXMLParserDelegate.swift
//  Storyboard2Code
//
//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class StoryboardXMLParserDelegate: NSObject, NSXMLParserDelegate {
  var viewDict: [String:View] = [:]
  var tempViews: [View] = []
  var mainView: View?
  var viewController: ViewController?
  var constraints: [Constraint] = []
  var controllerConstraints: [Constraint] = []
  var color: Color?
  var font: Font?
  var currentState: ButtonState?
  var currentText: String?
  var viewMargins: Set<String> = []
  var layoutGuides: [LayoutGuide] = []
  var currentSegmentedControl: SegmentedControl?
  
  func addView(view: View) {
    if let lastView = tempViews.last where lastView !== mainView {
      view.superViewName = lastView.userLabel
    }
    viewDict[view.id] = view
    tempViews.append(view)
  }
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
    switch elementName {
    case "viewController":
      viewController = ViewController(dict: attributeDict)
    case "view":
      let view = View(dict: attributeDict)
      if mainView == nil {
        view.isMainView = true
        mainView = view
      }
      addView(view)
    case "label":
      let label = Label(dict: attributeDict)
      addView(label)
    case "textField":
      let textField = TextField(dict: attributeDict)
      addView(textField)
    case "button":
      let button = Button(dict: attributeDict)
      addView(button)
    case "segmentedControl":
      currentSegmentedControl = SegmentedControl(dict: attributeDict)
    case "segment":
      currentSegmentedControl?.segmentTitles.append(attributeDict["title"]!)
    case "slider":
      addView(Slider(dict: attributeDict))
    case "color":
      let color = Color(dict: attributeDict)
      if currentState != nil {
        currentState?.titleColor = color
      } else {
        //        print(tempViews.last, attributeDict)
        tempViews.last?.colors.append(color)
      }
    case "fontDescription":
      font = Font(dict: attributeDict)
      tempViews.last?.font = font
    case "constraint":
      var constraintAttributeDict = attributeDict
      if constraintAttributeDict["firstItem"] == nil
        && (constraintAttributeDict["firstAttribute"] == "width"
          || constraintAttributeDict["firstAttribute"] == "height")
      {
        constraintAttributeDict["firstItem"] = tempViews.last?.id
      }
      let constraint = Constraint(dict: constraintAttributeDict)
      constraints.append(constraint)
    case "state":
      currentState = ButtonState(dict: attributeDict)
    case "viewControllerLayoutGuide":
      layoutGuides.append(LayoutGuide(dict: attributeDict))
    case "string":
      currentText = ""
    default:
      //      print("start: \(elementName)")
      break
    }
    
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    currentText? += string
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    switch elementName {
    case "label", "textField", "view", "button", "slider":
      tempViews.popLast()
    case "state":
      if let button = tempViews.last as? Button {
        button.states.append(currentState!)
        currentState = nil
      } else {
        fatalError("not supported yet")
      }
    case "segmentedControl":
      if let segmentedControl = currentSegmentedControl {
        addView(segmentedControl)
      }
      currentSegmentedControl = nil
    case "string":
      if let label = tempViews.last as? Label {
        label.text = currentText?.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
      } else {
        fatalError("not supported yet")
      }
    default:
      //      print("end: \(elementName)")
      break
    }
  }
  
  func parserDidEndDocument(parser: NSXMLParser) {
    constraints = constraints.map {
      var constraint = $0
      let firstItemName: String?
      
      if let firstItem = constraint.firstItem {
        firstItemName = viewDict[firstItem]?.userLabel
        if firstItemName == mainView?.userLabel {
          constraint.firstItemName = ""
        } else {
          constraint.firstItemName = viewDict[firstItem]?.userLabel
        }
      } else {
        firstItemName = mainView!.userLabel
      }
      var secondItemName: String? = nil
      if let secondItem = constraint.secondItem {
        secondItemName = viewDict[secondItem]?.userLabel
        if secondItemName == mainView?.userLabel {
          constraint.secondItemName = ""
        } else {
          constraint.secondItemName = viewDict[secondItem]?.userLabel
        }
      } else {
        //        print("constraint: \(constraint)")
      }
      
      if constraint.firstAttribute.hasSuffix("Margin") {
        var marginString = "let \(firstItemName!)Margins = "
        if firstItemName != mainView?.userLabel {
          marginString += "\(firstItemName!)."
        }
        marginString += "layoutMarginsGuide\n"
        viewMargins.insert(marginString)
        
        let firstAttribute = constraint.firstAttribute
        constraint.firstAttribute = firstAttribute.substringToIndex(firstAttribute.startIndex.advancedBy(firstAttribute.characters.count-6))
        constraint.firstItemName = "\(firstItemName!)Margins"
      }
      
      if let secondItemName = secondItemName, secondAttribute = constraint.secondAttribute {
        if secondAttribute.hasSuffix("Margin") {
          var marginString = "let \(secondItemName)Margins = "
          if secondItemName != mainView?.userLabel {
            marginString += "\(secondItemName)."
          }
          marginString += "layoutMarginsGuide\n"
          viewMargins.insert(marginString)
          
          if let secondAttribute = constraint.secondAttribute {
            constraint.secondAttribute = secondAttribute.substringToIndex(secondAttribute.startIndex.advancedBy(secondAttribute.characters.count-6))
            constraint.secondItemName = "\(secondItemName)Margins"
          }
        }
      }
      
      
      return constraint
    }
    
    controllerConstraints = constraints.filter {
      for guide in layoutGuides {
        if $0.firstItem == guide.id {
          return true
        }
        if $0.secondItem == guide.id {
          return true
        }
      }
      return false
    }
    
    controllerConstraints = controllerConstraints.map {
      var constraint = $0
      for guide in layoutGuides {
        if constraint.firstItem == guide.id {
          constraint.firstItemName = "\(guide.type)LayoutGuide"
        } else if constraint.secondItem == guide.id {
          constraint.secondItemName = "\(guide.type)LayoutGuide"
        }
      }
      return constraint
    }
    
    constraints = constraints.filter {
      //      return $0.secondItem != layoutGuides.first?.id
      
      for guide in layoutGuides {
        if $0.firstItem == guide.id {
          return false
        }
        if $0.secondItem == guide.id {
          return false
        }
      }
      return true
    }
    
  }
  
}