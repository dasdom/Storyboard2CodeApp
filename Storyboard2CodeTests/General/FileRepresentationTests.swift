//  Created by dasdom on 03/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class FileRepresentationTests: XCTestCase {
  
  func test_simpleCodeGeneration() {
    let mainView = View(dict: ["id": "42", "userLabel": "fooView"])
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let scene = FileRepresentation(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooView: UIView {",
                          "override init(frame: CGRect) {",
                          "super.init(frame: frame)",
                          "}",
                          "required init?(coder aDecoder: NSCoder) {",
                          "fatalError(\"init(coder:) has not been implemented\")",
                          "}",
                          "}",
                          "extension Foo {",
                          "override func loadView() {",
                          "view = FooView()",
                          "}",
                          "}"]
    
    let lines = scene.swiftCodeString.components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    for (index, line) in linesWithoutEmptyLines.enumerated() {
      XCTAssertEqual(line, expectedOutput[index])
    }
  }
  
  func test_simpleCodeGeneration_objCHeader() {
    let mainView = View(dict: ["id": "42", "userLabel": "fooView"])
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let scene = FileRepresentation(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["#import <UIKit/UIKit.h>",
                          "@interface FooView : UIView",
                          "@end"]
    
    let lines = scene.objCHeaderCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count)
    for (index, outputLine) in expectedOutput.enumerated() {
      XCTAssertEqual(linesWithoutEmptyLines[index], outputLine)
    }
  }
  
  func test_simpleCodeGeneration_objCImplementation() {
    let mainView = View(dict: ["id": "42", "userLabel": "fooView"])
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let scene = FileRepresentation(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["#import \"FooView.h\"",
                          "@implementation FooView",
                          "- (instancetype)initWithFrame:(CGRect)frame {",
                          "self = [super initWithFrame:frame];",
                          "if (self) {",
                          "}",
                          "return self;",
                          "}",
                          "@end"]
    
    let lines = scene.objCImplementationCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count)
    for (index, outputLine) in expectedOutput.enumerated() {
      XCTAssertEqual(linesWithoutEmptyLines[index], outputLine)
    }
  }
  
  func test_tableViewCellCodeGeneration() {
    let mainView = TableViewCell(dict: ["id": "42", "userLabel": "fooCell"])
    mainView.isMainView = true
    let tableViewController = TableViewController(dict: ["id": "23", "customClass" : "Foo"])
    let scene = FileRepresentation(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: tableViewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooCell: UITableViewCell {",
                          "override init(style: UITableViewCellStyle, reuseIdentifier: String?) {",
                          "super.init(style: style, reuseIdentifier: reuseIdentifier)",
                          "}",
                          "required init?(coder aDecoder: NSCoder) {",
                          "fatalError(\"init(coder:) has not been implemented\")",
                          "}",
                          "}",
    ]
    
    let lines = scene.swiftCodeString.components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    for (index, line) in linesWithoutEmptyLines.enumerated() {
      XCTAssertEqual(line, expectedOutput[index])
    }

  }
}
