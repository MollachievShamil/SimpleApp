//
//  TabBarViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 25.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol TabBarViewControllerInterface: AnyObject {

}

class TabBarViewController: UITabBarController {
    var presenter: TabBarPresenterInterface?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTabBarAppearance()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTabBarSizeAndPosition()
    }
    
    private func configureView() {
        tabBar.itemPositioning = .centered
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .darkGray
        tabBar.itemWidth = 72
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .systemBackground
    }
    
    // MARK: - TAB BAR APPEARANCE
    private func configureTabBarAppearance() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if UIDevice.isSmallDevice {
            y = 12
            x = -16
        } else {
            y = 19
            x = -24
        }
        
        let tabWidth = UIScreen.main.bounds.width
        let tabHeight: CGFloat = 108
        let tabRect = CGRect(x: x, y: tabBar.bounds.minY - y, width: tabWidth, height: tabHeight)
        
        let roundedLayer = CAShapeLayer()
        let beizerPath = UIBezierPath(roundedRect: tabRect, cornerRadius: 32)
        
        roundedLayer.shadowColor = UIColor(red: 0.11, green: 0.25, blue: 0.55, alpha: 0.25).cgColor
        roundedLayer.shadowOffset = CGSize(width: 0, height: 2)
        roundedLayer.shadowRadius = 8
        roundedLayer.shadowOpacity = 0.5
        
        roundedLayer.path = beizerPath.cgPath
        roundedLayer.fillColor = UIColor.white.cgColor
        
        tabBar.layer.insertSublayer(roundedLayer, at: 0)
    }
    
    private func configureTabBarSizeAndPosition() {
        if UIDevice.isSmallDevice {
            tabBar.frame.size.width = UIScreen.main.bounds.width - 32
            tabBar.frame.origin.x = 16
        } else {
            tabBar.frame.size.width = UIScreen.main.bounds.width - 48
            tabBar.frame.origin.x = 24
        }
        
        tabBar.items?.forEach({ item in
            if UIDevice.isSmallDevice {
                item.titlePositionAdjustment = .init(horizontal: 0, vertical: -15)
                item.imageInsets = .init(top: -6, left: 0, bottom: 6, right: 0)
            }
        })
    }
}

extension TabBarViewController: TabBarViewControllerInterface {

}
