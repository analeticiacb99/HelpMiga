//
//  HelpMigaMapViewRepresentable.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 24/01/23.
//

import SwiftUI
import MapKit

struct HelpMigaMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    @Binding var mapState: MapViewState
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            context.coordinator.addHelpersToMap(homeViewModel.actives)
            break
        case .helpAccepted:
            guard let help = homeViewModel.help else { return }
            guard let helper = homeViewModel.currentUser, helper.accountMode == .active else { return }
            guard let route = homeViewModel.routeToMeetingLocation else { return }
            context.coordinator.configurePolylineToMeetingLocation(withRoute: route)
            context.coordinator.addAndSelectAnnotation(withCoordinate: help.meetingLocation.toCoordinate())
        default:
            break
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}
 
extension HelpMigaMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        let parent: HelpMigaMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Lifecycle
        
        init(parent: HelpMigaMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if let annotation = annotation as? HelperAnnotation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "active")
                view.image = UIImage(systemName: "figure.wave")
                view.annotation = annotation
                return view
            }
            return nil
        }

        // MARK: - Helpers
        
        func configurePolylineToMeetingLocation(withRoute  route: MKRoute) {
            self.parent.mapView.addOverlay(route.polyline)
            let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 88, left: 32, bottom: 500, right: 32 ))
            self.parent.mapView.setRegion(MKCoordinateRegion (rect), animated: true)
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
        }
        
        func clearMapViewAndRecenterOnUserLocation () {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        func addHelpersToMap (_ helpers: [User]) {
            let annotations = helpers.map({ HelperAnnotation(helper: $0) })
            self.parent.mapView.addAnnotations(annotations)
        }
    }
}
