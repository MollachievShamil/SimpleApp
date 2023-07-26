//
//  CollectionViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol CollectionViewControllerInterface: AnyObject {
    func reloadCollection()
}

final class CollectionViewController: UIViewController {
    var presenter: CollectionPresenterInterface?
    
    private enum Section {
        case main
    }
    
    private lazy var headerView: TransparentHeader = {
        let headerView = TransparentHeader(type: .menu)
        headerView.leftButtonTappedCallback = { [weak self] in
            self?.presenter?.headerLeftButtonPressed()
        }
        headerView.setupTitle(title: R.string.localizable.tabBatItemsCollection())
        return headerView
    }()
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, MainCollectionCellModel>?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset.top = 60
        collectionView.contentInset.bottom = 40
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(classCell: MainCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        createCollectionViewDataSource()
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
        view.addSubviews(collectionView, headerView)
    }
    
    private func addConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - CreateDataSource
    private func createCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                      cellProvider: { [weak self] _, indexPath, model in
            let cell = self?.collectionView.reusableCell(classCell: MainCollectionViewCell.self, indexPath: indexPath)
            cell?.setup(model: model)
            return cell
        })
    }
    
    private func reloadData() {
        guard let presenter = presenter else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, MainCollectionCellModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(presenter.getSectionModel(), toSection: .main)
        collectionViewDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: view.frame.width - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.cellSelected(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        guard position > (collectionView.contentSize.height - scrollView.frame.size.height - 100) else { return }
        presenter?.infinityScrollAction()
    }
}

extension CollectionViewController: CollectionViewControllerInterface {
    func reloadCollection() {
        reloadData()
    }
}
