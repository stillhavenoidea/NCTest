//
//  PersistentHistoryViewController.swift
//  NybleCraftTest
//
//  Created by MyMac on 16.12.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView! {
        didSet {
            historyTableView.dataSource = self
            historyTableView.delegate = self
            historyTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    //var location = LocationManager.locationInfo
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(
            withIdentifier: "HISTORYCELL",
            for: indexPath) as! HistoryTableViewCell
        //cell.dateLabel.text = "\(indexPath.row)"
        //cell.latitudeLabel.text =  "\(location.latitude)"
        //cell.longtitudeLabel.text =  "\(location.longitude)"
        //cell.weatherLabel.text = "There are very very long piece of today's weather discription. Now it is snowy. Maybe next day will be better."
        cell.layoutIfNeeded()
        return cell
    }
}
