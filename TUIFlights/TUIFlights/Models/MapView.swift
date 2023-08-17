//
//  MapView.swift
//  TUIFlights
//
//  Created by Anderson F Carvalho on 17/08/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        
        if let lineCoordinates = lineCoordinates {
            
            let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
            mapView.addOverlay(polyline)
            
            lineCoordinates.forEach({
                let pin = MKPointAnnotation()
                
                pin.coordinate = $0
                
                mapView.addAnnotation(pin)
            })
        }
                
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.region = region
        
        view.removeAnnotations(view.annotations)
        view.removeOverlays(view.overlays)
        
        if let lineCoordinates = lineCoordinates {
            
            let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
            view.addOverlay(polyline)
            
            lineCoordinates.forEach({
                let pin = MKPointAnnotation()
                
                pin.coordinate = $0
                
                view.addAnnotation(pin)
            })
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 10
            return renderer
        }
        return MKOverlayRenderer()
    }
}
