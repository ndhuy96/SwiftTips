//
//  UITabBarController+Hidable.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 9/7/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

import UIKit

let kAnimationDuration = 0.3

extension UITabBarController {
    func setTabBar(hidden: Bool, animated: Bool) {
        let animationDuration = animated ? kAnimationDuration : 0
        UIView.animate(withDuration: animationDuration, animations: {
            var frame = self.tabBar.frame
            frame.origin.y = self.view.frame.height
            if !hidden {
                frame.origin.y -= frame.height
            } else {
                let backgroundImageSize = self.tabBar.backgroundImage?.size ?? CGSize.zero
                let heightDiff: CGFloat = backgroundImageSize.height - frame.height
                // If background image size is large, tabBar top seem.
                if heightDiff > 0 {
                    frame.origin.y += heightDiff
                }
            }
            self.tabBar.frame = frame
        }, completion:nil)
    }
}
