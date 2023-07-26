//
//  SettingsViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol SettingsViewControllerInterface: AnyObject {

}

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterInterface?

    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        debugPrint("SettingsViewController deinited")
    }
    
    // MARK: - AddSubview And Constraints
    
    private func setupView() {
        addSubviews()
        addConstraints()
        view.backgroundColor = .backgroundColor
    }
 
    private func addSubviews() {
        view.addSubviews()
    }
    
    private func addConstraints() {
        
    }
}

extension SettingsViewController: SettingsViewControllerInterface {

}
