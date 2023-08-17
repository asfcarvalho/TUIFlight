//
//  Connection.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 17/08/23.
//

import Foundation

// MARK: - Connection
public struct Connection: Codable, Hashable {
    let from, to: String
    let coordinates: Coordinates
    let price: Int
}
