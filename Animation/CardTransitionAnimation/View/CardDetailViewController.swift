//
//  CardDetailViewController.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


class CardDetailViewController : UIViewController {
    
    
    private let scrollView = UIScrollView()
    private var cardView : CardView?
    private let label = UILabel()
    private let backBtn = UIButton()
    
    private let cardViewModel : CardViewModel
    
    lazy private var snapShotView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor.blue.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.isHidden = true
        return imageView
    }()
    
    init(cardViewModel : CardViewModel){
        self.cardViewModel = cardViewModel
        super.init(nibName: nil, bundle: nil)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makebackBtn()
        makescrollView()
        makecardView()
        makelabel()
        
        
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.bringSubviewToFront(backBtn)
    }
    
    func getCardViewFrame() -> CGRect {
        return self.cardView!.convert(cardView!.frame, to: nil)
    }
    @objc
    func backBtnTapped(sender : UIButton){
        if let nav = self.navigationController {
            print("pop")
            nav.popViewController(animated: true)
        }
        else {
            print("dismiss")
            self.dismiss(animated: true)
        }
        
    }
    
    
    func createSnapShot() {
        let snapShot = self.view.createSnapshot()
        snapShotView.image = snapShot
        scrollView.addSubview(snapShotView)
        snapShotView.frame = scrollView.frame
        
    }
    
    
    
}
extension CardDetailViewController {
    private func makebackBtn(){
        self.view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.imageView?.contentMode = .scaleAspectFit
        
    }
    private func makescrollView(){
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.delegate = self
        
    }
    private func makecardView(){
        cardView = CardView()
        guard let cardView = cardView else {
            assertionFailure("no CardView")
            return
        }
        cardView.setViewModel(viewModel: cardViewModel)
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    private func makelabel(){
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: cardView!.bottomAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10).isActive = true
        label.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -10).isActive = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.text = """
What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.

Where can I get some?
There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.
"""
    }
    
    
}
extension CardDetailViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let dismissalYpoint : CGFloat = 20
        var yContentOffset = scrollView.contentOffset.y
        let topPadding = self.view.safeAreaInsets.top
        print(yContentOffset)
        yContentOffset += topPadding
        
        if scrollView.isTracking {
            scrollView.bounces = true
        }
        else {
            scrollView.bounces = yContentOffset > 500
        }
        
        if yContentOffset < 0 && scrollView.isTracking {
            hideContents()
            snapShotView.isHidden = false
            
            let xscale = (100 + yContentOffset ) / 100
            let yscale = 0
            snapShotView.transform = CGAffineTransform(scaleX: xscale, y: xscale)

            snapShotView.layer.cornerRadius = max(20, abs(yContentOffset))
            
            if dismissalYpoint + yContentOffset <= 0 {
                self.dismiss(animated: true)
            }
        }
        else {
            showContents()
            snapShotView.isHidden = true
        }
    }
    
    func hideContents(){
        cardView?.isHidden = true
        label.isHidden = true
    }
    func showContents(){
        cardView?.isHidden = false
        label.isHidden = false
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = true
    }
}
