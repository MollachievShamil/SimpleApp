//
//  CollectionViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol CollectionViewControllerInterface: AnyObject {

}

final class CollectionViewController: UIViewController {
    var presenter: CollectionPresenterInterface?
    
    private lazy var headerView: TransparentHeader = {
        let headerView = TransparentHeader()
        headerView.leftButtonTappedCallback = { [weak self] in
            self?.presenter?.headerLeftButtonPressed()
        }
        headerView.setupTitle(title: R.string.localizable.tabBatItemsCollection())
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.reinitBlurView()
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

extension CollectionViewController: CollectionViewControllerInterface {

}
