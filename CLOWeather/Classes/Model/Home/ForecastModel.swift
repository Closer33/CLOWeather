//
//  ForecastModel.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class ForecastModel: NSObject {
    
    @objc var date: String?
    @objc var sunrise: String?
    @objc var high: String?
    @objc var low: String?
    @objc var sunset: String?
    @objc var aqi: Int = 0
    @objc var fx: String?
    @objc var fl: String?
    @objc var type: String?
    @objc var notice: String?

    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
