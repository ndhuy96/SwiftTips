//
//  AnimationImageView.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 1/12/21.
//  Copyright © 2021 nguyen.duc.huyb. All rights reserved.
//

import UIKit

protocol AnimationImageViewDelegate: NSObject {
    func didFinishAnimationImageView()
}

class AnimationImageView: UIImageView {
    
    private var imageNames: [String] = []
    private var timer = Timer()
    private var imageIndex: Int!
    weak var delegate: AnimationImageViewDelegate!
    
    init(imageNames: [String]) {
        super.init(frame: .zero)
        self.imageNames = imageNames
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // override
    override func startAnimating() {
        if self.timer.isValid {
            self.stopAnimating()
        }
        
        self.imageIndex = 0
        let timerInterval = self.animationDuration / Double(self.imageNames.count)
        self.timer = Timer.scheduledTimer(timeInterval: timerInterval,
                                          target: self,
                                          selector: #selector(timerDidFire),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    // override
    override func stopAnimating() {
        if self.timer.isValid {
            self.timer.invalidate()
        }
    }
    
    @objc
    private func timerDidFire() {
        if self.imageIndex >= self.imageNames.count {
            self.finishAnimating()
        } else {
            self.setCurrentImageAndIncreaseIndex()
        }
    }
}

private extension AnimationImageView {
    func setCurrentImageAndIncreaseIndex() {
        self.setImageByImageIndex(imageIndex: self.imageIndex)
        self.imageIndex+=1
    }
    
    func setImageByImageIndex(imageIndex: Int) {
        if imageIndex >= self.imageNames.count {
            return
        }
        let bundlePath: String = Bundle.main.bundlePath
        let filePath: String = bundlePath.stringByAppendingPathComponent(path: self.imageNames[imageIndex])
        let nextImage: UIImage = UIImage(contentsOfFile: filePath)!
        self.image = nextImage
    }
    
    func finishAnimating() {
        self.stopAnimating()
        self.delegate.didFinishAnimationImageView()
    }
}
