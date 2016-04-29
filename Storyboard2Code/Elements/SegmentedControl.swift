import Foundation

public class SegmentedControl: View {
  public var selectedSegmentIndex: Int?
  public var segmentTitles = [String]()
  
  public required init(dict: [String : String]) {
    selectedSegmentIndex = Int(dict["selectedSegmentIndex"]!)!
    
    super.init(dict: dict)
    
    type = ElementType.UISegmentedControl
  }
  
  public override var initString: String {
    var string = super.initString
    for (index, title) in segmentTitles.enumerate() {
      string += "\(userLabel).insertSegmentWithTitle(\"\(title)\", atIndex: \(index), animated: false)\n"
    }
    if let selectedSegmentIndex = selectedSegmentIndex {
      string += "\(userLabel).selectedSegmentIndex = \(selectedSegmentIndex)\n"
    }
    return string
  }
}