//  Created by dasdom on 18.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

class ScrollView: View {
//  let directionalLockEnabled: Bool?
//  let bounces: Bool?
//  let alwaysBounceVertical: Bool?
//  var alwaysBounceVerticalDefault = false
//  let scrollEnabled: Bool?
//  let pagingEnabled: Bool?
//  let showsHorizontalScrollIndicator: Bool?
//  let showsVerticalScrollIndicator: Bool?
//  let indicatorStyle: String?
//  let delaysContentTouches: Bool?
//  let canCancelContentTouches: Bool?
//  let minimumZoomScale: String?
//  let maximumZoomScale: String?
//  let bouncesZoom: Bool?
//  let keyboardDismissMode: String?
  
//  required init(dict: [String : String]) {
//    let YES: String = "YES"
//    directionalLockEnabled = dict[Key.directionalLockEnabled.rawValue].flatMap { $0 == YES }
//    bounces = dict[Key.bounces.rawValue].flatMap { $0 == YES }
//    alwaysBounceVertical = dict[Key.alwaysBounceVertical.rawValue].flatMap { $0 == YES }
//    scrollEnabled = dict[Key.scrollEnabled.rawValue].flatMap { $0 == YES }
//    pagingEnabled = dict[Key.pagingEnabled.rawValue].flatMap { $0 == YES }
//    showsHorizontalScrollIndicator = dict[Key.showsHorizontalScrollIndicator.rawValue].flatMap { $0 == YES }
//    showsVerticalScrollIndicator = dict[Key.showsVerticalScrollIndicator.rawValue].flatMap { $0 == YES }
//    indicatorStyle = dict[Key.indicatorStyle.rawValue]
//    delaysContentTouches = dict[Key.delaysContentTouches.rawValue].flatMap { $0 == YES }
//    canCancelContentTouches = dict[Key.canCancelContentTouches.rawValue].flatMap { $0 == YES }
//    minimumZoomScale = dict[Key.minimumZoomScale.rawValue]
//    maximumZoomScale = dict[Key.maximumZoomScale.rawValue]
//    bouncesZoom = dict[Key.bouncesZoom.rawValue].flatMap { $0 == YES }
//    keyboardDismissMode = dict[Key.keyboardDismissMode.rawValue]
//    
//    super.init(dict: dict)
//    
////    clipsSubviewsDefault = true
//    
////    type = ElementType.UIScrollView
//  }
  
//  override func reflectable() -> [String] {
//    var temp = super.reflectable()
//    temp.append("directionalLockEnabled")
//    temp.append("bounces")
//    if alwaysBounceVertical != alwaysBounceVerticalDefault { temp.append("alwaysBounceVertical") }
//    temp.append("scrollEnabled")
//    temp.append("pagingEnabled")
//    temp.append("showsHorizontalScrollIndicator")
//    temp.append("showsVerticalScrollIndicator")
//    temp.append("indicatorStyle")
//    temp.append("delaysContentTouches")
//    temp.append("canCancelContentTouches")
//    temp.append("minimumZoomScale")
//    temp.append("maximumZoomScale")
//    temp.append("bouncesZoom")
//    temp.append("keyboardDismissMode")
//    
//    /// From the docs: "The opaque property has no effect in system-provided classes such as UIButton, UILabel, UITableViewCell, and so on."
//    temp = temp.filter { $0 != "isOpaque" }
//    
//    return temp
//  }
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
