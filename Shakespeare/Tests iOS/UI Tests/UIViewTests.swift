//
//  ListViewTests.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest

class UIViewTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {

    }

    // Simple UI Test to go from List To Detail view and chedck the title.
    func testListViewToDetailView() throws {
        let tablesQuery = app.tables
        let cell = tablesQuery.cells.firstMatch
        let title = "Kaley Schiller Review"
        cell.tap()
        sleep(1)
        XCTAssertTrue(app.navigationBars[title].exists, "Title \(title) doesn't exist")
        app.navigationBars[title].buttons["Shakespeare Reviews"].tap()

    }

}
