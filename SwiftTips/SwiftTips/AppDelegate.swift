//
//  AppDelegate.swift
//  SwiftTips
//
//  Created by nguyen.duc.huyb on 9/13/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func switchRootViewController(viewController: UIViewController) {
        guard let window = self.window else { return }
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            viewController.view.addSubview(snapShot)
        }
        window.rootViewController = viewController
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        snapShot?.layer.opacity = 0
                       },
                       completion: { _ in
                        snapShot?.removeFromSuperview()
                       })
    }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
    }
}
