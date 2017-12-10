//
//  HomeViewController.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate let kTableViewCellID = "kTableViewCellID"
    
    // 懒加载 tableView
    fileprivate lazy var tableView: UITableView = {
        var tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: kTableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    // 懒加载 HomeTableFooterView
    private lazy var homeTableFooterView: HomeTableFooterView = {
        let view = UINib.init(nibName: "HomeTableFooterView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HomeTableFooterView
        view.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 70)
        return view
    }()
    
    fileprivate var dataArr = [ListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initData()
    }
    
    private func setupUI() {
        view.addSubview(tableView);
        tableView.frame = view.frame;
        tableView.tableFooterView = homeTableFooterView
    }

    private func initData(_ city: String? = "武汉") {
        NetworkTools.requrestData(.get, URLString: "http://www.sojson.com/open/api/weather/json.shtml", parameters: ["city": city!]) { (result) in
            let result2 = result as! [String: Any]
            let result3 = result2["data"] as! [String: Any]
            let listModel = ListModel(dict: result3)
            listModel.city = result2["city"] as? String
            self.dataArr.append(listModel)
            self.tableView.reloadData()
        }
    }
}

// MARK: tableView 数据源协议
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellID, for: indexPath) as! HomeTableViewCell
        cell.listModel = dataArr[indexPath.row]
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    // 设置行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        DispatchQueue.main.async {
            vc.dataArr = self.dataArr
            vc.currentIndex = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

// MARK: HomeTableFooterViewDelegate
extension HomeViewController: HomeTableFooterViewDelegate {
    
    func showSearchView() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
}

// MARK: SearchViewControllerDelegate
extension HomeViewController: SearchViewControllerDelegate {
    
    func addCity(name: String) {
        initData(name)
    }
}

