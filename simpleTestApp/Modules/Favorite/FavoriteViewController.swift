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
    
    private lazy var headerView: TransparentHeader = {
        let headerView = TransparentHeader(type: .none)
        headerView.setupTitle(title: R.string.localizable.tabBatItemsFavorite())
        return headerView
    }()

    // MARK: - Lifecycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - AddSubview And Constraints
    
    private func setupView() {
        addSubviews()
        addConstraints()
        view.backgroundColor = .backgroundColor
    }
 
    private func addSubviews() {
        view.addSubviews(headerView)
    }
    
    private func addConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
}

extension FavoriteViewController: FavoriteViewControllerInterface {

}
