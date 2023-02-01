//
//  UIView+Extension.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit

extension UIView {
    
    func createSnapshot(withFrame : CGRect?,size : CGSize?) -> UIImage? {
        if let size = size {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
        }
        else {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        }
        if let selectedFrame = withFrame {
            drawHierarchy(in: selectedFrame, afterScreenUpdates: true)
        }
        else {
            
            drawHierarchy(in: frame, afterScreenUpdates: true)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
