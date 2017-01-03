//: Playground - noun: a place where people can play

import UIKit

class FooCell: UITableViewCell {
  
  let fooImageView: UIImageView
  let fooLabel: UILabel
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    fooImageView = UIImageView()
    fooLabel = UILabel()
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(fooImageView)
    contentView.addSubview(fooLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
