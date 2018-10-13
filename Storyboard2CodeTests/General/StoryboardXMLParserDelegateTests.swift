//  Created by dasdom on 04/01/2017.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import Storyboard2Code

class StoryboardXMLParserDelegateTests: XCTestCase {
  
  var sut: StoryboardXMLParserDelegate!
  
  override func setUp() {
    super.setUp()
    
    sut = StoryboardXMLParserDelegate()
  }
  
  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func test_parsesButton() {
    let xmlString = """
      <subviews>
        <button id="42" userLabel="foo">
        </button>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Button)
  }
  
  func test_parsesImageView() {
    let xmlString = """
      <subviews>
        <imageView id="42" userLabel="foo">
        </imageView>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is ImageView)
  }
  
  func test_parsesLabel() {
    let xmlString = """
      <subviews>
        <label id="42" userLabel="foo">
        </label>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Label)
  }
  
  func test_parsesScrollView() {
    let xmlString = """
      <subviews>
        <scrollView id="42" userLabel="foo">
        </scrollView>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is ScrollView)
  }
  
  func test_parsesSegmentedControl() {
    let xmlString = """
      <subviews>
        <segmentedControl id="42" userLabel="foo">
        </segmentedControl>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is SegmentedControl)
  }
  
  func test_parsesSlider() {
    let xmlString = """
      <subviews>
        <slider id="42" userLabel="foo">
        </slider>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is Slider)
  }
  
  func test_parsesTableView() {
    let xmlString = """
      <subviews>
        <tableView id="42" userLabel="foo">
        </tableView>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is TableView)
  }
  
  func test_parsesTableViewCell() {
    let xmlString = """
      <tableViewController id="23" customClass="bar">
        <tableViewCell id="42" userLabel="foo">
        </tableViewCell>
      </tableViewController>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    XCTAssertEqual(sut.fileRepresentations.count, 1)
  }
  
  func test_parsesTextField() {
    let xmlString = """
      <subviews>
        <textField id="42" userLabel="foo">
        </textField>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
    XCTAssertTrue(sut.viewDict.values.first is TextField)
  }
  
  func test_parsesView() {
    let xmlString = """
      <subviews>
        <view id="42" userLabel="foo">
        </view>
      </subviews>
      """
    
    parseAndCheckArrays(for: xmlString)
  }
  
  func test_parsesSubView() {
    let xmlString = """
      <view id="mainId" userLabel="mainLabel">
        <subviews>
          <view id="subViewId" userLabel="subView">
            <subviews>
              <view id="firstSubSubViewId" userLabel="firstSubSubView">
              </view>
              <view id="secondSubSubViewId" userLabel="secondSubSubView">
              </view>
            </subviews>
          </view>
        </subviews>
      </view>"
      """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let subView = sut.viewDict["subViewId"]
    XCTAssertEqual(subView?.addToSuperString(), "addSubview(subView)")
    let firstSubSubView = sut.viewDict["firstSubSubViewId"]
    XCTAssertEqual(firstSubSubView?.addToSuperString(), "subView.addSubview(firstSubSubView)")
    let secondSubSubView = sut.viewDict["secondSubSubViewId"]
    XCTAssertEqual(secondSubSubView?.addToSuperString(), "subView.addSubview(secondSubSubView)")
  }
  
  func test_parsesTableViewCellSubViews() {
    let xmlString = """
      <tableViewController id="tableViewControllerId" customClass="TableViewControllerClass">
        <tableView id="tableViewId" userLabel="tableViewLabel">
          <prototypes>
            <tableViewCell id="firstTableViewCellId" userLabel="firstTableViewCellLabel">
              <tableViewCellContentView id="firstTableViewCellContentViewId">
                <subviews>
                  <imageView id="imageViewId" userLabel="imageViewLabel">
                  </imageView>
                </subviews>
              </tableViewCellContentView>
            </tableViewCell>
            <tableViewCell id="secondTableViewCellId" userLabel="SecondTableViewCellLabel">
              <tableViewCellContentView id="secondTableViewCellContentViewId">
                <subviews>
                  <label id="labelId" userLabel="labelLabel">
                  </label>
                </subviews>
              </tableViewCellContentView>
            </tableViewCell>
          </prototypes>
        </tableView>
      </tableViewController>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
//    let subView = sut.viewDict["imageViewId"]
//    XCTAssertNotNil(subView)
//    XCTAssertEqual(subView?.addToSuperString, "contentView.addSubview(imageViewLabel)")
    
    // The table view is not in fileRepresentations becaust the xml does not
    // containt the tag <scene>.
    let firstFileRepresentation = sut.fileRepresentations.first!
    XCTAssertTrue(firstFileRepresentation.mainView is TableViewCell)
    XCTAssertEqual(firstFileRepresentation.viewDict.count, 2)
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    XCTAssertTrue(lastFileRepresentation.mainView is TableViewCell)
    XCTAssertEqual(lastFileRepresentation.viewDict.count, 2)
  }
  
  func test_parsingTableView_doesNotAddCellsAsSubview() {
    let xmlString = """
      <scene>
        <tableViewController id="tableViewControllerId" customClass="TableViewControllerClass">
          <tableView id="tableViewId" userLabel="tableViewLabel">
            <prototypes>
              <tableViewCell id="firstTableViewCellId" userLabel="firstTableViewCellLabel">
                <tableViewCellContentView id="firstTableViewCellContentViewId">
                </tableViewCellContentView>
              </tableViewCell>
            </prototypes>
          </tableView>
        </tableViewController>
      </scene>
      """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    let tableView = lastFileRepresentation.mainView as! TableView
    XCTAssertEqual(tableView.cells.count, 1)
    XCTAssertNil(lastFileRepresentation.viewDict["firstTableViewCellId"])
  }
  
  func test_parsingTableViewCells_resultsInCorrectNumberOfFileRepresentations() {
    let xmlString = """
      <tableViewController id="tableViewControllerId" customClass="TableViewControllerClass">
        <tableView id="tableViewId" userLabel="tableViewLabel">
          <prototypes>
            <tableViewCell style="IBUITableViewCellStyleDefault" id="24q-Hh-TrU" userLabel="defaultCell">
              <tableViewCellContentView id="lAt-7Y-nOG">
                <subviews>
                  <label id="labelId" userLabel="labelLabel">
                  </label>
                </subviews>
              </tableViewCellContentView>
            </tableViewCell>
            <tableViewCell style="IBUITableViewCellStyleDefault" id="24q-Hh-TrU" userLabel="defaultCell">
              <tableViewCellContentView id="lAt-7Y-nOG">
                <subviews>
                  <label id="labelId" userLabel="labelLabel">
                  </label>
                </subviews>
              </tableViewCellContentView>
            </tableViewCell>
            <tableViewCell id="24q-Hh-TrU" userLabel="defaultCell">
              <tableViewCellContentView id="lAt-7Y-nOG">
              </tableViewCellContentView>
            </tableViewCell>
          </prototypes>
        </tableView>
      </tableViewController>
      """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()

    XCTAssertEqual(sut.fileRepresentations.count, 3)
    for fileRepresentation in sut.fileRepresentations {
      XCTAssertTrue(fileRepresentation.mainView is TableViewCell)
    }
  }
  
  func test_parsingTableViewCells_whenCellStyleIsSet_doesNotAddSubviews() {
    let xmlString = """
      <tableViewController id="tableViewControllerId" customClass="TableViewControllerClass">
        <tableView id="tableViewId" userLabel="tableViewLabel">
          <prototypes>
            <tableViewCell style="IBUITableViewCellStyleDefault" id="24q-Hh-TrU" userLabel="defaultCell">
              <tableViewCellContentView id="lAt-7Y-nOG">
                <subviews>
                  <label id="MeK-Ua-LQL">
                  </label>
                </subviews>
              </tableViewCellContentView>
            </tableViewCell>
          </prototypes>
        </tableView>
      </tableViewController>
      """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    XCTAssertTrue(lastFileRepresentation.mainView is TableViewCell)
    XCTAssertEqual(lastFileRepresentation.viewDict.count, 0)
  }
  
  func test_parsingView_resultsInCorrectMargins() {
    let xmlString = """
        <scene sceneID="sNi-fi-rHy">
          <objects>
            <viewController id="EI8-wh-viY" userLabel="viewController" customClass="Foo" sceneMemberID="viewController">
              <view key="view" contentMode="scaleToFill" id="UAX-U5-col" userLabel="view">
                <subviews>
                  <button buttonType="roundedRect" translatesAutoresizingMaskIntoConstraints="NO" id="cfU-u7-b0P" userLabel="button">
                  </button>
                </subviews>
              <constraints>
                <constraint firstItem="cfU-u7-b0P" firstAttribute="leading" secondItem="UAX-U5-col" secondAttribute="leadingMargin" id="cVB-3k-9QD"/>
              </constraints>
            </view>
          </viewController>
        </objects>
      </scene>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    XCTAssertEqual(lastFileRepresentation.viewMargins.first?.codeString(), "let viewMargins = layoutMarginsGuide\n")
  }
  
  func test_parsingView_whenFirstItemIsMissing_addsConstraint() {
    let xmlString = """
        <scene sceneID="Kme-PY-tzu">
          <objects>
            <viewController id="kbr-KS-wKI" customClass="Foo" customModule="TestUIs" customModuleProvider="target" sceneMemberID="viewController">
              <view key="view" id="PKe-l8-vIZ" userLabel="scrollView">
                <subviews>
                  <scrollView translatesAutoresizingMaskIntoConstraints="NO" id="R05-13-ghk" userLabel="topScrollView">
                  </scrollView>
                </subviews>
                <constraints>
                  <constraint firstAttribute="trailingMargin" secondItem="R05-13-ghk" secondAttribute="trailing" constant="52" id="sOF-ga-Sji"/>
                </constraints>
              </view>
            </viewController>
          </objects>
        </scene>
        """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    let expectedString = "scrollViewMargins.trailingAnchor.constraint(equalTo:topScrollView.trailingAnchor, constant:52),\n"
    XCTAssertEqual(lastFileRepresentation.constraints.first?.codeString(), expectedString)
  }
  
  func test_parsingScene_generatesActionCode() {
    
  }
  
  func test_constraints_whenItemIsNotMainUserLabel_setsFirstItemName() {
    let input = [constraintWithFirstItem1234()]
    
    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bla", viewNameForId: { _ in "bar" })
    
    XCTAssertEqual(output.first?.firstItemName, "bar")
  }
  
//  func test_constraints_whenItemIsMainUserLabel_setsFirstItemName() {
//    let input = [constraintWithFirstItem1234()]
//
//    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bar", viewNameForId: { _ in "bar" })
//
//    XCTAssertEqual(output.first?.firstItemName, "")
//  }
//
//  func test_constraints_whenItemAttributeHasSuffixMargin_setsFirstItemName() {
//    let input = [constraintWithFirstAttributeFooMargin()]
//
//    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bla", viewNameForId: { _ in "bar" })
//
//    XCTAssertEqual(output.first?.firstItemName, "barMargins")
//    XCTAssertEqual(output.first?.firstAttribute, "foo")
//  }
  
  func test_constraints_whenItemIsNotMainUserLabel_setsSecondItemName() {
    let input = [constraintWithSecondItem1234()]
    
    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bla", viewNameForId: { _ in "bar" })

    XCTAssertEqual(output.first?.secondItemName, "bar")
  }
  
//  func test_constraints_whenItemIsMainUserLabel_setsSecondItemName() {
//    let input = [constraintWithSecondItem1234()]
//    
//    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bar", viewNameForId: { _ in "bar" })
//
//    XCTAssertEqual(output.first?.secondItemName, "")
//  }
//  
//  func test_constraints_whenItemAttributeHasSuffixMargin_setsSecondItemName() {
//    let input = [constraintWithSecondAttributeFooMargin()]
//    
//    let output = sut.constraintsWithReplacedItemName(from: input, mainUserLabel: "bla", viewNameForId: { _ in "bar" })
//    
//    XCTAssertEqual(output.first?.secondItemName, "barMargins")
//    XCTAssertEqual(output.first?.secondAttribute, "foo")
//  }
  
  func test_viewMargins_whenFirstItemAttributeHasSuffixMargin_returnsMarginStrings() {
    var constraint = constraintWithFirstAttributeFooMargin()
    constraint.firstItemName = "foobar"

    let margins = sut.viewMargins(from: [constraint], mainUserLabel: "bar")

    XCTAssertEqual(margins.first?.codeString(), "let foobarMargins = foobar.layoutMarginsGuide\n")
  }
  
  func test_viewMargins_whenSecondItemAttributeHasSuffixMargin_returnsMarginStrings() {
    var constraint = constraintWithSecondAttributeFooMargin()
    constraint.secondItemName = "foobar"
    
    let margins = sut.viewMargins(from: [constraint], mainUserLabel: "bar")
    
    XCTAssertEqual(margins.first?.codeString(), "let foobarMargins = foobar.layoutMarginsGuide\n")
  }
  
  func test_configureConstraints_fillsControllerConstraints_1() {
    sut.constraints = [constraintWithFirstItem1234()]
    sut.layoutGuides = [LayoutGuide(dict: ["type": "top", "id": "1234"])]
    
    sut.configureConstraints()
    
    XCTAssertEqual(sut.controllerConstraints.first?.id, "42")
    XCTAssertEqual(sut.constraints.count, 0)
  }
  
  func test_configureConstraints_fillsControllerConstraints_2() {
    sut.constraints = [constraintWithSecondItem1234()]
    sut.layoutGuides = [LayoutGuide(dict: ["type": "top", "id": "1234"])]
    
    sut.configureConstraints()
    
    XCTAssertEqual(sut.controllerConstraints.first?.id, "42")
    XCTAssertEqual(sut.constraints.count, 0)
  }
  
  func test_configureConstraints_setsNamesOfControllerConstraints_1() {
    sut.constraints = [constraintWithFirstItem1234()]
    sut.layoutGuides = [LayoutGuide(dict: ["type": "top", "id": "1234"])]
    
    sut.configureConstraints()
    
    XCTAssertEqual(sut.controllerConstraints.first?.firstItemName, "topLayoutGuide")
  }
  
  func test_configureConstraints_setsNamesOfControllerConstraints_2() {
    sut.constraints = [constraintWithSecondItem1234()]
    sut.layoutGuides = [LayoutGuide(dict: ["type": "top", "id": "1234"])]
    
    sut.configureConstraints()
    
    XCTAssertEqual(sut.controllerConstraints.first?.secondItemName, "topLayoutGuide")
  }
}

// MARK: - ObjC
extension StoryboardXMLParserDelegateTests {
  func test_parsesSubView_objC() {
    let xmlString = """
      <view id="mainId" userLabel="mainLabel">
        <subviews>
          <view id="subViewId" userLabel="subView">
            <subviews>
              <view id="firstSubSubViewId" userLabel="firstSubSubView">
              </view>
              <view id="secondSubSubViewId" userLabel="secondSubSubView">
              </view>
            </subviews>
          </view>
        </subviews>
      </view>"
      """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let subView = sut.viewDict["subViewId"]
    XCTAssertEqual(subView?.addToSuperString(objC: true), "[self addSubview:_subView];")
    let firstSubSubView = sut.viewDict["firstSubSubViewId"]
    XCTAssertEqual(firstSubSubView?.addToSuperString(objC: true), "[subView addSubview:_firstSubSubView];")
    let secondSubSubView = sut.viewDict["secondSubSubViewId"]
    XCTAssertEqual(secondSubSubView?.addToSuperString(objC: true), "[subView addSubview:_secondSubSubView];")
  }
  
  func test_parsingView_resultsInCorrectMargins_objC() {
    let xmlString = """
        <scene sceneID="sNi-fi-rHy">
          <objects>
            <viewController id="EI8-wh-viY" userLabel="viewController" customClass="Foo" sceneMemberID="viewController">
              <view key="view" contentMode="scaleToFill" id="UAX-U5-col" userLabel="view">
                <subviews>
                  <button buttonType="roundedRect" translatesAutoresizingMaskIntoConstraints="NO" id="cfU-u7-b0P" userLabel="button">
                  </button>
                </subviews>
              <constraints>
                <constraint firstItem="cfU-u7-b0P" firstAttribute="leading" secondItem="UAX-U5-col" secondAttribute="leadingMargin" id="cVB-3k-9QD"/>
              </constraints>
            </view>
          </viewController>
        </objects>
      </scene>
      """
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    XCTAssertEqual(lastFileRepresentation.viewMargins.first?.codeString(objC: true), "UILayoutGuide *viewMargins = self.layoutMarginsGuide;\n")
  }
  
  func test_parsingView_whenFirstItemIsMissing_addsConstraint_objC() {
    let xmlString = """
        <scene sceneID="Kme-PY-tzu">
          <objects>
            <viewController id="kbr-KS-wKI" customClass="Foo" customModule="TestUIs" customModuleProvider="target" sceneMemberID="viewController">
              <view key="view" id="PKe-l8-vIZ" userLabel="scrollView">
                <subviews>
                  <scrollView translatesAutoresizingMaskIntoConstraints="NO" id="R05-13-ghk" userLabel="topScrollView">
                  </scrollView>
                </subviews>
                <constraints>
                  <constraint firstAttribute="trailingMargin" secondItem="R05-13-ghk" secondAttribute="trailing" constant="52" id="sOF-ga-Sji"/>
                </constraints>
              </view>
            </viewController>
          </objects>
        </scene>
        """
    
    let xmlData = xmlString.data(using: .utf8)!
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    let lastFileRepresentation = sut.fileRepresentations.last!
    let expectedString = "[scrollViewMargins.trailingAnchor constraintEqualToAnchor:_topScrollView.trailingAnchor constant:52],\n"
    XCTAssertEqual(lastFileRepresentation.constraints.first?.codeString(objC: true), expectedString)
  }
}

// MARK: - Constraints test data
extension StoryboardXMLParserDelegateTests {
  func constraintWithFirstItem1234() -> Constraint {
    return Constraint(dict: [
      Constraint.Key.firstItem.rawValue: "1234",
      Constraint.Key.firstAttribute.rawValue: "bla",
      Constraint.Key.id.rawValue: "42",
      ])
  }
  
  func constraintWithFirstAttributeFooMargin() -> Constraint {
    return Constraint(dict: [
      Constraint.Key.firstItem.rawValue: "1234",
      Constraint.Key.firstAttribute.rawValue: "fooMargin",
      Constraint.Key.id.rawValue: "42",
      ])
  }
  
  func constraintWithSecondItem1234() -> Constraint {
    return Constraint(dict: [
      Constraint.Key.secondItem.rawValue: "1234",
      Constraint.Key.firstAttribute.rawValue: "fooMargin",
      Constraint.Key.id.rawValue: "42",
      ])
  }
  
  func constraintWithSecondAttributeFooMargin() -> Constraint {
    return Constraint(dict: [
      Constraint.Key.secondItem.rawValue: "foo",
      Constraint.Key.firstAttribute.rawValue: "bar",
      Constraint.Key.secondAttribute.rawValue: "fooMargin",
      Constraint.Key.id.rawValue: "42",
      ])
  }
}

extension StoryboardXMLParserDelegateTests {
  func parseAndCheckArrays(for string: String, file: StaticString = #file, line: UInt = #line) {
    guard let xmlData = string.data(using: .utf8)
      else {
        
        return XCTFail()
    }
    
    let parser = XMLParser(data: xmlData)
    parser.delegate = sut
    parser.parse()
    
    XCTAssertEqual(sut.viewDict.count, 1, file: file, line: line)
    XCTAssertEqual(sut.tempViews.count, 0, file: file, line: line)
  }
}
