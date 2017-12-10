//
//  DetailViewController.swift
//  CLOWeather
//
//  Created by yinquan on 2017/12/9.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bottomView: UIView!
    var dataArr = [ListModel]()
    var currentIndex: Int = 0
    
    
    private let kCollectionViewCellID = "kCollectionViewCellID"
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 44)
        layout.scrollDirection = .horizontal
        var rect = UIScreen.main.bounds
        rect.size.height -= 44
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.backgroundColor = UIColor.randomColor()
        view.addSubview(collectionView)
        pageControl.numberOfPages = dataArr.count
        pageControl.currentPage = currentIndex
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: false)
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath) as! DetailCollectionViewCell
        cell.backgroundColor = UIColor.randomColor()
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let number = collectionView.contentOffset.x / view.frame.width
        print(collectionView.contentOffset.x)
        pageControl.currentPage = Int(number)
    }
}
