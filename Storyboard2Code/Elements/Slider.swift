//  Created by dasdom on 29.04.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

final class Slider: View {
  
  override func defaultValues() -> [KeyMapping : String] {
    return [.isPrefix("opaque"): "NO",
            .key("contentMode"): "scaleToFill",
            .key("contentHorizontalAlignment"): "center",
            .key("contentVerticalAlignment"): "center"]
  }
}
