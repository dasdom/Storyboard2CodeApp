//: Playground - noun: a place where people can play

import UIKit

let sut = UIImageView()
sut.clipsToBounds
sut.isUserInteractionEnabled
sut.contentMode == .scaleAspectFill
sut.setContentHuggingPriority(251, for: .vertical)
sut.image = UIImage(named: "fire")
sut.highlightedImage = UIImage(named: "see")
