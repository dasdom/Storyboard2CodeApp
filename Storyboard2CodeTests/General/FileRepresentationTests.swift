//  Created by dasdom on 03/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class FileRepresentationTests: XCTestCase {
  
  func test_simpleCodeGeneration() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
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
      XCTAssertEqual(line.trimmed, expectedOutput[index], "line: \(index)")
    }
  }
  
  func test_codeGeneration_sortsViews_1() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let label1 = Builder.builder(for: .label).build(attributes: ["id": "123", "userLabel": "oneLabel"])
    label1.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    let label2 = Builder.builder(for: .label).build(attributes: ["id": "456", "userLabel": "twoLabel"])
    label2.frame = CGRect(x: 11, y: 10, width: 20, height: 20)
    let scene = FileRepresentation(mainView: mainView, viewDict: ["123":label1,"456":label2], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooView: UIView {",
                          "let oneLabel: UILabel",
                          "let twoLabel: UILabel",
                          "override init(frame: CGRect) {",
                          "oneLabel = UILabel()",
                          "twoLabel = UILabel()",
                          "super.init(frame: frame)",
                          "addSubview(oneLabel)",
                          "addSubview(twoLabel)",
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
      XCTAssertEqual(line.trimmed, expectedOutput[index])
    }
  }
  
  func test_codeGeneration_sortsViews_2() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let label1 = Builder.builder(for: .label).build(attributes: ["id": "123", "userLabel": "oneLabel"])
    label1.frame = CGRect(x: 10, y: 11, width: 20, height: 20)
    let label2 = Builder.builder(for: .label).build(attributes: ["id": "456", "userLabel": "twoLabel"])
    label2.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    let scene = FileRepresentation(mainView: mainView, viewDict: ["123":label1,"456":label2], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooView: UIView {",
                          "let twoLabel: UILabel",
                          "let oneLabel: UILabel",
                          "override init(frame: CGRect) {",
                          "twoLabel = UILabel()",
                          "oneLabel = UILabel()",
                          "super.init(frame: frame)",
                          "addSubview(twoLabel)",
                          "addSubview(oneLabel)",
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
      XCTAssertEqual(line.trimmed, expectedOutput[index])
    }
  }
  
  func test_tableViewCellCodeGeneration() {
    let attr = ["id": "42", "userLabel": "fooCell"]
    let mainView = Builder.builder(for: .tableViewCell).build(attributes: attr)
    mainView.isMainView = true
    let tableViewController = TableViewController(dict: ["id": "23", "customClass" : "Foo"])
    let cellContentView = Builder.builder(for: .tableViewCellContentView).build(attributes: ["id": "34", "tableViewCell": "42", "userLabel": "contentView_of_a_tableviewcell"])
    let label = Builder.builder(for: .label).build(attributes: ["id" : "12345", "userLabel": "blaLabel"])
    label.superViewName = "contentView_of_a_tableviewcell"
    let scene = FileRepresentation(mainView: mainView, viewDict: ["12345":label,"34":cellContentView], viewMargins: [], constraints: [], viewController: tableViewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooCell: UITableViewCell {",
                          "let blaLabel: UILabel",
                          "override init(style: UITableViewCellStyle, reuseIdentifier: String?) {",
                          "blaLabel = UILabel()",
                          "super.init(style: style, reuseIdentifier: reuseIdentifier)",
                          "self.contentView.addSubview(blaLabel)",
                          "}",
                          "required init?(coder aDecoder: NSCoder) {",
                          "fatalError(\"init(coder:) has not been implemented\")",
                          "}",
                          "}",
                          ]
    
    let lines = scene.swiftCodeString.components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count, "lines: \(linesWithoutEmptyLines)")
    for (index, line) in linesWithoutEmptyLines.enumerated() {
      XCTAssertEqual(line.trimmed, expectedOutput[index], "line: \(index)")
    }
  }
  
  func test_codeGeneration_addArrangedSubviews() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let label = Builder.builder(for: .label).build(attributes: ["id": "123", "userLabel": "oneLabel"])
    label.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    let stackView = Builder.builder(for: .stackView).build(attributes: ["id": "456", "userLabel": "stackView"]) as! StackView
    stackView.frame = CGRect(x: 10, y: 11, width: 20, height: 20)
    stackView.arrangedSubviews.append(label)
    label.isArrangedSubview = true
    let scene = FileRepresentation(mainView: mainView, viewDict: ["123":label,"456":stackView], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["import UIKit",
                          "class FooView: UIView {",
                          "let oneLabel: UILabel",
                          "let stackView: UIStackView",
                          "override init(frame: CGRect) {",
                          "oneLabel = UILabel()",
                          "stackView = UIStackView()",
                          "super.init(frame: frame)",
                          "stackView.addArrangedSubview(oneLabel)",
                          "addSubview(stackView)",
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
      XCTAssertEqual(line.trimmed, expectedOutput[index], "index: \(index)")
    }
  }
}

