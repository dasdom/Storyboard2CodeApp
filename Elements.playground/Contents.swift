//: Playground - noun: a place where people can play

import UIKit

let foo = UIView()
let bar = UIView()
let fooStackView = UIStackView(arrangedSubviews: [])
fooStackView.axis = .vertical
fooStackView.spacing = 10
//fooStackView.distribution = .fillEqually
//fooStackView.alignment = .top

fooStackView.distribution == .fill
fooStackView.alignment == .fill
fooStackView.isOpaque == true

//foo.safeAreaLayoutGuide

fooStackView.addArrangedSubview(foo)

