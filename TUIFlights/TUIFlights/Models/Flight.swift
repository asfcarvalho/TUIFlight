//
//  Flight.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import Foundation

// MARK: - Flight
public struct Flight: Codable, Hashable {
    let connections: [Connection]
}