// MARK: - ObjC
extension FileRepresentationTests {
  func test_simpleCodeGeneration_objCHeader() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
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
  
  func test_codeGenerationWithProperties_objCHeader() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let label = Builder.builder(for: .label).build(attributes: ["id": "123", "userLabel": "123Label"])
    let scene = FileRepresentation(mainView: mainView, viewDict: ["123":label], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = ["#import <UIKit/UIKit.h>",
                          "@interface FooView : UIView",
                          "@property (nonatomic) UILabel *123Label;",
                          "@end"]
    
    let lines = scene.objCHeaderCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count)
    for (index, outputLine) in expectedOutput.enumerated() {
      XCTAssertEqual(linesWithoutEmptyLines[index].trimmed, outputLine)
    }
  }
  
  func test_simpleCodeGeneration_objCImplementation() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let scene = FileRepresentation(mainView: mainView, viewDict: [:], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = [
      "#import \"FooView.h\"",
      "@implementation FooView",
      "- (instancetype)initWithFrame:(CGRect)frame {",
      "self = [super initWithFrame:frame];",
      "if (self) {",
      "}",
      "return self;",
      "}",
      "@end"
    ]
    
    let lines = scene.objCImplementationCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count)
    for (index, outputLine) in expectedOutput.enumerated() {
      XCTAssertEqual(linesWithoutEmptyLines[index].trimmed, outputLine)
    }
  }
  
  func test_tableViewCellCodeGeneration_objC() {
    let mainView = Builder.builder(for: .tableViewCell).build(attributes: ["id": "42", "userLabel": "fooCell"])
    mainView.isMainView = true
    let tableViewController = TableViewController(dict: ["id": "23", "customClass" : "Foo"])
    let cellContentView = Builder.builder(for: .tableViewCellContentView).build(attributes: ["id": "34", "tableViewCell": "42", "userLabel": "contentView_of_a_tableviewcell"])
    let label = Builder.builder(for: .label).build(attributes: ["id" : "12345", "userLabel": "blaLabel"])
    label.superViewName = "contentView_of_a_tableviewcell"
    let scene = FileRepresentation(mainView: mainView, viewDict: ["12345":label, "34": cellContentView], viewMargins: [], constraints: [], viewController: tableViewController, controllerConstraints: nil)
    
    let expectedOutput = [
      "#import \"FooCell.h\"",
      "@implementation FooCell",
      "- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {",
      "self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];",
      "if (self) {",
      "_blaLabel = [[UILabel alloc] init];",
      "[self.contentView addSubview:_blaLabel];",
      "}",
      "return self;",
      "}",
      "@end"
    ]
    
    let lines = scene.objCImplementationCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    XCTAssertEqual(linesWithoutEmptyLines.count, expectedOutput.count)
    for (index, outputLine) in expectedOutput.enumerated() {
      XCTAssertEqual(linesWithoutEmptyLines[index].trimmed, outputLine)
    }
  }
  
  func test_codeGeneration_addArrangedSubviews_objC() {
    let attr = ["id": "42", "userLabel": "fooView"]
    let mainView = Builder.builder(for: .view).build(attributes: attr)
    mainView.isMainView = true
    let viewController = ViewController(dict: ["id": "23", "customClass" : "Foo"])
    let label = Builder.builder(for: .label).build(attributes: ["id": "123", "userLabel": "oneLabel"])
    label.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    let stackView = Builder.builder(for: .stackView).build(attributes: ["id": "456", "userLabel": "stackView"]) as! StackView
    stackView.frame = CGRect(x: 10, y: 11, width: 20, height: 20)
    stackView.arrangedSubviews.append(label)
    label.isArrangedSubview = true
    let scene = FileRepresentation(mainView: mainView, viewDict: ["123":label,"456":stackView], viewMargins: [], constraints: [], viewController: viewController, controllerConstraints: nil)
    
    let expectedOutput = [
      "#import \"FooView.h\"",
      "@implementation FooView",
      "- (instancetype)initWithFrame:(CGRect)frame {",
      "self = [super initWithFrame:frame];",
      "if (self) {",
      "_oneLabel = [[UILabel alloc] init];",
      "_stackView = [[UIStackView alloc] init];",
      "[_stackView addArrangedSubview:_oneLabel];",
      "[self addSubview:_stackView];",
      "}",
      "return self;",
      "}",
      "@end"
    ]
    
    let lines = scene.objCImplementationCode().components(separatedBy: "\n")
    let linesWithoutEmptyLines = lines.filter { $0.count > 0 }
    for (index, line) in linesWithoutEmptyLines.enumerated() {
      XCTAssertEqual(line.trimmed, expectedOutput[index], "index: \(index)")
    }
  }
}
