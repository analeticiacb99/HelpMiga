//
//  HomeViewModel.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 05/02/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine
import MapKit
import SwiftUI

class HomeViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var actives = [User]()
    @Published var help: Help?
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    var currentUser: User?
    var routeToMeetingLocation:MKRoute?
    
    // Location search properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedDestinationLocation: DestinationLocation?
    @Published var departureTime: String?
    @Published var arrivalTime: String?
    private let searchCompleter = MKLocalSearchCompleter()
    var userLocation: CLLocationCoordinate2D?
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        fetchUser()
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: - Helpers
    
    var helpCancelledMessage: String {
        guard let user = currentUser, user.accountMode == .active, let help = help else { return "" }
        
        if help.requesterUid == user.uid {
            if help.state == .helperCancelled {
                return "Seu ajudante cancelou a ajuda"
            } else if help.state == .requesterCancelled {
                return "Sua ajuda foi cancelada"
            }
        } else {
            if help.state == .helperCancelled {
                return "Sua ajuda foi cancelada"
            } else if help.state == .requesterCancelled {
                return "Sua solicitante cancelou a ajuda"
            }
        }
        return ""
    }
    
    func viewForState(_ state: MapViewState, user: User) -> some View {
        switch state {
//        case .polylineAdded, .locationSelected:
//        return AnyView(HelpRequestView() )
        case .helpRequested:
            if let help = help, help.requesterUid == user.uid {
                return AnyView(HelpLoadingView())
            } else {
                if let help = self.help {
                    return AnyView(AcceptRequestView(help: help))
                }
            }
        case .helpAccepted:
            if let help = help, help.requesterUid == user.uid {
                return AnyView(HelpAcceptedView())
            } else {
                if let help = self.help {
                    return AnyView(MettingRequesterView(help: help))
                }
            }
        case .helpCancelledByRequester, .helpCancelledByHelper:
            return AnyView(HelpCancelledView())
        default:
        break
        }
        return AnyView(Text(""))
    }
    // MARK: - USER API
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else { return }
                guard user.accountMode == .active else { return }
                self.fetchActives()
                self.addHelpObserverForRequester()
                self.addHelpObserverForHelper()
                
            }
            .store(in: &cancellables)
    }
    private func updateHelpState(state: HelpState) {
        guard let help = help else { return }
        
        var data = ["state": state.rawValue]
        
        if state == .accepted {
            data["walkingTimeToRequester"] = help.walkingTimeToRequester
        }
        
        Firestore.firestore().collection("helps").document(help.id).updateData(data) { _ in
            print("DEBUG: did update help state\(state)")
        }
    }
    
    func deleteHelp() {
        guard let help = help else { return }
        
        Firestore.firestore().collection("helps").document(help.id).delete { _ in
            self.help = nil
        }
    }
}
    
   // MARK: - Requester API

extension HomeViewModel {
    
    func addHelpObserverForRequester() {
        guard let currentUser = currentUser, currentUser.accountMode == .active else { return }
        Firestore.firestore().collection("helps")
            .whereField("requesterUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first,
                        change.type == .added
                        || change.type == .modified else { return }
                
                guard let help = try? change.document.data(as: Help.self) else { return }
                self.help = help
                print("DEBUG: Updated help state is \(help.state)")
        }
    }
    
    func fetchActives() {
        Firestore.firestore().collection("users")
            .whereField("accountMode",isEqualTo: AccountMode.active.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let actives = documents.compactMap({ try? $0.data(as: User.self)})
                self.actives = actives
                
            }
    }
    
    func requestHelp() {
        guard let active = actives.first else { return }
        guard let currentUser = currentUser else { return }
//        guard let destinationLocation = selectedDestinationLocation else { return }
//        let destinationGeoPoint = GeoPoint(latitude: destinationLocation.coordinate.latitude,
//                                           longitude: destinationLocation.coordinate.longitude)
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude,
                                      longitude: currentUser.coordinates.longitude)
        
