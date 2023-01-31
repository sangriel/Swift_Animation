//
//  UIView+Extension.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit

extension UIView {
    
    func createSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
