//: Playground - noun: a place where people can play

import UIKit

let defaultLabel = UILabel()
defaultLabel.translatesAutoresizingMaskIntoConstraints = false
defaultLabel.contentHuggingPriorityForAxis(.Horizontal)
defaultLabel.contentHuggingPriorityForAxis(.Vertical)
defaultLabel.textAlignment == .Natural
defaultLabel.lineBreakMode == .ByTruncatingTail
defaultLabel.baselineAdjustment == .AlignBaselines
defaultLabel.adjustsFontSizeToFitWidth == false

let fooLabel = UILabel()
fooLabel.translatesAutoresizingMaskIntoConstraints = false
fooLabel.lineBreakMode = .ByTruncatingHead
fooLabel.numberOfLines = 0
fooLabel.minimumScaleFactor = 0.5
fooLabel.adjustsFontSizeToFitWidth = true
fooLabel.enabled = false
fooLabel.highlighted = true
fooLabel.text = "foo\nLabel"
