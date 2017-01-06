# Storybard2CodeApp
[![Build Status](https://travis-ci.org/dasdom/Storybard2CodeApp.svg?branch=master)](https://travis-ci.org/dasdom/Storybard2CodeApp)
[![Build Status](https://img.shields.io/travis/dasdom/Storybard2CodeApp.svg)](https://travis-ci.org/dasdom/Storybard2CodeApp)
![](https://img.shields.io/badge/platform-osx-lightgrey.svg)

Mac app that converts an iOS storyboard into code. Work in progress.

# Progress
## Support (== most properties supported)
- [x] UIView
- [x] UIButton
- [x] UILabel
- [x] UISlider
- [x] UITextField
- [x] UISegmentedControl (images not supported yet)
- [x] UIScrollView
- [x] UITableView 
- [x] UIImageView

## Next planed elements
- UITableViewCell
- UICollectionView
- UICollectionViewCell

# Example output
```swift
import UIKit

class View: UIView {
  let defaultButton: UIButton
  let button: UIButton
  
  override init(frame: CGRect) {
    
    defaultButton = UIButton(type: .System)
    defaultButton.userInteractionEnabled = false
    defaultButton.translatesAutoresizingMaskIntoConstraints = false
    defaultButton.setTitle("Button", forState: .Normal)
    
    button = UIButton(type: .System)
    button.userInteractionEnabled = false
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentHorizontalAlignment = .Left
    button.contentVerticalAlignment = .Top
    button.enabled = false
    button.highlighted = true
    button.selected = true
    button.reversesTitleShadowWhenHighlighted = true
    button.showsTouchWhenHighlighted = true
    button.adjustsImageWhenHighlighted = false
    button.adjustsImageWhenDisabled = false
    button.titleLabel?.lineBreakMode = .ByClipping
    button.setTitle("Button 1", forState: .Normal)
    button.setTitleColor(UIColor(red: 1.000, green: 1.000, blue: 0.400, alpha: 1.000), forState: .Normal)
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(defaultButton)
    addSubview(button)
    
    let viewMargins = layoutMarginsGuide
    
    defaultButton.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor).active = true
    button.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor).active = true
    defaultButton.topAnchor.constraintEqualToAnchor(button.bottomAnchor, constant: 8).active = true
  }
  
  convenience required init(coder aDecoder: NSCoder) {
    self.init()
  }
  
}

extension Foo {
  override func loadView() {
    view = View()
  }
  
  func setLayoutGuideConstraints() {
    let contentView = view as! View
    contentView.button.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8).active = true
  }
}
```

# Usage
At the moment, all the elements in the storyboard need a label because this is used for the name of the element. You can set the label in the identity inspector:

![](https://raw.githubusercontent.com/dasdom/Storybard2CodeApp/master/screenshots/setting_label.png)

At the moment, the app will crash when a label is missing. But you will see an error output on the console.

# Author
[@dasdom](https://twitter.com/dasdom)
