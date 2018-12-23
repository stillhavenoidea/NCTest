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
    var areaInfo = AreaInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        fetchAreaInfo()
    }
    
    
    func fetchAreaInfo()  {
        locationFetcher.fetchLocation() { location in
            let weatherFetcher = WeatherFetcher.init(location: location)
            weatherFetcher.fetchWeather() { [unowned self] forecast in
                self.areaInfo.location = location
                self.areaInfo.weatherForecast = forecast
                self.displayAreaInfo(areaInfo: self.areaInfo)
            }
        }
    }
    
    func displayAreaInfo(areaInfo:  AreaInfo) {
        let location = areaInfo.location!
        let forecast = areaInfo.weatherForecast!
        let date = areaInfo.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        self.dateLabel.text = dateFormatter.string(from: date)
        self.latitudeLabel.text =  String.localizedStringWithFormat("%.4f", location.latitude)
        self.longtitudeLabel.text =  String.localizedStringWithFormat("%.4f", location.longtitude)
        self.placeLabel.text = location.placename
        self.weatherLabel.text = "\(forecast.currently.summary), \(forecast.currently.temperature)°C, \(forecast.currently.pressure)kPa"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
