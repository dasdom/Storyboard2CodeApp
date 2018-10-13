//  Created by dasdom on 13.10.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import Foundation

extension String {
  var trimmed: String {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
}
