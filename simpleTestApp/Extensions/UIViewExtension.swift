//
//  UIViewExtension.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 25.07.2023.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func fadeOut(duration: Double = 0.2,compl: (() -> Void)? = nil) {
        if self.alpha == 1 {
            let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
                self.alpha = 0
            }
            animator.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                compl?()
            }
        }
    }
    
    func fadeIn(duration: Double = 0.2) {
        if self.alpha == 0 {
            let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
                self.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func asImage(x: Double, y: Double, paddingX: Double, paddingY: Double) -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: CGRect(x: x,
                                                                  y: y, width: bounds.width + paddingX, height: bounds.height + paddingY))
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
