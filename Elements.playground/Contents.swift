//: Playground - noun: a place where people can play

import UIKit

let button = UIButton(type: .System)
button.translatesAutoresizingMaskIntoConstraints = false
button.contentHorizontalAlignment = .Left
button.contentVerticalAlignment = .Top
button.titleLabel?.lineBreakMode = .ByClipping
button.enabled = false
button.highlighted = true
button.selected = true
button.reversesTitleShadowWhenHighlighted = true
button.showsTouchWhenHighlighted = true
button.adjustsImageWhenHighlighted = false
button.adjustsImageWhenDisabled = false
button.setTitleColor(UIColor(red: 1, green: 1, blue: 0.40000000600000002, alpha: 1), forState: .Normal)


let view = UIView()
view.translatesAutoresizingMaskIntoConstraints = false
view.contentMode = .ScaleToFill

