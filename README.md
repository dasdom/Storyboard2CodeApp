# Storybard2CodeApp
[![Build Status](https://travis-ci.org/dasdom/Storyboard2CodeApp.svg?branch=master)](https://travis-ci.org/dasdom/Storybard2CodeApp)
![](https://img.shields.io/badge/platform-osx-lightgrey.svg)

Mac app that converts an iOS storyboard into code. Work in progress.

# Goal
The ultimate goal is to be able to convert any iOS storyboard and convert it to code that is usable as a replacement of that storyboard without modification. 

# Progress
The project is in pre-alpha status. If I had to give a number of the progress, I would say it's about 50% done. But keep in mind, the last 20% of any project consume 80% of the total time. ;)

## Supported (== most properties supported)
- [x] UIView
- [x] UIButton
- [x] UILabel
- [x] UISlider
- [x] UITextField
- [x] UISegmentedControl (images not supported yet)
- [x] UIScrollView
- [x] UITableView 
- [x] UIImageView
- [x] UITableViewCell
- [ ] SaveAreaGuides
- [ ] IBActions
- [ ] Segues
- [ ] Size Classes
- [ ] UIStackView
- [ ] UICollectionView
- [ ] UICollectionViewCell

# Examples
The following gifs show examples. The presentation switches between the view created from a storyboard and the view created from the generated code. You can see the switch because right now the colours aren't not perfect. So further down the road those gifs will become images. :)

![](https://raw.githubusercontent.com/dasdom/Storybard2CodeApp/master/comparison/buttons.gif)

# Usage
The generated code looks best if all the elements in the storyboard have a label because this is used for the name of the element. You can set the label in the identity inspector:

![](https://raw.githubusercontent.com/dasdom/Storybard2CodeApp/master/screenshots/setting_label.png)

If the label is missing, the internal id in the storyboard of that element is used.

# Author
[@dasdom](https://twitter.com/dasdom)

# Licence
MIT

See LICENCE.md
