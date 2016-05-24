import Foundation

extension String {
  /// Capitalize the first character of self
  public var capitalizeFirst:String {
    var result = self
    result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
    return result
  }
}