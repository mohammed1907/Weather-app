//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    var searchData : String? {
        didSet{
            cityName.text = searchData
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
