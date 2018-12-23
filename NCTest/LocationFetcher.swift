//
//  LocationFetcher.swift
//  LOCATIONTEST
//
//  Created by MyMac on 23.12.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import Foundation
import CoreLocation

class LocationFetcher {

    private let locationManager = CLLocationManager()
    let location = Location()
    
    func fetchLocation(complition: @escaping (Location) -> ()) {
        locationManager.desiredAccuracy = 1000
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        checkServices()
        checkAuthorizationStatus(locationManager: locationManager)
        
        if let fetchedLocation = locationManager.location {
            location.latitude = fetchedLocation.coordinate.latitude
            location.longtitude = fetchedLocation.coordinate.longitude
            getPlaceNames(clLocation: fetchedLocation, completion: complition)
        } else {
            print("Location: No fetched location")
            
            //debug
            let  location = CLLocation(latitude: 53.9620, longitude: 27.6733)
            getPlaceNames(clLocation: location, completion: complition)
            ///////
        }
    }
    
    private func checkServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location: Location services is not enabled")
            return
        }
    }
    
    private func checkAuthorizationStatus(locationManager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            print("Location: status .denied")
        case .restricted:
            print("Location: status .restricted")
        case .notDetermined:
            print("Location: status .notDetermined")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            print("Location: status .authorizedAlways")
        case .authorizedWhenInUse:
            print("Location: status .authorizedWhenInUse")
        }
    }
    
    func getPlaceNames(clLocation: CLLocation, completion: @escaping (Location) -> ()) {
        var placeDescryption = ""
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(clLocation, preferredLocale: Locale(identifier: "en_US")) { placemarks, error in
            if let placemarks = placemarks {
                if let country = placemarks[0].country {
                    placeDescryption += country
                }
                
                if let city = placemarks[0].administrativeArea {
                    placeDescryption += ", \(city)"
                }
                
                self.location.placename = placeDescryption
                print("Placedescryption: \(self.location.placename)")
            } else {
                print("Location: no placemarks!")
            }
            completion(self.location)
        }
    }
}

class Location {
    var latitude = 53.9620
    var longtitude = 27.6733
    var placename = "Not set"
}
