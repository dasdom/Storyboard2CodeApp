import Foundation

struct Segment: AttributeCreatable  {
  let title: String
  let enabled: Bool?
  
  init(dict: [String : String]) {
    title = dict[Key.title.rawValue]!
    enabled = dict[Key.enabled.rawValue].flatMap { $0 == "YES" }
  }
}

extension Segment {
  fileprivate enum Key: String {
    case title, enabled
  }
}

class SegmentedControl: View {
  var selectedSegmentIndex: Int?
  var segments = [Segment]()
  var momentary: Bool?
  
  required init(dict: [String : String]) {
    selectedSegmentIndex = dict["selectedSegmentIndex"] != nil ? Int(dict["selectedSegmentIndex"]!) : nil
    momentary = dict["momentary"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)
    
    type = ElementType.UISegmentedControl
  }
  
  override var setupString: String {
    var string = super.setupString
    for (index, segment) in segments.enumerated() {
      string += "\(userLabel).insertSegment(withTitle:\"\(segment.title)\", at: \(index), animated: false)\n"
    }
    for (index, segment) in segments.enumerated() {
      if let enabled = segment.enabled {
        string += "\(userLabel).setEnabled(\(enabled), forSegmentAtIndex: \(index))\n"
      }
    }
    if let selectedSegmentIndex = selectedSegmentIndex {
      string += setup("selectedSegmentIndex", value: "\(selectedSegmentIndex)", isEnumValue: false)
    }
    return string
  }
  
  override func reflectable() -> [String] {
    var temp = super.reflectable()
//    temp.append("selectedSegmentIndex")
    temp.append("momentary")
    return temp
  }
}
