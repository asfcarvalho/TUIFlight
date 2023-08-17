//
//  Flight+Mapper.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 17/08/23.
//

import Foundation
import CoreLocation

public extension Connection {
    func asFlightPoint() -> FlightPoint {
        FlightPoint(price: self.price,
                    markers: [CLLocationCoordinate2D(latitude: self.coordinates.from.lat,
                                                     longitude: self.coordinates.from.long),
                              CLLocationCoordinate2D(latitude: self.coordinates.to.lat,
                                                     longitude: self.coordinates.to.long)])
    }
}
