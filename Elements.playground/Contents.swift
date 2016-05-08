//: Playground - noun: a place where people can play

import UIKit

let defaultSlider = UISlider()
defaultSlider.value = 0.5
defaultSlider.minimumValue
defaultSlider.maximumValue

let fooSlider = UISlider()
fooSlider.value = 5
fooSlider.minimumValue = -7
fooSlider.maximumValue = 33
fooSlider.continuous = false
fooSlider.minimumTrackTintColor = UIColor(red: 0.000, green: 0.501, blue: 0.000, alpha: 1.000)
fooSlider.maximumTrackTintColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
fooSlider.thumbTintColor = UIColor(red: 0.000, green: 0.250, blue: 0.501, alpha: 1.000)