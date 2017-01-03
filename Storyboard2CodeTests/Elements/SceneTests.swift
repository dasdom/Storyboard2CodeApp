//  Created by dasdom on 03/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class SceneTests: XCTestCase {
  
  func test_simpleCodeGeneration() {
    let mainView = View(dict: ["id": "42", "userLabel": "fooView"])
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let secene = Scene(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "",
                          "class FooView: UIView {",
                          "",
                          "override init(frame: CGRect) {",
                          "super.init(frame: frame)",
                          "",
                          "",
                          "}",
                          "",
                          "required init?(coder aDecoder: NSCoder) {",
                          "fatalError(\"init(coder:) has not been implemented\")",
                          "}",
                          "}",
                          "",
                          "extension Foo {",
                          "override func loadView() {",
                          "view = FooView()",
                          "}",
                          "}"].joined(separator: "\n")
    XCTAssertEqual(secene.swiftCodeString, expectedOutput)
  }
}
