//
//  SpinningLoadingView.swift
//  Animation
//
//  Created by sangmin han on 2023/01/27.
//

import Foundation
import UIKit


class SpinningLoadingView : UIViewController {
    
    
    let shapeLayer = CAShapeLayer()
    let replicator = CAReplicatorLayer()
    
    
    let starImage = UIImage(named: "starFilled")
    lazy var points : [CGPoint] =  [CGPoint(x: self.view.center.x, y: 0),
                                    CGPoint(x: self.view.center.x, y: self.view.center.y - 120)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .black
        
        setShapeLayer()
        animateTopToCenter()
        
    }
    
    
    
    func setShapeLayer(){
        shapeLayer.frame = self.view.frame
        shapeLayer.frame.size = CGSize(width: 30, height: 30)
        shapeLayer.position = points[0]
        guard let image = starImage?.cgImage else { return }
        shapeLayer.contents = image
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    
    func animateTopToCenter(){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.delegate = self
        animation.fromValue = points[0]
        animation.toValue = points[1]
        animation.duration = 1.2
        shapeLayer.position = points[1]
        shapeLayer.add(animation, forKey: nil)
        
    }
    
    func setReplicator(){
        
        replicator.addSublayer(shapeLayer)
        
        let cirlce = CGFloat.pi * 2
        let angle = cirlce / CGFloat(20)
        replicator.instanceCount = 20
        replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicator.frame = self.view.frame
        shapeLayer.position = CGPoint(x: self.view.center.x , y: self.view.center.y - 120)
       
        let delay = TimeInterval(2)
        replicator.instanceDelay = delay / 20
        replicator.instanceAlphaOffset = -0.05
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAReplicatorLayer.instanceAlphaOffset))
        animation.fromValue = -0.05
        animation.toValue = 0
        animation.duration = delay
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.isRemovedOnCompletion = false
        replicator.add(animation, forKey: "replicator")
        
        
        let animation2 = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation2.fromValue = 0
        animation2.toValue = 0.8
        animation2.duration = delay
        animation2.speed = 1
        animation2.timingFunction = CAMediaTimingFunction(name: .linear)
        animation2.repeatCount = .infinity
        shapeLayer.add(animation2, forKey: nil)
    
        
        self.view.layer.addSublayer(replicator)
    }
    
    func animateRotation(){
//        let animation = CABasicAnimation(keyPath: "rotate")
    }
    
    
}
extension SpinningLoadingView : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == replicator.animation(forKey: "replicator") {
            print("dd")
            replicator.instanceAlphaOffset = 0
        }
        else {
            setReplicator()
        }
        
    }
    
    
}
