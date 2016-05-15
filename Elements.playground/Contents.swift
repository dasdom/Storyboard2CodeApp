//: Playground - noun: a place where people can play

import UIKit

let defaultSegmentedControl = UISegmentedControl()
defaultSegmentedControl.insertSegmentWithTitle("First", atIndex: 0, animated: false)
defaultSegmentedControl.insertSegmentWithTitle("Second", atIndex: 0, animated: false)
defaultSegmentedControl.selectedSegmentIndex = 0

let fooSegmentedControl = UISegmentedControl()
fooSegmentedControl.insertSegmentWithTitle("Foo", atIndex: 0, animated: false)
fooSegmentedControl.insertSegmentWithTitle("Bar", atIndex: 1, animated: false)
fooSegmentedControl.insertSegmentWithTitle("Hello", atIndex: 2, animated: false)
fooSegmentedControl.insertSegmentWithTitle("World", atIndex: 3, animated: false)
fooSegmentedControl.setEnabled(false, forSegmentAtIndex: 3)
fooSegmentedControl.selectedSegmentIndex = 1
fooSegmentedControl.momentary = true
