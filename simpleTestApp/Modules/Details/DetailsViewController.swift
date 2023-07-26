//
//  DetailsViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import UIKit

protocol DetailsViewControllerInterface: AnyObject {
    func reloadCollection()
}

final class DetailsViewController: UIViewController {
    var presenter: DetailsPresenterInterface?
    
    private lazy var headerView: TransparentHeader = {
        let headerView = TransparentHeader(type: .crossButton)
        headerView.leftButtonTappedCallback = { [weak self] in
            self?.presenter?.headerLeftButtonPressed()
        }
        headerView.setupTitle(title: R.string.localizable.tabBatItemsCollection())
        return headerView
    }()
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<DetailsSectionType, DetailsCellModel>?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset.top = 60
        collectionView.contentInset.bottom = 40
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(classCell: DetailsTopCell.self)
        collectionView.register(classCell: DetailsBottomCell.self)
        return collectionView
    }()

    // MARK: - Lifecycle
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createCollectionViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.reinitBlurView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView.releaseBlurAnimation()
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
    
    // MARK: - SetupCollecctionData
    private func createCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                      cellProvider: { [weak self] _, indexPath, model in
            
            switch model {
            case .top(carInfo: let info):
                let cell = self?.collectionView.reusableCell(classCell: DetailsTopCell.self, indexPath: indexPath)
                cell?.setup(model: info)
                return cell
            case .bottom(post: let post):
                let cell = self?.collectionView.reusableCell(classCell: DetailsBottomCell.self, indexPath: indexPath)
                cell?.setup(model: post)
                return cell
            }
        })
    }
    
    private func reloadData() {
        guard let presenter = presenter else { return }
        var snapshot = NSDiffableDataSourceSnapshot<DetailsSectionType, DetailsCellModel>()
        let sections = presenter.getSectionModel()

        snapshot.appendSections(sections)
        for section in sections {
            switch section {
            case .top:
                guard let topCellModel = presenter.getTopCells() else { return }
                snapshot.appendItems([topCellModel], toSection: section)
            case .bottom:
                guard let bottomCellModel = presenter.getBottomCells() else { return }
                snapshot.appendItems(bottomCellModel, toSection: section)
            }
        }
        collectionViewDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = presenter?.getSectionModel() else { return CGSize(width: 100, height: 100) }
        switch model[indexPath.section] {
        case .top:
            return CGSize(width: view.frame.width - 40, height: 150)
        case .bottom:
            return CGSize(width: (view.frame.width - 60) / 2, height: 250)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        guard position > (collectionView.contentSize.height - scrollView.frame.size.height - 100) else { return }
        presenter?.infinityScrollAction()
    }
    
}

extension DetailsViewController: DetailsViewControllerInterface {
    func reloadCollection() {
        reloadData()
    }
}
