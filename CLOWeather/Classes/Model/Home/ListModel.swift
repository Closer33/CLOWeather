//
//  ListModel.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    
    var city: String?
    @objc var shidu: String?
    @objc var pm25: Int = 0
    @objc var pm10: Int = 0
    @objc var quality: String?
    @objc var wendu: Int = 0
    @objc var ganmao: String?
    @objc var forecast: [ForecastModel]?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "forecast" {
            var array = [ForecastModel]()
            for dict in (value as! [[String: Any]]) {
                let model = ForecastModel(dict: dict)
                array.append(model)
            }
            forecast = array
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
