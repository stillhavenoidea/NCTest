//
//  LocationWeatherViewController.swift
//  NybleCraftTest
//
//
//  Created by Valdis Doroshenkas on 12/23/18.
//  Copyright © 2018 Valdis Doroshenkas. All rights reserved.
//

import CoreLocation
import UIKit
import RealmSwift

class LocationViewController: UIViewController {
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var locationFetcher = LocationFetcher()
    var areaInfo = AreaInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAreaInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayAreaInfo(areaInfo: areaInfo)
    }
    
    
    func fetchAreaInfo()  {
        locationFetcher.fetchLocation() { location in
            let weatherFetcher = WeatherFetcher.init(location: location)
            weatherFetcher.fetchWeather() { [unowned self] forecast in
                
                let realm = try! Realm()
                try! realm.write {
                    self.areaInfo.latitude = location.latitude
                    self.areaInfo.longtitude = location.longtitude
                    self.areaInfo.placename = location.placename
                    self.areaInfo.summary = forecast.currently.summary
                    self.areaInfo.temperature = forecast.currently.temperature
                    self.areaInfo.pressure = forecast.currently.pressure
                    realm.add(self.areaInfo)
                    print("Saving to realm!")
                }
                
                self.displayAreaInfo(areaInfo: self.areaInfo)
            }
        }
    }
    
    func displayAreaInfo(areaInfo:  AreaInfo) {
        let date = areaInfo.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        self.dateLabel.text = dateFormatter.string(from: date)
        self.latitudeLabel.text =  String.localizedStringWithFormat("%.4f", areaInfo.latitude)
        self.longtitudeLabel.text =  String.localizedStringWithFormat("%.4f", areaInfo.longtitude)
        self.placeLabel.text = areaInfo.placename
        self.weatherLabel.text = "\(areaInfo.summary), \(areaInfo.temperature)°C, \(areaInfo.pressure)kPa"
    }
}
