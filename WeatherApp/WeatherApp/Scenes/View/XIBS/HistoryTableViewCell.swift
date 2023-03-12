//
//  HistoryTableViewCell.swift
//  WeatherApp
//
//  Created by Fraghaly on 11/03/2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyDate: UILabel!
    @IBOutlet weak var weatherState: UILabel!
    var data : WeatherInfo?{
        didSet{
            weatherState.text = "\(data?.weatherStatus ?? ""),\(data?.weatherTemp ?? "")"
            historyDate.text = data?.weatherTime
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
