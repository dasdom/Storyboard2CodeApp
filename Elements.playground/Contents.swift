//: Playground - noun: a place where people can play

import UIKit

let defaultScrollView = UIScrollView()
defaultScrollView.clipsToBounds == true
defaultScrollView.multipleTouchEnabled == true
defaultScrollView.contentMode == .ScaleToFill

let fooScrollView = UIScrollView()
fooScrollView.directionalLockEnabled = true
fooScrollView.bounces = false
fooScrollView.alwaysBounceVertical = true
fooScrollView.scrollEnabled = false
fooScrollView.pagingEnabled = true
fooScrollView.showsHorizontalScrollIndicator = false
fooScrollView.showsVerticalScrollIndicator = false
fooScrollView.indicatorStyle = .Black
fooScrollView.delaysContentTouches = false
fooScrollView.canCancelContentTouches = false
fooScrollView.minimumZoomScale = 5
fooScrollView.maximumZoomScale = 3
fooScrollView.bouncesZoom = false
fooScrollView.keyboardDismissMode = .OnDrag
