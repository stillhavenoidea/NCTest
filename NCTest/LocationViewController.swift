//
//  LocationWeatherViewController.swift
//  NybleCraftTest
//
//  Created by MyMac on 13.12.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//
import CoreLocation
import UIKit

class LocationViewController: UIViewController {
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!

    var locationFetcher = LocationFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Loaded")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        locationFetcher.fetchLocation() { location in
            let weatherFetcher = WeatherFetcher.init(location: location)
            weatherFetcher.fetchWeather() { forecast in
                self.latitudeLabel.text =  String.localizedStringWithFormat("%.4f", location.latitude)
                self.longtitudeLabel.text =  String.localizedStringWithFormat("%.4f", location.longtitude)
                self.placeLabel.text = location.placename
                self.weatherLabel.text = "\(forecast.currently.summary), \(forecast.currently.temperature)°C, \(forecast.currently.pressure)kPa"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View Appeareded")
    }
    
}
