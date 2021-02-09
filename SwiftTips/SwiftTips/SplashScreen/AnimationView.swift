//
//  AnimationView.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 1/12/21.
//  Copyright © 2021 nguyen.duc.huyb. All rights reserved.
//

import UIKit

let kAnimationImagePrefix = "splash_screen_"
let kAnimationImageSuffix = ".jpg"
let kImageMaxIndex = 59

protocol AnimationViewDelegate: NSObject {
    func animationDidFinished()
}

class AnimationView: UIView, AnimationImageViewDelegate {
    weak var delegate: AnimationViewDelegate?
    private var imageNames: [String] = []
    private var animationView: AnimationImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        imageNames = AnimationView.getImageNames()
        animationView = AnimationImageView(imageNames: self.imageNames)
        animationView?.delegate = self
        animationView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let screenSize = UIScreen.main.bounds.size
        var imageSize: CGSize = .zero
        
        guard let animationView = self.animationView else { return }
        
        if self.imageNames.count > 0 {
            let image = UIImage.init(named: self.imageNames.first!)
            imageSize = image?.size ?? .zero
        }
        
        if imageSize.width < screenSize.width {
            imageSize.height = imageSize.height * screenSize.width / imageSize.width
            imageSize.width = screenSize.width
        }
        
        if imageSize.height < screenSize.height {
            imageSize.width = imageSize.width * screenSize.height / imageSize.width
            imageSize.height = screenSize.height
        }
        
        animationView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        animationView.center = CGPoint(x: screenSize.width / 2.0, y: screenSize.height / 2.0)
        
        self.addSubview(animationView)
    }
    
    static func getImageNames() -> [String] {
        let filePrefix: String = kAnimationImagePrefix
        let fileSuffix: String = kAnimationImageSuffix
        var tmpArray: [String] = []
        for index in 0...kImageMaxIndex {
            let filename = String(format: "%@%d%@", filePrefix, index, fileSuffix)
            tmpArray.append(filename)
        }
        return tmpArray
    }
    
    func startAnimation() {
        self.animationView?.animationDuration = Double(self.imageNames.count) / 30.0
        self.animationView?.startAnimating()
    }
    
    func didFinishAnimationImageView() {
        self.delegate?.animationDidFinished()
    }
}
