//  Created by dasdom on 25.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

final class StackView : View {

  var arrangedSubviews: [View] = []
  
  override func defaultValues() -> [KeyMapping : String] {
    return [.key("distribution"): "fill"]
  }
  
  override func configuredPropertiesForObjC(from properties: [Property]) -> [Property] {
    
    let configuredProperties = super.configuredPropertiesForObjC(from: properties)
    
    return configuredProperties.map { property -> Property in
      
      switch property.keyMapping {
      case .key("axis"):
        return property.propertyReplacing(value: "UILayoutConstraintAxis\(property.value.capitalizeFirst)")
      case .key("distribution"):
        return property.propertyReplacing(value: "UIStackViewDistribution\(property.value.capitalizeFirst)")
      case .key("alignment"):
        return property.propertyReplacing(value: "UIStackViewAlignment\(property.value.capitalizeFirst)")
      default:
        return property
      }
    }
  }
  
  func addArrangedSubviews(objC: Bool = false) -> String {
    let lines = arrangedSubviews.map({ (view) -> String in
      if objC {
        return "    [_\(userLabel) addArrangedSubview:_\(view.userLabel)];"
      } else {
        return "    \(userLabel).addArrangedSubview(\(view.userLabel))"
      }
    })
    return lines.joined(separator: "\n")
  }
}

