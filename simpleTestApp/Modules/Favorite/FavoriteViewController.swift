//
//  FavoriteViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol FavoriteViewControllerInterface: AnyObject {

}

final class FavoriteViewController: UIViewController {
    var presenter: FavoritePresenterInterface?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - AddSubview And Constraints
    
    private func setupView() {
        addSubviews()
        addConstraints()
    }
 
    private func addSubviews() {
        view.addSubviews()
    }
    
    private func addConstraints() {
        
    }
}

extension FavoriteViewController: FavoriteViewControllerInterface {

}
