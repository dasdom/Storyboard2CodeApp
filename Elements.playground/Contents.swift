//: Playground - noun: a place where people can play

import UIKit

let defaultTextField = UITextField()
defaultTextField.clipsToBounds == true
defaultTextField.contentMode == .ScaleToFill
defaultTextField.contentHorizontalAlignment == .Left
defaultTextField.contentVerticalAlignment == .Center
defaultTextField.borderStyle == .None
defaultTextField.textAlignment == .Natural
defaultTextField.minimumFontSize == 0

let fooTextField = UITextField()
fooTextField.borderStyle = .Line
fooTextField.placeholder = "foo"
fooTextField.textAlignment = .Center
fooTextField.clearsOnBeginEditing = true
fooTextField.minimumFontSize = 17
fooTextField.clearButtonMode = .WhileEditing
fooTextField.textColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
fooTextField.font = UIFont(name: "AvenirNext-Regular", size: 20)
fooTextField.autocapitalizationType = .AllCharacters
fooTextField.autocorrectionType = .No
fooTextField.spellCheckingType = .No
fooTextField.keyboardType = .Twitter
fooTextField.keyboardAppearance = .Dark
fooTextField.returnKeyType = .Send
fooTextField.enablesReturnKeyAutomatically = true
fooTextField.secureTextEntry = true


let view = UIView()
view.clipsToBounds
