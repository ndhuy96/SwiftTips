//
//  ViewController.swift
//  SwiftTips
//
//  Created by nguyen.duc.huyb on 9/13/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private var wheelView: Spinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func spinButtonTapped(_ sender: Any) {
        let randomAngle = CGFloat.pi * CGFloat.random(in: 0...2)
        wheelView.angle = randomAngle
        wheelView.startRotating()
    }
}
