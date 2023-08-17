//
//  AutocompleteObject.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import SwiftUI
import Combine

public struct AutocompleteObject: View {
    
    @State var autocomplete: [String] = []
    var value = PassthroughSubject<String, Never>()
    
    public var body: some View {
        List(autocomplete, id: \.self) { suggestion in
            ZStack {
                Text(suggestion)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .onTapGesture {
                value.send(suggestion)
                self.autocomplete = []
            }
        }
    }
}
