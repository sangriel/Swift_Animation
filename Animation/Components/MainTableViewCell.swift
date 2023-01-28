//
//  MainTableViewCell.swift
//  Animation
//
//  Created by sangmin han on 2023/01/27.
//

import Foundation
import UIKit

class MainTableViewCell : UITableViewCell {
    
    static let cellId = "cellId"
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
