//
//  TUIFlightsUITests.swift
//  TUIFlightsUITests
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import XCTest

final class TUIFlightsUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        app = XCUIApplication()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        app = nil
    }
    
    func testTUIFlightView_WhenViewLoad_ThenDisplayTextFieldFrom() {
        // Arrange
        
        let fromTextField = app.textFields["fromTextField"]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(fromTextField.exists)
    }
    
    func testTUIFlightView_WhenViewLoad_ThenDisplayTextFieldTo() {
        // Arrange
        let toTextField = app.textFields["toTextField"]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(toTextField.exists)
    }
    
    func testTUIFlightView_WhenViewLoad_ThenDisplayButtonExplore() {
        // Arrange
        let exploreButton = app.buttons["exploreButton"]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(exploreButton.exists)
    }
    
    func testTUIFlightView_WhenViewLoad_ThenDisplayMapView() {
        // Arrange
        let mapview = app.otherElements["mapView"]
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(mapview.exists)
    }
    
    func testTUIFlightView_WhenExploreButtonTapped_ThenDisplayCheapestPrice() {
        // Arrange
        let price = app.staticTexts["cheapestPrice"]
        let exploreButton = app.buttons["exploreButton"]
        let fromTextField = app.textFields["fromTextField"]
        let toTextField = app.textFields["toTextField"]
        
        let from = "London"
        let to = "Sydney"
        
        // Act
        app.launch()
        
        fromTextField.tap()
        from.forEach({
            app.keys[String($0)].tap()
        })
        
        toTextField.tap()
        to.forEach({
            app.keys[String($0)].tap()
        })
        
        
        exploreButton.tap()
        
        // Assert
        XCTAssertTrue(price.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
