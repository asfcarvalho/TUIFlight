//
//  TUIFlightsView.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import SwiftUI
import MapKit
import Common
import Combine

struct TUIFlightsView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @ObservedObject var viewModel: TUIFlightsViewModel
    
    init(viewModel: TUIFlightsViewModel = TUIFlightsViewModel()) {
        self.viewModel = viewModel
    }
    
    private var token = CancelBag()
    
    @State var from: String = ""
    @State var to: String = ""
    @State var isFrom: Bool = true
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(region: region, lineCoordinates: viewModel.flightPoint?.markers)
                .accessibilityIdentifier("mapView")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                fromView
                
                toView
                
                buttonView
                
                if let connection = viewModel.flightPoint {
                    Text("Price: \(connection.price)")
                        .accessibilityIdentifier("cheapestPrice")
                }
                
                if viewModel.autocomplete.count > 0 {
                    autocomplete()
                }
            }.padding()
                .background(Color.white)
        }.onAppear {
            Task {
                await viewModel.getFlightsCities()
            }
        }
    }
    
    var fromView: some View {
        HStack {
            TextField("From", text: $from)
                .onChange(of: from) { newValue in
                    viewModel.getAutocomplete(newValue)
                    isFrom = true
                }
                .accessibilityIdentifier("fromTextField")
                .padding()
        }.border(Color.black)
    }
    
    var toView: some View {
        HStack {
            TextField("To", text: $to)
                .onChange(of: to) { newValue in
                    viewModel.getAutocomplete(newValue)
                    isFrom = false
                }
                .accessibilityIdentifier("toTextField")
                .padding()
        }.border(Color.black)
    }
    
    var buttonView: some View {
        Button {
            Task {
                await viewModel.getExploreFlight(from: from, to: to)
            }
        } label: {
            Text("Explore")
        }.accessibilityIdentifier("exploreButton")
    }
    
    func autocomplete() -> some View {
        let view = AutocompleteObject(autocomplete: viewModel.autocomplete)
        
        view.value.sink { text in
            if isFrom {
                from = text
            } else {
                to = text
            }
        }.store(in: token)
        
        return view
    }
}

struct TUIFlightsView_Previews: PreviewProvider {
    static var previews: some View {
        TUIFlightsView()
    }
}
