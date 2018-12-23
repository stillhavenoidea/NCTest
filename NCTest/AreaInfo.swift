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
    @objc dynamic var latitude = 0.0
    @objc dynamic var longtitude = 0.0
    @objc dynamic var placename = ""
    @objc dynamic var summary = ""
    @objc dynamic var temperature = 0.0
    @objc dynamic var pressure = 0.0
}
