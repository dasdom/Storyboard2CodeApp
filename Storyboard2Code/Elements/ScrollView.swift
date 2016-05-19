//
//  ScrollView.swift
//  Storyboard2Code
//
//  Created by dasdom on 18.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

public class ScrollView: View {
  let directionalLockEnabled: Bool?
  let bounces: Bool?
  let alwaysBounceVertical: Bool?
  let scrollEnabled: Bool?
  let pagingEnabled: Bool?
  let showsHorizontalScrollIndicator: Bool?
  let showsVerticalScrollIndicator: Bool?
  let indicatorStyle: String?
  let delaysContentTouches: Bool?
  let canCancelContentTouches: Bool?
  let minimumZoomScale: String?
  let maximumZoomScale: String?
  let bouncesZoom: Bool?
  let keyboardDismissMode: String?
  
  required public init(dict: [String : String]) {
    directionalLockEnabled = dict["directionalLockEnabled"].flatMap { $0 == "YES" }
    bounces = dict["bounces"].flatMap { $0 == "YES" }
    alwaysBounceVertical = dict["alwaysBounceVertical"].flatMap { $0 == "YES" }
    scrollEnabled = dict["scrollEnabled"].flatMap { $0 == "YES" }
    pagingEnabled = dict["pagingEnabled"].flatMap { $0 == "YES" }
    showsHorizontalScrollIndicator = dict["showsHorizontalScrollIndicator"].flatMap { $0 == "YES" }
    showsVerticalScrollIndicator = dict["showsVerticalScrollIndicator"].flatMap { $0 == "YES" }
    indicatorStyle = dict["indicatorStyle"]?.capitalizeFirst
    delaysContentTouches = dict["delaysContentTouches"].flatMap { $0 == "YES" }
    canCancelContentTouches = dict["canCancelContentTouches"].flatMap { $0 == "YES" }
    minimumZoomScale = dict["minimumZoomScale"]
    maximumZoomScale = dict["maximumZoomScale"]
    bouncesZoom = dict["bouncesZoom"].flatMap { $0 == "YES" }
    keyboardDismissMode = dict["keyboardDismissMode"]?.capitalizeFirst
    
    super.init(dict: dict)
    
    clipsSubviewsDefault = true
    
    type = ElementType.UIScrollView
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
    temp.append("directionalLockEnabled")
    temp.append("bounces")
    temp.append("alwaysBounceVertical")
    temp.append("scrollEnabled")
    temp.append("pagingEnabled")
    temp.append("showsHorizontalScrollIndicator")
    temp.append("showsVerticalScrollIndicator")
    temp.append("indicatorStyle")
    temp.append("delaysContentTouches")
    temp.append("canCancelContentTouches")
    temp.append("minimumZoomScale")
    temp.append("maximumZoomScale")
    temp.append("bouncesZoom")
    temp.append("keyboardDismissMode")
    return temp
  }
}