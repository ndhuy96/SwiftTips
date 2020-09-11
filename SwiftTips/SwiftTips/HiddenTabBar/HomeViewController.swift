//
//  HomeViewController.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 9/8/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var startContentOffset: CGFloat!
    private var lastContentOffset: CGFloat!
    private var isHidingTabBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }

        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let safeAreaInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                        left: 0,
                                                        bottom: self.tabBarController?.view.safeAreaInsets.bottom ?? 0,
                                                        right: 0)
        tableView.contentInset = safeAreaInsets
        tableView.scrollIndicatorInsets = safeAreaInsets
    }
    
    func hideTabBarIfNeeded() {
        guard !self.isHidingTabBar else { return }
        self.isHidingTabBar = true
        self.tabBarController?.setTabBar(hidden: true, animated: true)
    }
    
    func showTabBarIfNeeded() {
        guard self.isHidingTabBar else { return }
        self.isHidingTabBar = false
        self.tabBarController?.setTabBar(hidden: false, animated: true)
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 32
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        cell.textLabel?.text = "Hello World"
        return cell
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        self.startContentOffset = contentOffsetY
        self.lastContentOffset = contentOffsetY
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let differentFromStart = self.startContentOffset - currentOffset
        let differentFromLast = self.lastContentOffset - currentOffset
        self.lastContentOffset = currentOffset
        if (differentFromStart < 0) {
            if (scrollView.isTracking && abs(differentFromLast) > 1) {
                self.hideTabBarIfNeeded()
            }
        } else {
            if (scrollView.isTracking && (abs(differentFromLast) > 1)) {
                self.showTabBarIfNeeded()
            }
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        self.showTabBarIfNeeded()
        return true
    }
}
