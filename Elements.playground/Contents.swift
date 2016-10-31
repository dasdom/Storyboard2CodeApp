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
    
    separatorStyle = .singleLineEtched
    sectionIndexMinimumDisplayRowCount = 2
    allowsSelectionDuringEditing = true
    allowsMultipleSelection = true
    rowHeight = 44
    sectionHeaderHeight = 18
    sectionFooterHeight = 18
    
    backgroundColor = UIColor(colorLiteralRed: 0.937, green: 0.937, blue: 0.956, alpha: 1.000)
    separatorColor = UIColor(colorLiteralRed: 0.000, green: 0.501, blue: 0.000, alpha: 1.000)
    sectionIndexColor = UIColor(colorLiteralRed: 0.909, green: 0.301, blue: 0.236, alpha: 1.000)
    sectionIndexBackgroundColor = UIColor(colorLiteralRed: 0.400, green: 0.800, blue: 1.000, alpha: 1.000)
    sectionIndexTrackingBackgroundColor = UIColor(colorLiteralRed: 0.216, green: 0.286, blue: 0.600, alpha: 1.000)
    separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
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
