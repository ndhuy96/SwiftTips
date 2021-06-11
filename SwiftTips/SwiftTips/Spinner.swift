//
//  Spinner.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 6/8/21.
//  Copyright © 2021 nguyen.duc.huyb. All rights reserved.
//

import UIKit

class Spinner: UIImageView {
    // Default angle
    var angle: CGFloat = CGFloat.pi * 2
    
    // Duration of one rotation
    var duration: CFTimeInterval = 0.8
    
    // Number of loop rotation
    var numOfLoop: CGFloat = 5.0
    
    private var isRotating: Bool = false
    private var beforeAngle: CGFloat = 0
    private var currentAngle: CGFloat = 0
}

extension Spinner {
    func startRotating() {
        if self.isRotating == false {
            rotate()
            self.isRotating = true
        }
    }
    
    private func rotate() {
        // Get the current rotation value
        let rotationAtStart: CGFloat = self.layer.value(forKeyPath: "transform.rotation") as! CGFloat
        
        currentAngle = angle - beforeAngle
        
        // Create animation
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = rotationAtStart
        rotation.toValue = rotationAtStart + currentAngle + (numOfLoop * 2 * CGFloat.pi)
        rotation.duration = Double(currentAngle / (CGFloat.pi * 2)) * duration + (duration * Double(numOfLoop))
        rotation.delegate = self
        rotation.isRemovedOnCompletion = true
        rotation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        self.layer.add(rotation, forKey: nil)
    }
    
    private func setRotationTransform() {
        // Create rotation transform with given degree
        let myRotationTransform = CATransform3DRotate(self.layer.transform, currentAngle, 0.0, 0.0, 1.0)
        // Set layer's transform value to target value
        self.layer.transform = myRotationTransform
    }
    
    private func reset() {
        beforeAngle = angle
        self.isRotating = false
    }
}

extension Spinner: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        setRotationTransform()
        reset()
    }
}
