//  Created by dasdom on 18.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class ScrollView: View {

}

extension ScrollView {
  fileprivate enum Key: String {
    case directionalLockEnabled, bounces, alwaysBounceVertical
    case scrollEnabled, pagingEnabled, showsHorizontalScrollIndicator
    case showsVerticalScrollIndicator, indicatorStyle, delaysContentTouches
    case canCancelContentTouches, minimumZoomScale, maximumZoomScale
    case bouncesZoom, keyboardDismissMode
  }
}
