//
//  TUIFlightDataFetcherTests.swift
//  TUIFlightsTests
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import XCTest
@testable import TUIFlights

final class TUIFlightDataFetcherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTUIFlightDataFetcher_WhenFetchFlightData_ThenResponseSuccess() throws {
        // Arrange
        let sut = TUIFlightDataFetcher()
        
        // Act
        let data: Flight? = sut.fetchFlightData()
        
        // Assert
        XCTAssertNotNil(data)
    }
}
