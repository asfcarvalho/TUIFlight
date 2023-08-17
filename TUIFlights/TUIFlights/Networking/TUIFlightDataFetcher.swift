//
//  TUIFlightDataFetcher.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import Foundation
import Common

class TUIFlightDataFetcher {
    
    func fetchFlightData<T: Decodable>() -> T? {
        LoadJsonData.loadJson(filename: "flights")
    }
}
