import Foundation

extension String {
  /// Capitalize the first character of self
  public var capitalizeFirst:String {
    var result = self
    result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
    return result
  }
}
