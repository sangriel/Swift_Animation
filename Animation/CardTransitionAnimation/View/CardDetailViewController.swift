//
//  CardDetailViewController.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


class CardDetailViewController : UIViewController {
    
    
    
    private let backBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(white: 1, alpha: 0.5)
        makebackBtn()
        
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
    }
    
    @objc
    func backBtnTapped(sender : UIButton){
        self.dismiss(animated: true)
    }
    
    
    
}
extension CardDetailViewController {
    private func makebackBtn(){
        self.view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.imageView?.contentMode = .scaleAspectFit
        
    }
    
}
