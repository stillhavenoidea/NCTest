//
//  WeatherFetcher.swift
//  NCTest
//
//  Created by Valdis Doroshenkas on 12/23/18.
//  Copyright © 2018 Valdis Doroshenkas. All rights reserved.
//

import Foundation
import Alamofire


class WeatherFetcher {
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func fetchWeather(complition: @escaping (WeatherForecast) -> ()) {
        let url = "https://api.darksky.net/forecast/7ca52dd362e55eea6bb1c97062045404/\(location.latitude),\(location.latitude)?units=si&lang=en"
        Alamofire.request(url).responseData() { response in
            guard let data = response.data else {
                print("WeatherFetcher: data fetching error")
                return
            }
            
            let decoder = JSONDecoder()
            if let forecast = try? decoder.decode(WeatherForecast.self, from: data) {
                complition(forecast)
            } else {
                print("WeatherFetcher: decoding JSON error")
            }
        }
    }
}

class WeatherForecast: Codable {
    var currently: CurrentWeather
}

class CurrentWeather: Codable {
    var summary: String = "N/A"
    var temperature: Double = 0.0
    var pressure: Double = 0.0
}
