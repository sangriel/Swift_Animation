//
//  CardTransitionManager.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


enum CardTransitionType {
    case presentation
    case dismiss
    
}

class CardTransitionManager : NSObject {
    
    private let transitionDuration : Double = 0.8
    private var transition : CardTransitionType = .presentation
    private let shrinkDuration : Double = 0.2
    
    lazy var blurEffectView : UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blur)
        return visualEffectView
    }()
    
    lazy var dimmingView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var whiteView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private func addBackgroundViews(to containerView : UIView){
        blurEffectView.frame = containerView.frame
        blurEffectView.alpha = 0
        containerView.addSubview(blurEffectView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = 0
        containerView.addSubview(dimmingView)
    }
    
    private func makeCardViewCopy(cardView : CardView) -> CardView {
        let cardViewModel = cardView.getViewModel()!
        let copyView = CardView()
        copyView.setViewModel(viewModel: cardViewModel)
        return copyView
    }
    
    private func fetchMainCardListViewController(viewController : UIViewController) -> MainCardListViewController? {
        guard let nav = viewController as? UINavigationController,
              let topViewController = nav.topViewController,
              let mainCardListViewController = topViewController as? MainCardListViewController else { return nil }
        return mainCardListViewController
    }
    
}
extension CardTransitionManager : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
        
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("kdkdk")
        
        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })

        addBackgroundViews(to: containerView)

        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        guard let mainCardListViewController = fetchMainCardListViewController(viewController: transition == .presentation ? fromViewController! : toViewController!),
              let cardView = mainCardListViewController.selectedCardView() else { return }
        


        let cardViewCopy = makeCardViewCopy(cardView: cardView)
        containerView.addSubview(cardViewCopy)
        cardView.alpha = 0
        
        var absoluteCardViewFrame = cardView.convert(cardView.frame, to: nil)
        //CardView가 cell의 top left bottom right 10, 20, 10, 20의 패딩 있어서 조정을 해줘야 함
        absoluteCardViewFrame.origin.x -= 20
        absoluteCardViewFrame.origin.y -= 10
        cardViewCopy.frame = absoluteCardViewFrame
        cardViewCopy.layoutIfNeeded()
        
        if transition == .presentation {
            let detailView = toViewController as! CardDetailViewController
            
            moveAndConvertToCardView(cardView: cardViewCopy, containerView: containerView, yOrigin: detailView.view.frame.origin.y + mainCardListViewController.view.safeAreaInsets.top) {

                transitionContext.completeTransition(true)
            }
        }
        else {
//            let detailView = toViewController as! CardDetailViewController
        }
        
        
    }
    
    func shrinkAnimator(for cardView : CardView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            cardView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.dimmingView.alpha = 0.05
        }
    }
    
    func expandAnimator(for cardView : CardView, in containerView : UIView, yOrigin : CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: CGVector(dx: 4, dy: 4))
        let animator =  UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            cardView.transform = .identity
            cardView.layer.cornerRadius = 0
            cardView.frame.origin.y = yOrigin
            self.blurEffectView.alpha = 1
            containerView.layoutIfNeeded()
        }
        
        return animator
    }
    
    func moveAndConvertToCardView(cardView : CardView, containerView : UIView, yOrigin : CGFloat, completion : @escaping() -> ()){
        let shrinkAnimator = self.shrinkAnimator(for: cardView)
        let expandAnimator = self.expandAnimator(for: cardView, in: containerView, yOrigin: yOrigin)
        
        
        shrinkAnimator.addAnimations {
            cardView.layoutIfNeeded()
            //cardView.updateLayout()
            expandAnimator.startAnimation()
        }
        
        expandAnimator.addAnimations {
            
        }
        
        shrinkAnimator.startAnimation()
    }
    
}
extension CardTransitionManager : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .presentation
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .dismiss
        return self
    }
    
}
