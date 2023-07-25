//
//  LaunchScreenSlider.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 25.07.2023.
//

import Foundation
import UIKit

class LaunchScreenSlider: UISlider {
    
    init(minimumColor: UIColor, maximumColor: UIColor, frame: CGRect) {
        super.init(frame: frame)

        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 14
        circleView.layer.shadowColor = UIColor.black.withAlphaComponent(0.07).cgColor
        circleView.layer.shadowOpacity = 1
        circleView.layer.shadowRadius = 4
        circleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let circleImage = circleView.asImage(x: 0.0, y: 0.0, paddingX: 0.0, paddingY: 0.0)
        
       // setThumbImage(nil, for: .normal)
        minimumTrackTintColor = minimumColor.withAlphaComponent(0.8)
        maximumTrackTintColor = maximumColor.withAlphaComponent(0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UISlider {

    var thumbCenterX: CGFloat {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value).midX
    }
}
