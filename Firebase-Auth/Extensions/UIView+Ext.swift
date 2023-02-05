//
//  UIView+Ext.swift
//  Firebase-Auth
//
//  Created by emre usul on 5.02.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func animateButton() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.25,
                       options: .curveEaseIn) {
            
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            self.alpha = 0.5
        } completion: { (_) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 0.25,
                           options: .curveEaseIn) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.alpha = 1
            }
        }

    }
    
}
