//  Created by dasdom on 10.11.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

struct Builder {
  
  let elementType: ElementType
  let propertyConfigs: [PropertyConfig]
  
  func build(attributes: [String: String]) -> View {
    
    guard let id = attributes["id"] else { fatalError() }
    let properties = propertyConfigs.compactMap { config in
      Property(userLabel: userLabel(from: attributes), config: config, attributes: attributes)
    }
    
    switch elementType {
    case .button:
      let buttonType = attributes["buttonType"]
      return Button(id: id, buttonType: buttonType, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .imageView:
      return ImageView(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .label:
      return Label(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .scrollView:
      return ScrollView(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .segmentedControl:
      return SegmentedControl(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .slider:
      return Slider(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .stackView:
      return StackView(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .textField:
      return TextField(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .tableView:
      return TableView(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .tableViewCell:
      return TableViewCell(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    case .tableViewCellContentView:
      return TableViewCellContentView(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    default:
      return View(id: id, elementType: elementType, userLabel: userLabel(from: attributes), properties: properties)
    }
  }
  
  func userLabel(from dict: [String: String]) -> String {
    var result = ""
    if let userLabel = dict["userLabel"] {
      result = userLabel
    } else if let id = dict["id"] {
      result = "id_" + id.replacingOccurrences(of: "-", with: "")
    } else {
      assert(false, "Missing id should never happen.")
    }
    return result
  }
}

extension Builder {
  static func builder(for elementType: ElementType) -> Builder {
    var tempPropertyConfigs: [PropertyConfig] = []
    switch elementType {
    case .view:
      tempPropertyConfigs = propertyConfigs(for: elementType)
    case .button,
         .label,
         .imageView,
         .scrollView,
         .segmentedControl,
         .stackView,
         .textField,
         .tableView:
      tempPropertyConfigs = propertyConfigs(for: [.view, elementType])
    case .slider:
      tempPropertyConfigs = propertyConfigs(for: [.view, .button, elementType])
    default:
      break
    }
    return Builder(elementType: elementType, propertyConfigs: tempPropertyConfigs)
  }
  
  static func propertyConfigs(for elementType: ElementType) -> [PropertyConfig] {
    return propertyConfigs(for: [elementType])
  }
  
  static func propertyConfigs(for elementTypes: [ElementType]) -> [PropertyConfig] {
    var propertyConfigs: [PropertyConfig] = []
    for elementType in elementTypes {
      switch elementType {
      case .view:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("autoresizesSubviews"), valueFormat: .bool),
          PropertyConfig(keyMapping: .isPrefix("opaque"), valueFormat: .bool),
          PropertyConfig(keyMapping: .mapping("clipsSubviews", "clipsToBounds"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("clearsContextBeforeDrawing"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("userInteractionEnabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("tag"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("contentMode"), valueFormat: .enumCase, defaultValue: "scaleToFill"),
          PropertyConfig(keyMapping: .key("translatesAutoresizingMaskIntoConstraints"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("horizontalHuggingPriority"), valueFormat: .method, mapKeyAndValue: ContentHuggingPriority.mapKeyAndValue),
          PropertyConfig(keyMapping: .key("verticalHuggingPriority"), valueFormat: .method, mapKeyAndValue: ContentHuggingPriority.mapKeyAndValue),
          ])
      case .button:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .isPrefix("enabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .isPrefix("highlighted"), valueFormat: .bool),
          PropertyConfig(keyMapping: .isPrefix("selected"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("contentHorizontalAlignment"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("contentVerticalAlignment"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("reversesTitleShadowWhenHighlighted"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("showsTouchWhenHighlighted"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("adjustsImageWhenHighlighted"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("adjustsImageWhenDisabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .prefix("titleLabel?.", "titleLabel.", "lineBreakMode"), valueFormat: .enumCase, mapValue: LineBreakMode.mapValue),
          ])
      case .label:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("textAlignment"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("lineBreakMode"), valueFormat: .enumCase, mapValue: LineBreakMode.mapValue),
          PropertyConfig(keyMapping: .key("numberOfLines"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("minimumScaleFactor"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("enabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("highlighted"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("text"), valueFormat: .string),
          ])
      case .imageView:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("image"), valueFormat: .raw, mapValue: Image.mapValue),
          PropertyConfig(keyMapping: .key("highlightedImage"), valueFormat: .raw, mapValue: Image.mapValue),
          ])
      case .scrollView:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("directionalLockEnabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("bounces"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("alwaysBounceVertical"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("scrollEnabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("pagingEnabled"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("showsHorizontalScrollIndicator"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("showsVerticalScrollIndicator"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("indicatorStyle"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("delaysContentTouches"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("canCancelContentTouches"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("minimumZoomScale"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("maximumZoomScale"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("bouncesZoom"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("keyboardDismissMode"), valueFormat: .enumCase),
          ])
      case .segmentedControl:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("selectedSegmentIndex"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("momentary"), valueFormat: .bool),
          ])
      case .slider:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("value"), valueFormat: .number),
          PropertyConfig(keyMapping: .mapping("minValue", "minimumValue"), valueFormat: .number),
          PropertyConfig(keyMapping: .mapping("maxValue", "maximumValue"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("continuous"), valueFormat: .bool),
          ])
      case .stackView:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("axis"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("spacing"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("distribution"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("alignment"), valueFormat: .enumCase),
          ])
      case .tableView:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("separatorStyle"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("sectionIndexMinimumDisplayRowCount"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("allowsSelectionDuringEditing"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("allowsMultipleSelection"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("rowHeight"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("sectionHeaderHeight"), valueFormat: .number),
          PropertyConfig(keyMapping: .key("sectionFooterHeight"), valueFormat: .number),
          ])
      case .textField:
        propertyConfigs.append(contentsOf: [
          PropertyConfig(keyMapping: .key("borderStyle"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("placeholder"), valueFormat: .string),
          PropertyConfig(keyMapping: .key("textAlignment"), valueFormat: .enumCase),
          PropertyConfig(keyMapping: .key("clearsOnBeginEditing"), valueFormat: .bool),
          PropertyConfig(keyMapping: .key("clearButtonMode"), valueFormat: .enumCase),
          ])
      default:
        break
      }
    }
    return propertyConfigs
  }
}
