import Foundation

public struct Segment: AttributeCreatable  {
  let title: String
  let enabled: Bool?
  
  public init(dict: [String : String]) {
    title = dict["title"]!
    enabled = dict["enabled"].flatMap { $0 == "YES" }
  }
}

public class SegmentedControl: View {
  public var selectedSegmentIndex: Int?
  public var segments = [Segment]()
  public var momentary: Bool?
  
  public required init(dict: [String : String]) {
    selectedSegmentIndex = Int(dict["selectedSegmentIndex"]!)!
    momentary = dict["momentary"].flatMap { $0 == "YES" }
    
    super.init(dict: dict)
    
    type = ElementType.UISegmentedControl
  }
  
  public override var setupString: String {
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
