//
//  TUIFlightsViewModel.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import SwiftUI
import Common

public class TUIFlightsViewModel: ObservableObject {
    @Published public var cities: [String] = []
    @Published public var connections: [Connection] = []
    @Published public var flightPoint: FlightPoint?
    @Published public var autocomplete: [String] = []
    
    private var session: TUIFlightDataFetcher!
    
    init(session: TUIFlightDataFetcher = TUIFlightDataFetcher()) {
        self.session = session
    }
    
    @MainActor
    func getFlightsCities() async {
        let flightData: Flight? = session.fetchFlightData()
        
        let citiesData: [String] = flightData.map({ $0.connections.map({ $0.from }) + $0.connections.map({ $0.to }) }) ?? []
        cities = Array(Set(citiesData))
    }
    
    @MainActor
    func getFlights() async {
        let flightData: Flight? = session.fetchFlightData()
        
        connections = flightData.map({ $0.connections }) ?? []
    }
    
    @MainActor
    func getExploreFlight(from: String, to: String) async {
        await self.getFlights()
        let connectionSorted = connections.sorted(by: { $0.price < $1.price })
        let connection = connectionSorted.first(where: { $0.to == to })
        
        if connection?.from == from {
            self.flightPoint = connection?.asFlightPoint()
        } else if connectionSorted.first(where: { $0.from == from }) != nil {
            self.flightPoint = getPrice(from: from, connectionSorted: connectionSorted, connection: connection)?.asFlightPoint()
        } else {
            self.flightPoint = nil
        }
    }
    
    func getAutocomplete(_ text: String) {
        let value = cities.filter({ $0.contains(text) })
        
        if value.count > 0 && value.first != text {
            autocomplete = value
        } else if value.first == text || text.isEmpty || value.isEmpty {
            autocomplete = []
        }
    }
    
    func getPrice(from: String, connectionSorted: [Connection], connection: Connection?) -> Connection? {
        guard let connection = connection else { return nil }
        
        if connection.from == from {
            return connection
        } else {
            guard let nextConnection = connectionSorted.first(where: { $0.to == connection.from }) else {
                return nil
            }
            let coordinates = Coordinates(from: nextConnection.coordinates.from,
                                          to: connection.coordinates.to)
            let valueConnection = Connection(from: nextConnection.from,
                                            to: connection.to,
                                            coordinates: coordinates,
                                             price: nextConnection.price + connection.price)
            return getPrice(from: from, connectionSorted: connectionSorted, connection: valueConnection)
        }
    }
}
