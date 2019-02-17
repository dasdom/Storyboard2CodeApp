import Foundation

final class Button: View {
  let buttonType: String?
  private var states: [ButtonState] = []
  
  init(id: String, buttonType: String?, elementType: ElementType, userLabel: String, properties: [Property]) {
    
    self.buttonType = buttonType
    
    super.init(id: id, elementType: elementType, userLabel: userLabel, properties: properties)
  }
  
  required init(dict: [String : String]) {
    fatalError("init(dict:) has not been implemented")
  }
  
  override func initString(objC: Bool = false) -> String {
    var string = "\(userLabel) = "
    if buttonType == "roundedRect" {
      string += "\(elementType.className)(type: .system)\n"
    } else {
      assert(false, "Not supported yet")
      string += "Not supported yet"
    }
    return string
  }
  
  func add(state: ButtonState) {
    states.append(state)
  }
  
  override func setupString(objC: Bool) -> String {
    var string = super.setupString(objC: objC)
    
    for state in states {
      string += state.codeString(userLabel)
    }
    
    return string
  }
}
