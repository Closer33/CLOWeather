//
//  HomeTableViewCell.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    
    var listModel: ListModel? {
        didSet {
            cityName.text = listModel?.city
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: date)
            time.text = timeStr
            let temperatureStr = "\(listModel?.wendu ?? 0)°"
            temperature.text = temperatureStr
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
