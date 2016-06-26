//: Playground - noun: a place where people can play

import UIKit

let defaultTableView = UITableView()
defaultTableView.clipsToBounds == true
defaultTableView.contentMode == .scaleToFill
defaultTableView.alwaysBounceVertical == true
defaultTableView.style == .plain
defaultTableView.separatorStyle == .singleLine


class FooTableView: UITableView {
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class TableViewController: UITableViewController {
  
}

extension TableViewController {
  override func loadView() {
    let contentTableView = FooTableView(frame: CGRect.zero, style: .grouped)
    tableView = contentTableView
  }
}

let button = UIButton(type: .system)
