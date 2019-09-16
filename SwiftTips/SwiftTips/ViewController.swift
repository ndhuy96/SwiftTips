//
//  ViewController.swift
//  SwiftTips
//
//  Created by nguyen.duc.huyb on 9/13/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageTopConstraint: NSLayoutConstraint!
    private var originalHeight: CGFloat!
    
    private var blurEffectView: UIVisualEffectView!
    private var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        originalHeight = 300
        
        setupVisualEffectBlur()
    }
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            
            let blurEffect = UIBlurEffect(style: .regular)
            self.blurEffectView = UIVisualEffectView(effect: blurEffect)
            self.imageView.addSubview(self.blurEffectView)
            self.setupConstraints()
        })
    }
    
    private func setupConstraints() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        
        if scrollView == self.scrollView {
            if offset < 0 {
                currentTop = offset
                imageHeightConstraint.constant = originalHeight - offset
                animator.fractionComplete = abs(offset) / 100
            } else {
                imageHeightConstraint.constant = originalHeight
                animator.fractionComplete = 0
            }
            imageTopConstraint.constant = currentTop
        }
    }
}
