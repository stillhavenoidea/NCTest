//
//  PersistentHistoryViewController.swift
//  NybleCraftTest
//
//  Created by Valdis Doroshenkas on 12/23/18.
//  Copyright © 2018 Valdis Doroshenkas. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView! {
        didSet {
            historyTableView.dataSource = self
            historyTableView.delegate = self
            historyTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    var history: [AreaInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadHistoryFromRealm()
        historyTableView.reloadData()
    }
    
    func loadHistoryFromRealm() {
        history = []
        let realm = try! Realm()
        let realmHistory = realm.objects(AreaInfo.self)//.sorted(byKeyPath: "date")
        
        for areaInfo in realmHistory {
            history.append(areaInfo)
        }
        print("There are \(history.count) objects")
    }
    
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(
            withIdentifier: "HISTORYCELL",
            for: indexPath) as! HistoryTableViewCell
        
        let areaInfo = history[indexPath.row]
        let date = areaInfo.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        cell.dateLabel.text = dateFormatter.string(from: date)
        cell.latitudeLabel.text =  String.localizedStringWithFormat("%.4f", areaInfo.latitude)
        cell.longtitudeLabel.text =  String.localizedStringWithFormat("%.4f", areaInfo.longtitude)
        cell.placeLabel.text = areaInfo.placename
        cell.weatherLabel.text = "\(areaInfo.summary), \(areaInfo.temperature)°C, \(areaInfo.pressure)kPa"
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let locationViewController = self.tabBarController?.viewControllers?[0] as? LocationViewController {
            locationViewController.areaInfo = history[indexPath.row]
            self.tabBarController?.selectedIndex = 0
        }
    }
}