        getPlacemark(forLocation: userLocation) { placemark, error in
            guard let placemark = placemark else { return }
            
            let help = Help(
                requesterUid: currentUser.uid,
                helperUid: active.uid,
                requesterName: currentUser.fullname,
                helperName: active.fullname,
                requesterLocation: currentUser.coordinates,
                helperLocation: active.coordinates,
                mettingLocationName: placemark.name ?? "Current Location",
//                destinationLocationName: destinationLocation.title,
                mettingLocationAddress: self.addressFromPlacemarck(placemark),
                mettingLocation: currentUser.coordinates,
//                destinationLocation: destinationGeoPoint,
                distanceToRequester: 0,
                walkingTimeToRequester: 0,
                state: .requested)
            
            guard let encodedHelp = try? Firestore.Encoder().encode(help) else { return }
            Firestore.firestore().collection("helps").document().setData(encodedHelp) { _ in
                print("DEBUG: Did upload help to firestore")
            }
        }
    }
    
    func cancelHelpAsRequester() {
        updateHelpState(state: .requesterCancelled)
    }
}
    // MARK: - Helper API
    
extension HomeViewModel {
    
    func addHelpObserverForHelper() {
        guard let currentUser = currentUser else { return }
        Firestore.firestore().collection("helps")
            .whereField("helperUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                
                guard let change = snapshot?.documentChanges.first,
                      change.type == .added
                        || change.type == .modified else { return }
                
                guard let help = try? change.document.data(as: Help.self) else { return }
                
                self.help = help
                
                self.getDestinationRoute(from: help.helperLocation.toCoordinate(),
                                         to: help.mettingLocation.toCoordinate()) { route in
                    
                    self.routeToMeetingLocation = route
                    self.help?.walkingTimeToRequester = Int(route.expectedTravelTime / 60)
                    self.help?.distanceToRequester = route.distance
                }
            }
    }
    func rejectHelp() {
        updateHelpState(state: .rejected)
    }
    
    func acceptHelp() {
        updateHelpState(state: .accepted)
    }
    
    func cancelHelpAsHelper() {
        updateHelpState(state: .helperCancelled)
    }
}
// MARK: - Location Search Helpers

extension HomeViewModel {
    
    func addressFromPlacemarck(_ placemark: CLPlacemark) -> String {
        var result = ""
        
        if let thoroughfare = placemark.thoroughfare {
          result += thoroughfare
        }
        if let subthoroughfare = placemark.subThoroughfare {
            result += " \(subthoroughfare)"
        }
        if let subadiministrativeArea = placemark.subAdministrativeArea {
            result += ", \(subadiministrativeArea)"
        }
        
        return result
    }
    
    func getPlacemark(forLocation location:CLLocation, completion: @escaping(CLPlacemark?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let placemark = placemarks?.first else { return }
            completion(placemark, nil)
        }
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                      return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedDestinationLocation = DestinationLocation(title: localSearch.title, coordinate: coordinate)
            print("DEBUG: Location coordinates \(coordinate)")
        }
        
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search =  MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
        
        func computeDestinationDistance (forType type: DistanceCalculatedType) -> Double {
            guard let destCoordinate = selectedDestinationLocation?.coordinate else { return 0.0 }
            guard let userCoordinate = self.userLocation else { return 0.0 }
            
            let userLocation = CLLocation (latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
            let destination = CLLocation (latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
            
            let destinationDistanceInMeters = userLocation.distance(from: destination)
            return type.computeDistance(for: destinationDistanceInMeters)
        
    }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destination: CLLocationCoordinate2D,
                                 completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            request.transportType = .walking
            
            let directions = MKDirections(request: request)
            
            
            directions.calculate { response, error  in
                if let error = error {
                    print("DEBUG: Failed to get directions with error\(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return }
                self.configureDepartureAndArrivalTimes(with: route.expectedTravelTime)
                completion(route)
                
        }
    }
    
    func configureDepartureAndArrivalTimes(with expectedTravelTime: Double) {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        departureTime = formatter.string(from: Date())
        arrivalTime = formatter.string(from: Date() + expectedTravelTime)
    }
}
extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

