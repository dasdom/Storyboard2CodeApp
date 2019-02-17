//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

final class StoryboardXMLParserDelegate: NSObject {
  
  /// views for ids
  var viewDict: [String:View] = [:]
  var tableViewSubviewDict: [String:View] = [:]
  var subviewDict: [String:View] = [:]
  var tempViews: [View] = []
  var mainView: View?
  var viewController: ViewController?
  var tableViewCell: TableViewCell?
  var constraints: [Constraint] = []
  var controllerConstraints: [Constraint] = []
  private var color: Color?
  fileprivate var font: Font?
  fileprivate var currentState: ButtonState?
  fileprivate var currentText: String?
  var viewMargins: Set<ViewMargin> = []
  var layoutGuides: [LayoutGuide] = []
  var safeAreaLayoutGuides: [SafeAreaLayoutGuide] = []
//  private var currentSegmentedControl: SegmentedControl?
  var fileRepresentations: [FileRepresentation] = []
//  var tableViews: [TableView] = []
  
}

// MARK: - XMLParserDelegate
extension StoryboardXMLParserDelegate: XMLParserDelegate {
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {

    if let lastView = tempViews.last as? TableViewCell, let _ = lastView.style  {
      return
    }
    
    if let elementType = ElementType(rawValue: elementName) {
      var view = Builder.builder(for: elementType).build(attributes: attributeDict)
  
//    if let view = Element(rawValue: elementName)?.create(from: attributeDict) {
      if let viewAsTableViewCell = view as? TableViewCell {
        
        if let styleName = attributeDict[TableViewCell.Key.style.rawValue] {
          viewAsTableViewCell.style = TableViewCell.Style(stringLiteral: styleName)
        } else {
          viewAsTableViewCell.style = nil
        }
        
        view = viewAsTableViewCell
        tableViewCell = viewAsTableViewCell
      }

      addView(view)
      if mainView == nil {
        view.isMainView = true
        mainView = view
      }
      
    } else {
      
      switch elementName {
      case "viewController":
        viewController = ViewController(dict: attributeDict)
      case "tableViewController":
        viewController = TableViewController(dict: attributeDict)
      case "tableViewCell":
        tableViewCell = TableViewCell(dict: attributeDict)
        guard let tableViewCell = tableViewCell else { fatalError() }
        addView(tableViewCell)
      case "tableViewCellContentView":
        var mutableAttributeDict = attributeDict
        mutableAttributeDict["userLabel"] = "contentView_of_a_tableviewcell"
        let tableViewCellContentView = TableViewCellContentView(dict: mutableAttributeDict)
//        viewDict[tableViewCellContentView.id] = tableViewCellContentView
        addView(tableViewCellContentView)
      case "segment":
        if let segmentedControl = tempViews.last as? SegmentedControl {
//          segmentedControl.segments.append(Segment(dict: attributeDict))
          segmentedControl.add(segment: Segment(dict: attributeDict))
        }
      case "color":
        let color = Color(dict: attributeDict)
        if currentState != nil {
//          currentState?.titleColor = color
          currentState?.set(titleColor: color)
        } else {
          //        print(tempViews.last, attributeDict)
          tempViews.last?.add(color: color)
        }
      case "fontDescription":
        font = Font(dict: attributeDict)
        tempViews.last?.font = font
      case "constraint":
        var constraintAttributeDict = attributeDict
        let firstAttribute = constraintAttributeDict["firstAttribute"]
        if constraintAttributeDict["firstItem"] == nil && (firstAttribute == "width" || firstAttribute == "height") {
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
      case "textInputTraits":
        if let textField = tempViews.last as? TextField {
          textField.textInputTraits = TextInputTraits(dict: attributeDict)
        }
      case "rect":
        if let xString = attributeDict["x"], let yString = attributeDict["y"], let widthString = attributeDict["width"], let heightString = attributeDict["height"],
          let x = Double(xString), let y = Double(yString), let width = Double(widthString), let height = Double(heightString) {
          
          let rect = CGRect(x: x, y: y, width: width, height: height)
          if attributeDict["key"] == "frame" {
            
            tempViews.last?.frame = rect
          }
        }
      case "viewLayoutGuide":
        if attributeDict["key"] == "safeArea" {
          if let id = attributeDict["id"] {
//            tempViews.last?.safeAreaLayoutGuide = SafeAreaLayoutGuide(id: id)
            safeAreaLayoutGuides.append(SafeAreaLayoutGuide(id: id))
          }
        }
      default:
        //      print("start: \(elementName)")
        break
      }
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    currentText? += string
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    switch elementName {
    case "label", "textField", "view", "button", "segmentedControl", "slider", "tableView", "scrollView", "stackView", "imageView":
      if tempViews.last?.elementType == ElementType(rawValue: elementName) {
        _ = tempViews.popLast()
      }
    case "state":
      if let button = tempViews.last as? Button {
        button.add(state: currentState!)
        currentState = nil
      } else {
        fatalError("not supported yet")
      }
    case "tableViewCellContentView":
      if tempViews.last is TableViewCellContentView {
        _ = tempViews.popLast()
      }
    case "tableViewCell":
      configureConstraints()
      if let tableViewCell = tableViewCell {
        let scene = FileRepresentation(mainView: tableViewCell, viewDict: tableViewSubviewDict, viewMargins: viewMargins, constraints: constraints, viewController: viewController!, controllerConstraints: nil)
        fileRepresentations.append(scene)
       
        if tempViews.last?.elementType == ElementType(rawValue: elementName) {
          _ = tempViews.popLast()
        }
        
        if let lastView = tempViews.last as? TableView {
          lastView.cells.append(tableViewCell)
        }
      }
      
//      viewController = nil
      tableViewCell = nil
      tableViewSubviewDict = [:]
      viewDict.removeAll()
      subviewDict.removeAll()
      viewMargins.removeAll()
      constraints.removeAll()
      controllerConstraints.removeAll()
    case "string":
//      guard let label = tempViews.last as? Label else { fatalError("not supported yet") }
//      label.text = currentText?.replacingOccurrences(of: "\n", with: "\\n")
      assert(false, "Not implemented yet")
    case "scene":
      configureConstraints()
      if let mainView = mainView {
        let scene = FileRepresentation(mainView: mainView, viewDict: subviewDict, viewMargins: viewMargins, constraints: constraints, viewController: viewController!, controllerConstraints: controllerConstraints)
        fileRepresentations.append(scene)
      }
      mainView = nil
      viewDict.removeAll()
      subviewDict.removeAll()
      viewMargins.removeAll()
      constraints.removeAll()
      viewController = nil
      controllerConstraints.removeAll()
      
    default:
      //      print("end: \(elementName)")
      break
    }
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    configureConstraints()
  }
  
}

// MARK: - Helper
extension StoryboardXMLParserDelegate {
  
  /// Sets superViewName and adds the view to collections for later use.
  ///
  /// - Parameter view: the view to be added
  func addView(_ view: View) {
    if let lastView = tempViews.last, lastView !== mainView, !(lastView is TableViewCell) {
      if let stackView = lastView as? StackView {
        view.isArrangedSubview = true
        stackView.arrangedSubviews.append(view)
      } else {
        view.superViewName = lastView.userLabel
      }
    }
    viewDict[view.id] = view
    if !(view is TableViewCell) {
      if tableViewCell != nil {
//        view.superViewName = "contentView"
        tableViewSubviewDict[view.id] = view
      } else {
        subviewDict[view.id] = view
      }
    }
    
    tempViews.append(view)
  }
  
  /// Set item name of constraints and configure them form margins
  ///
  /// - Parameters:
  ///   - input: the constraints to be altered
  ///   - mainUserLabel: the user label of the main view
  ///   - viewNameForId: a closure to get the name of a view from its id
  /// - Returns: constraints with filled in item names
  func constraintsWithReplacedItemName(from input: [Constraint], mainUserLabel: String?, viewNameForId: (String) -> String?) -> [Constraint] {
    
    let constraints = input.map { constraint -> Constraint in
      
      var mutableConstraint: Constraint = constraint

      let firstItemName: String?
      
      if let firstItem = constraint.firstItem {
        firstItemName = viewNameForId(firstItem)
        mutableConstraint.firstItemName = firstItemName
      } else {
        mutableConstraint.firstItemName = mainUserLabel
      }
//      let firstAttribute = constraint.firstAttribute
//      if firstAttribute.hasSuffix("Margin"), let firstItemName = firstItemName  {
//        mutableConstraint.firstItemName = "\(firstItemName)Margins"
//        mutableConstraint.firstAttribute = firstAttribute.substring(to: String.Index(encodedOffset: firstAttribute.count-6))
//      }

      var secondItemName: String? = nil
      
      if let secondItem = constraint.secondItem {
        secondItemName = viewNameForId(secondItem)
        mutableConstraint.secondItemName = secondItemName
      }
//      if let secondAttribute = constraint.secondAttribute, secondAttribute.hasSuffix("Margin")  {
//        mutableConstraint.secondItemName = "\(secondItemName!)Margins"
//        mutableConstraint.secondAttribute = secondAttribute.substring(to: String.Index(encodedOffset: secondAttribute.count-6))
//      }
      return mutableConstraint
    }
    return constraints
  }
  
  func constraintsWithRemovedMarginPostfix(from input: [Constraint], mainUserLabel: String?) -> [Constraint] {
    
    let constraints = input.map { constraint -> Constraint in

      var mutableConstraint: Constraint = constraint
      
      if let _ = constraint.firstItem {
        mutableConstraint.firstItemName = mutableConstraint.firstItemName == mainUserLabel ? "" : mutableConstraint.firstItemName
      }
      
      let firstAttribute = constraint.firstAttribute
      if firstAttribute.hasSuffix("Margin"), let firstItemName = constraint.firstItemName  {
          mutableConstraint.firstItemName = "\(firstItemName)Margins"
        mutableConstraint.firstAttribute = String(firstAttribute[..<String.Index(encodedOffset: firstAttribute.count-6)])
      }
      
      if let _ = constraint.secondItem {
        mutableConstraint.secondItemName = mutableConstraint.secondItemName == mainUserLabel ? "" : mutableConstraint.secondItemName
      }
      
      if let secondAttribute = constraint.secondAttribute, secondAttribute.hasSuffix("Margin"), let secondItemName = constraint.secondItemName {
        mutableConstraint.secondItemName = "\(secondItemName)Margins"
        mutableConstraint.secondAttribute = String(secondAttribute[..<String.Index(encodedOffset: secondAttribute.count-6)])
      }
      
      return mutableConstraint
    }
    return constraints
  }
  
  /// Generate and return view margin strings
  ///
  /// - Parameters:
  ///   - input: the constraints
  ///   - mainUserLabel: the name of the main view
  /// - Returns: set with view margin strings
  func viewMargins(from input: [Constraint], mainUserLabel: String?) -> Set<ViewMargin> {
    
    var marginStrings: Set<ViewMargin> = []
    
//    let marginStringFrom: (String) -> String = { itemName in
//      var string = "let \(itemName)Margins = "
//      if itemName != mainUserLabel {
//        string += "\(itemName)."
//      }
//      string += "layoutMarginsGuide\n"
//      return string
//    }
    
    for constraint in input {
      if constraint.firstAttribute.hasSuffix("Margin"), let firstItemName = constraint.firstItemName  {
        
        marginStrings.insert(ViewMargin(marginPrefix: firstItemName, mainUserLabel: mainUserLabel))
      }
      
      if constraint.secondAttribute?.hasSuffix("Margin") ?? false, let secondItemName = constraint.secondItemName {
        
        marginStrings.insert(ViewMargin(marginPrefix: secondItemName, mainUserLabel: mainUserLabel))

      }
    }
    return marginStrings
  }
  
  
  /// Configure the constraints
  ///
  /// This needs to be done before the constraint code can be generated
  func configureConstraints() {
    
    let mainUserLabel = mainView?.userLabel
    
    constraints = constraintsWithReplacedItemName(from: constraints, mainUserLabel: mainUserLabel, viewNameForId: { id in
      
      var name = viewDict[id]?.userLabel
      for safeAreaLayoutGuide in safeAreaLayoutGuides {
        if safeAreaLayoutGuide.id == id {
          name = "safeAreaLayoutGuide"
          break
        }
      }
      return name
     })
    
    viewMargins = viewMargins(from: constraints, mainUserLabel: mainUserLabel)
    
    constraints = constraintsWithRemovedMarginPostfix(from: constraints, mainUserLabel: mainUserLabel)
    
    controllerConstraints = constraints.filter {
      for guide in layoutGuides {
        if $0.firstItem == guide.id || $0.secondItem == guide.id {
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
      for guide in layoutGuides {
        if $0.firstItem == guide.id || $0.secondItem == guide.id {
          return false
        }
      }
      return true
    }
  }
  
}
