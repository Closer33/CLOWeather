//
//  SearchViewController.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func addCity(name: String)
}

class SearchViewController: UIViewController {
    
    fileprivate let kTableViewCellID = "kTableViewCellID"
    
    weak var delegate: SearchViewControllerDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    fileprivate lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        let view = search.searchBar.subviews.first
        let backImageView = view?.subviews.first
        backImageView?.removeFromSuperview()
        return search
    }()
    
    fileprivate lazy var dataArr: [String] = {
        guard let path = Bundle.main.path(forResource: "city", ofType: "plist") else {
            return []
        }
        let array = NSArray(contentsOfFile: path) as! [String]
        return array
    }()
    
    fileprivate lazy var resultArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.perform(#selector(showKeyboard), with: nil, afterDelay: 0)
    }
    
    @objc private func showKeyboard() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        searchController.searchBar.showsCancelButton = true
        tableView.tableHeaderView = searchController.searchBar as UIView
    }
}

// MARK: tableView 数据源 代理
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return resultArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        if searchController.isActive {
            cell.textLabel?.text = self.resultArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.addCity(name: resultArr[indexPath.row])
        searchController.isActive = false
        dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let inputStr = searchController.searchBar.text
        resultArr.removeAll()
        for str in dataArr {
            if (str as NSString).range(of: inputStr!).location < 1 {
                resultArr.append(str)
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
}

