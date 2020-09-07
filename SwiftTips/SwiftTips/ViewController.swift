//
//  ViewController.swift
//  SwiftTips
//
//  Created by nguyen.duc.huyb on 9/13/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        // CollectionView's Settings
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        // NavigationController's Settings
        title = "Navigation Bar"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor (red: 1.0/255.0, green: 1.0/255.0, blue: 1.0/255.0, alpha: 0)]
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as UICollectionViewCell
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 300)
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 1 {
            offset = 1
        }
        
        let whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: offset)
        let blackColor = UIColor (red: 1.0/255.0, green: 1.0/255.0, blue: 1.0/255.0, alpha: offset)
        navigationController?.navigationBar.tintColor = blackColor
        navigationController?.navigationBar.backgroundColor = whiteColor
        UIApplication.shared.statusBarView?.backgroundColor = whiteColor
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: blackColor]
    }
}
