//
//  SettingsViewController.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import MessageUI
import StoreKit
import UIKit

protocol SettingsViewControllerInterface: AnyObject {
    func showRateUs()
    func showAlert(title: String, subtitle: String)
    func reloadCollection()
    func contactUsAction()
}

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterInterface?
    
    var dataSource: [SettingsCellType] {
        guard let sectionModel = presenter?.getSectionsModel() else { return [] }
        return sectionModel
    }
    
    private lazy var headerView: TransparentHeader = {
        let headerView = TransparentHeader(type: .crossButton)
        headerView.setupTitle(title: R.string.localizable.settings().uppercased())
        headerView.leftButtonTappedCallback = { [weak self] in
            self?.presenter?.headerLeftButtonPressed()
        }
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.contentInset.top = 20
        collectionView.register(classCell: SettingsDefaultCell.self)
        return collectionView
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView.releaseBlurAnimation()
    }
    
    deinit {
        debugPrint("SettingsViewController deinited")
    }
    
    // MARK: - AddSubview And Constraints
    
    private func setupView() {
        addSubviews()
        addConstraints()
        view.backgroundColor = .green
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
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.reusableCell(classCell: SettingsDefaultCell.self, indexPath: indexPath)
        cell.setup(type: dataSource[indexPath.row])
        return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            presenter?.cellSelected(cellType: dataSource[indexPath.row])
        }
}
    

extension SettingsViewController: SettingsViewControllerInterface {
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func showAlert(title: String, subtitle: String) {
        alertOk(title: title, message: subtitle)
    }
    
    func showRateUs() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
    
    func contactUsAction() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["pochta"])
            mail.setMessageBody("<p>Hey! I have some questions!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Send mail not allowed")
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
}
