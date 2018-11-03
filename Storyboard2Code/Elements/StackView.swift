//  Created by dasdom on 25.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

final class StackView : View {
  var axis: String?
  var spacing: String?
  var distribution: String?
  var distributionDefault = "fill"
  var alignment: String?
  var alignmentDefault = "fill"

  var arrangedSubviews: [View] = []
  
  required init(dict: [String : String]) {
    
    axis = dict["axis"]
    spacing = dict["spacing"]
    distribution = dict["distribution"]
    alignment = dict["alignment"]
    
    super.init(dict: dict)

    type = ElementType.UIStackView
  }
  
  override func initString(objC: Bool = false) -> String {
    if arrangedSubviews.count < 1 {
      return super.initString(objC: objC)
    }
    
    var initString = "    "
    if objC {
      initString += "_"
    }
    
    initString += "\(userLabel) = "
    if objC {
      initString += "[[\(type.rawValue) alloc] initWithArrangedSubviews:@["
    } else {
      initString += "\(type.rawValue)(arrangedSubviews:["
    }
    
    let arrangedSubviewNames = arrangedSubviews.map { view -> String in
      var name = ""
      if objC {
        name += "_"
      }
      name += view.userLabel
      return name
    }
    initString += arrangedSubviewNames.joined(separator: ", ")
    
    if objC {
      initString += "]];\n"
    } else {
      initString += "])\n"
    }
    
    return initString
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    temp.append("axis")
    temp.append("spacing")
    if distribution != distributionDefault {
      temp.append("distribution")
    }
//    if alignment != alignmentDefault {
      temp.append("alignment")
//    }
    return temp
  }
  
  override func configureForObjC() {
    super.configureForObjC()
    if let axis = axis {
      self.axis = "UILayoutConstraintAxis\(axis.capitalizeFirst)"
    }
    if let distribution = distribution {
      self.distribution = "UIStackViewDistribution\(distribution.capitalizeFirst)"
    }
    if let alignment = alignment {
      self.alignment = "UIStackViewAlignment\(alignment.capitalizeFirst)"
    }
  }
}

