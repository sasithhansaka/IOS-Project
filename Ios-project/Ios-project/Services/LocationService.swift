//
//  LocationService.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//

import Foundation
import CoreLocation
internal import Combine

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    @Published var hasLocation = false
    @Published var authorizationRequested = false

    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

     func requestPermissionIfNeeded() {
                guard !authorizationRequested else { return }
                
                authorizationRequested = true
                manager.requestWhenInUseAuthorization()
     }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        hasLocation = true
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        let status =  manager.authorizationStatus

        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            hasLocation = false
        }

    }

    // func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    //     let status = manager.authorizationStatus

    // }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        hasLocation = false
    }
}
