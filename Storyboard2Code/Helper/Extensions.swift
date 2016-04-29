import Foundation

extension String {
  public var capitalizeFirst:String {
    var result = self
    result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
    return result
  }
}