////
////  LocationManager.swift
////  NybleCraftTest
////
////  Created by MyMac on 13.12.18.
////  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
////
//
//import Foundation
//import CoreLocation
//import RealmSwift
//
//
//class LocationManager: Object {
//    
//    @objc dynamic var date = Date()
//    @objc dynamic var latitude: Double = 53.9620
//    @objc dynamic var longtitude: Double = 27.6736
//    @objc dynamic var country: String = "Not set"
//    @objc dynamic var city: String = "Not set"
//    
//    let locationManager = CLLocationManager()
//    
//    func fetchCoordinates() {
//        checkLocationServices()
//        checkAuthorizationStatus(locationManager: locationManager)
//        
//        locationManager.desiredAccuracy = 1000
//        locationManager.startUpdatingLocation()
//        
//        if let location = locationManager.location {
//            latitude = location.coordinate.latitude
//            longtitude = location.coordinate.longitude
//            //getPlaceNames(location: location)
//        } else {
//            print("Location: location unreachable")
//        }
//        locationManager.stopUpdatingLocation()
//    }
//    
//    func checkLocationServices() {
//        if !CLLocationManager.locationServicesEnabled() {
//            print("Location: Location services is not enabled")
//        }
//    }
//    
//    func checkAuthorizationStatus(locationManager: CLLocationManager) {
//        switch CLLocationManager.authorizationStatus() {
//        case .denied:
//            print("Location: status .denied")
//        case .restricted:
//            print("Location: status .restricted")
//        case .notDetermined:
//            print("Location: status .notDetermined")
//            locationManager.requestWhenInUseAuthorization()
//        case .authorizedAlways:
//            print("Location: status .authorizedAlways")
//        case .authorizedWhenInUse:
//            print("Location: status .authorizedWhenInUse")
//        }
//    }
//    
//    func getPlaceNames(location: CLLocation) {
//        
//        let semaphore = DispatchSemaphore(value: 0)
//        
//        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { placemarks, error in
//            if let placemarks = placemarks {
//                self.country =  (placemarks[0].country ?? "N/A")
//                self.city = (placemarks[0].administrativeArea ?? "N/A")
//                print("Location: \(placemarks[0])")
//                print("Location Country: \(self.country)")
//                print("Location City \(self.city)")
//                semaphore.signal()
//            } else {
//                print("Location: no placemarks!")
//            }
//        }
//        semaphore.wait()
//        
//    }
//}
//
//class CurrentLocationInfo: Object {
//    
//    @objc dynamic var location: Location!
//    @objc dynamic var weatherForecast: WeatherForecast!
//    
//
//    func getWeatherForecast() {
//        
//    }
//    
//    func saveToRealm() {
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(self)
//        }
//    }
//}
//
//class WeatherForecast: Object, Codable {
////    @objc dynamic var currently: CurrentWeather!
////    
////    class CurrentWeather: Object, Codable {
////        @objc dynamic var summary: String = "N/A"
////        @objc dynamic var temperature: Double = 0.0
////        @objc dynamic var pressure: Double = 0.0
////    }
//}
//
//
//
//
