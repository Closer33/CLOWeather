//
//  HomeTableFooterView.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

protocol HomeTableFooterViewDelegate: class {
    func showSearchView()
}

class HomeTableFooterView: UIView {
    
    weak var delegate: HomeTableFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    @IBAction func openWeb(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://baidu.weather.com.cn/mweather/101200101.shtml")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func addCity(_ sender: Any) {
        delegate?.showSearchView()
    }
    
    

}
