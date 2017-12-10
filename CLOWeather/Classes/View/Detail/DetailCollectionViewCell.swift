//
//  DetailCollectionViewCell.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/10.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var wendu: UILabel!
    @IBOutlet weak var date0: UILabel!
    @IBOutlet weak var high0: UILabel!
    @IBOutlet weak var low0: UILabel!
    @IBOutlet weak var notice: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var quality: UILabel!
    @IBOutlet weak var shidu: UILabel!
    @IBOutlet weak var date1: UILabel!
    @IBOutlet weak var low1: UILabel!
    @IBOutlet weak var high1: UILabel!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var low2: UILabel!
    @IBOutlet weak var high2: UILabel!
    @IBOutlet weak var date3: UILabel!
    @IBOutlet weak var low3: UILabel!
    @IBOutlet weak var high3: UILabel!
    @IBOutlet weak var date4: UILabel!
    @IBOutlet weak var low4: UILabel!
    @IBOutlet weak var high4: UILabel!
    @IBOutlet weak var ganmao: UILabel!
    
    var model: ListModel? {
        didSet {
            guard let model = model else {
                return
            }
            city.text = model.city
            type.text = model.forecast![0].type
            wendu.text = "\(model.wendu)°"
            date0.text = getDate(date: model.forecast![0].date!)
            low0.text = getWendu(wendu: model.forecast![0].low!)
            high0.text = getWendu(wendu: model.forecast![0].high!)
            notice.text = model.forecast![0].notice
            sunrise.text = model.forecast![0].sunrise
            sunset.text = model.forecast![0].sunset
            quality.text = model.quality
            shidu.text = model.shidu
            date1.text = getDate(date: model.forecast![1].date!)
            low1.text = getWendu(wendu: model.forecast![1].low!)
            high1.text = getWendu(wendu: model.forecast![1].high!)
            date2.text = getDate(date: model.forecast![2].date!)
            low2.text = getWendu(wendu: model.forecast![2].low!)
            high2.text = getWendu(wendu: model.forecast![2].high!)
            date3.text = getDate(date: model.forecast![3].date!)
            low3.text = getWendu(wendu: model.forecast![3].low!)
            high3.text = getWendu(wendu: model.forecast![3].high!)
            date4.text = getDate(date: model.forecast![4].date!)
            low4.text = getWendu(wendu: model.forecast![4].low!)
            high4.text = getWendu(wendu: model.forecast![4].high!)
            ganmao.text = model.ganmao
        }
    }

    private func getDate(date: String) -> String {
        let index = date.index(date.endIndex, offsetBy: -3)
        return String(date[index..<date.endIndex])
    }
    
    private func getWendu(wendu: String) -> String {
        let index = wendu.index(wendu.startIndex, offsetBy: 3)
        let str = String(wendu[index..<wendu.endIndex])
        return str.components(separatedBy: ".")[0]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}
