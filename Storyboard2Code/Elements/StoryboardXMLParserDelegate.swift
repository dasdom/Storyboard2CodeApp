//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class StoryboardXMLParserDelegate: NSObject, XMLParserDelegate {
  var viewDict: [String:View] = [:]
  private var tempViews: [View] = []
  var mainView: View?
  var viewController: ViewController?
  var constraints: [Constraint] = []
  var controllerConstraints: [Constraint] = []
  private var color: Color?
  private var font: Font?
  private var currentState: ButtonState?
  private var currentText: String?
  var viewMargins: Set<String> = []
  private var layoutGuides: [LayoutGuide] = []
  private var currentSegmentedControl: SegmentedControl?
  var scenes: [Scene] = []
  var tableViews: [TableView] = []
  
  func addView(_ view: View, addToTempViews: Bool = true) {
    if let lastView = tempViews.last, lastView !== mainView {
      view.superViewName = lastView.userLabel
    }
    viewDict[view.id] = view
    if addToTempViews {
      tempViews.append(view)
    }
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
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
      currentSegmentedControl?.segments.append(Segment(dict: attributeDict))
    case "slider":
      addView(Slider(dict: attributeDict))
    case "color":
      let color = Color(dict: attributeDict)
      if currentState != nil {
        currentState?.titleColor = color
      } else if let currentSegmentedControl = currentSegmentedControl {
        currentSegmentedControl.colors.append(color)
      } else {
//        print(tempViews.last, attributeDict)
        tempViews.last?.colors.append(color)
      }
    case "fontDescription":
      font = Font(dict: attributeDict)
      tempViews.last?.font = font
    case "constraint":
      var constraintAttributeDict = attributeDict
      let firstAttribute = constraintAttributeDict["firstAttribute"]
      if constraintAttributeDict["firstItem"] == nil && (firstAttribute == "width" || firstAttribute == "height") {
        var firstItem = currentSegmentedControl?.id
        if firstItem == nil {
          firstItem = tempViews.last?.id
        }
        constraintAttributeDict["firstItem"] = firstItem
      }
      let constraint = Constraint(dict: constraintAttributeDict)
      constraints.append(constraint)
    case "state":
      currentState = ButtonState(dict: attributeDict)
    case "viewControllerLayoutGuide":
      layoutGuides.append(LayoutGuide(dict: attributeDict))
    case "string":
      currentText = ""
    case "textInputTraits":
      if let textField = tempViews.last as? TextField {
        textField.autocapitalizationType = attributeDict["autocapitalizationType"]
        textField.autocorrectionType = attributeDict["autocorrectionType"]
        textField.spellCheckingType = attributeDict["spellCheckingType"]
        textField.keyboardType = attributeDict["keyboardType"]
        textField.returnKeyType = attributeDict["returnKeyType"]
        textField.enablesReturnKeyAutomatically = attributeDict["enablesReturnKeyAutomatically"].flatMap { $0 == "YES" }
        textField.secureTextEntry = attributeDict["secureTextEntry"].flatMap { $0 == "YES" }
      
        if let keyboardAppearanceString = attributeDict["keyboardAppearance"] {
          textField.keyboardAppearance = KeyboardAppearance(rawValue: keyboardAppearanceString)?.codeString
        }
      }
    case "scrollView":
      let scrollView = ScrollView(dict: attributeDict)
      addView(scrollView)
    case "tableView":
      let tableView = TableView(dict: attributeDict)
      if mainView == nil {      
        tableViews.append(tableView)
        tempViews.append(tableView)
      } else {
        addView(tableView)
        tableView.isEmbeddedTableView = true
      }
    default:
      //      print("start: \(elementName)")
      break
    }
    
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    currentText? += string
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    switch elementName {
    case "label", "textField", "view", "button", "slider", "tableView", "scrollView":
      _ = tempViews.popLast()
    case "state":
      if let button = tempViews.last as? Button {
        button.states.append(currentState!)
        currentState = nil
      } else {
        fatalError("not supported yet")
      }
    case "segmentedControl":
      if let segmentedControl = currentSegmentedControl {
        addView(segmentedControl, addToTempViews: false)
      }
      currentSegmentedControl = nil
    case "string":
      if let label = tempViews.last as? Label {
        label.text = currentText?.replacingOccurrences(of: "\n", with: "\\n")
      } else {
        fatalError("not supported yet")
      }
    case "scene":
      makeConstraintsUsable()
      if let mainView = mainView {
        let scene = Scene(mainView: mainView, viewDict: viewDict, viewMargins: viewMargins, constraints: constraints, viewController: viewController!, controllerConstraints: controllerConstraints)
        scenes.append(scene)
      }
      mainView = nil
      viewDict.removeAll()
      viewMargins.removeAll()
      constraints.removeAll()
      viewController = nil
      controllerConstraints.removeAll()
      
    default:
      //      print("end: \(elementName)")
      break
    }
  }
  
  func makeConstraintsUsable() {
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
        constraint.firstAttribute = firstAttribute.substring(to: firstAttribute.characters.index(firstAttribute.startIndex, offsetBy: firstAttribute.characters.count-6))
        constraint.firstItemName = "\(firstItemName!)Margins"
      }
      
      if let secondItemName = secondItemName, let secondAttribute = constraint.secondAttribute {
        if secondAttribute.hasSuffix("Margin") {
          var marginString = "let \(secondItemName)Margins = "
          if secondItemName != mainView?.userLabel {
            marginString += "\(secondItemName)."
          }
          marginString += "layoutMarginsGuide\n"
          viewMargins.insert(marginString)
          
          if let secondAttribute = constraint.secondAttribute {
            constraint.secondAttribute = secondAttribute.substring(to: secondAttribute.characters.index(secondAttribute.startIndex, offsetBy: secondAttribute.characters.count-6))
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
  
  func parserDidEndDocument(_ parser: XMLParser) {
    makeConstraintsUsable()
    
  }
  
}
