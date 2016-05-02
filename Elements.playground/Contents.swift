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
