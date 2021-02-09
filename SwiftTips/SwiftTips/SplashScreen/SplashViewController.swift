//
//  SplashViewController.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 2/5/21.
//  Copyright © 2021 nguyen.duc.huyb. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, AnimationViewDelegate {

    @IBOutlet private weak var splashView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView.delegate = self
        splashView.startAnimation()
    }
    
    func animationDidFinished() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        
        appDelegate?.switchRootViewController(viewController: vc)
    }
}
