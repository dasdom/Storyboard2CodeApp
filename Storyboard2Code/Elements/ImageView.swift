//  Created by dasdom on 30/12/2016.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

final class ImageView: View {
  
  let horizontalHuggingPriority: Int?
  var horizontalHuggingPriorityDefault = 250
  let verticalHuggingPriority: Int?
  var verticalHuggingPriorityDefault = 250
  let imageName: String?
  let highlightedImageName: String?
  
  required init(dict: [String : String]) {
    
    var value = dict["horizontalHuggingPriority"]
    horizontalHuggingPriority = value != nil ? Int(value!) : nil
   
    value = dict["verticalHuggingPriority"]
    verticalHuggingPriority   = value != nil ? Int(value!) : nil
    
    imageName = dict["image"]
    highlightedImageName = dict["highlightedImage"]
    
    super.init(dict: dict)
  
    type = ElementType.UIImageView
  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)
    if let horizontalHuggingPriority = horizontalHuggingPriority, horizontalHuggingPriority != horizontalHuggingPriorityDefault {
      string += "\(userLabel).setContentHuggingPriority(\(horizontalHuggingPriority), for: .horizontal)\n"
    }
    if let verticalHuggingPriority = verticalHuggingPriority, verticalHuggingPriority != verticalHuggingPriorityDefault {
      string += "\(userLabel).setContentHuggingPriority(\(verticalHuggingPriority), for: .vertical)\n"
    }
    if let imageName = imageName {
      string += "\(userLabel).image = UIImage(named: \"\(imageName)\")\n"
    }
    if let highlightedImageName = highlightedImageName {
      string += "\(userLabel).highlightedImage = UIImage(named: \"\(highlightedImageName)\")\n"
    }
    return string
  }
}
