//
//  MapView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 18/10/23.
//
import MapKit
import SwiftUI

struct MapView: View {
    @State private var searchString = ""
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var pointsOfInterest: [MKMapItem] = []
    @State private var locationManager = CLLocationManager()
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @State private var selectedPOI: MKMapItem?
    @State private var route: MKRoute?
    
    var body: some View {
        NavigationStack {
            Map(position: $position,selection: $selectedPOI) {
                
                
                UserAnnotation()
                
                ForEach(pointsOfInterest,id: \.self) { poi in
                    Marker(item: poi)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(.purple,lineWidth: 6)
                        .mapOverlayLevel(level: .aboveRoads)
                        
                    
                }
                
            }
            .mapControls{
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            //.mapStyle(.imagery)
            .navigationTitle("Mapa")
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
        }
        .searchable(text: $searchString)
        .onSubmit(of: .search,searchForPOI)
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            
        }
        .onChange(of: selectedPOI, getDirections)
        
        
    }
    
    private func searchForPOI() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchString
        request.region = visibleRegion ?? MKCoordinateRegion()
        let search = MKLocalSearch(request: request)
        Task {
            guard let response = try? await search.start() else { return }
            
            
            
            pointsOfInterest = response.mapItems
            position = .automatic
        }
    }
    
    private func getDirections() {
        route = nil
        let request = MKDirections.Request()
        guard let coordinate = locationManager.location?.coordinate  else { return }
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.destination = selectedPOI
        let directions = MKDirections(request: request)
        Task {
            route = try? await directions.calculate().routes.first
            
            position = .camera(MapCamera(centerCoordinate: coordinate, distance: 400,heading: 0,pitch: 45))
        }
        
    }
}

#Preview {
    MapView()
}
