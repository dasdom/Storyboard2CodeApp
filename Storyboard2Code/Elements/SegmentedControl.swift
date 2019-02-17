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
  private var segments = [Segment]()
  
  func add(segment: Segment) {
      segments.append(segment)
  }
  
  override func setupString(objC: Bool = false) -> String {
    var string = super.setupString(objC: objC)
    
    // TODO: There should be a better solution than using for loops.
    //       Maybe something like Property and PropergyConfig?
    for (index, segment) in segments.enumerated() {
      string += "\(userLabel).insertSegment(withTitle:\"\(segment.title)\", at: \(index), animated: false)\n"
    }
    for (index, segment) in segments.enumerated() {
      if let enabled = segment.enabled {
        string += "\(userLabel).setEnabled(\(enabled), forSegmentAtIndex: \(index))\n"
      }
    }
    return string
  }
}
