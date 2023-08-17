//
//  TUIFlightsViewModelTests.swift
//  TUIFlightsTests
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import XCTest
@testable import TUIFlights

final class TUIFlightsViewModelTests: XCTestCase {
    
    var sut: TUIFlightsViewModel!

    override func setUpWithError() throws {
        sut = TUIFlightsViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testTUIFlightsViewModel_WhenFetchFlightCities_ThenCallCityListSuccess() async throws {
        // Arrange
        
        // Act
        await sut.getFlightsCities()
        
        // Assert
        XCTAssertTrue(sut.cities.count > 0)
    }

    func testTUIFlightsViewModel_WhenFetchFlights_ThenCallFlightListSuccess() async throws {
        // Arrange
        
        // Act
        await sut.getFlights()
        
        // Assert
        XCTAssertTrue(sut.connections.count > 0)
    }
    
    func testTUIFlightsViewModel_WhenExploreFlights_ThenCallResultSuccess() async throws {
        // Arrange
        let from = "London"
        let to = "Sydney"
        
        // Act
        await sut.getExploreFlight(from: from, to: to)
        
        // Assert
        XCTAssertNotNil(sut.flightPoint)
    }
    
    func testTUIFlightsViewModel_WhenExploreFlights_ThenCallResultFailure() async throws {
        // Arrange
        let from = "Porto"
        let to = "Sydney"
        
        // Act
        await sut.getExploreFlight(from: from, to: to)
        
        // Assert
        XCTAssertNil(sut.flightPoint)
    }
    
    func testTUIFlightsViewModel_WhenTextFieldAutocomplete_ThenResultValue() async throws {
        // Arrange
        let text = "Tok"
        
        // Act
        await sut.getFlightsCities()
        sut.getAutocomplete(text)
        
        // Assert
        XCTAssertEqual(sut.autocomplete.count, 1)
    }
    
    func testTUIFlightsViewModel_WhenTextFieldAutocomplete_ThenNoResultValue() async throws {
        // Arrange
        let text = "Value"
        
        // Act
        await sut.getFlightsCities()
        sut.getAutocomplete(text)
        
        // Assert
        XCTAssertEqual(sut.autocomplete.count, 0)
    }
}
