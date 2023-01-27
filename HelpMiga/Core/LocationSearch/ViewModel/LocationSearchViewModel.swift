//
//  LocationSearchViewModel.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 25/01/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion] ()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: Lifecycle
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    // MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                      return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG: Location coordinates \(coordinate)")
        }
        
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search =  MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        
//        func distanceCalculated(for distanceInMeters: Double ) -> Double {
//            guard let coordinate = selectedLocationCoordinate else { return 0.0 }
//            guard let userLocation = self.userLocation else { return 0.0 }
//
//            let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
//
//            let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//
//            let tripDistanceINMeters = userLocation.distance(from: destination)
//            return distanceInMeters.distanceCalculated (for: tripDistanceINMeters)
//
//        }
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
        
    }

}
