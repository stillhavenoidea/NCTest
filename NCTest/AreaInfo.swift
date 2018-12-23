//
//  AreaInfo.swift
//  NCTest
//
//  Created by Valdis Doroshenkas on 12/23/18.
//  Copyright © 2018 Valdis Doroshenkas. All rights reserved.
//

import Foundation
import RealmSwift

class AreaInfo: Object {
    @objc dynamic var date = Date()
    @objc dynamic var location: Location!
    @objc dynamic var weatherForecast: WeatherForecast!
}
