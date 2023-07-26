//
//  SettingsPresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import ApphudSDK
import UIKit

protocol SettingsPresenterInterface: AnyObject {
    func headerLeftButtonPressed()
    func getSectionsModel() -> [SettingsCellType]
    func cellSelected(cellType: SettingsCellType)
}

final class SettingsPresenter {
    
    unowned var view: SettingsViewControllerInterface
    let router: SettingsRouterInterface?
    let interactor: SettingsInteractorInterface?
    
    init(
        interactor: SettingsInteractorInterface,
        router: SettingsRouterInterface,
        view: SettingsViewControllerInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SettingsPresenter: SettingsPresenterInterface {
    func getSectionsModel() -> [SettingsCellType] {
        interactor?.getSectionsModel() ?? []
    }
    
    func headerLeftButtonPressed() {
        router?.dismiss()
    }
    
    func cellSelected(cellType: SettingsCellType) {
        switch cellType {
        case .restore:
            restoreTapped()
        case .rateUs:
            view.showRateUs()
        case .contact:
            view.contactUsAction()
        case .termsOfUse:
            termsDidTap()
        case .privacy:
            privacyTapped()
        }
    }
    
    private func privacyTapped() {
        guard
            let url = URL(
                string: "https://www.apple.com"
            ),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func termsDidTap() {
        guard let url = URL(
            string: "https://www.apple.com"
        ),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func restoreTapped() {
        Apphud.restorePurchases { [weak self] subscriptions, _, error in
            if let error = error {
                self?.view.showAlert(title: R.string.localizable.settingsError(),
                                     subtitle: error.localizedDescription)
            }
            
            if subscriptions?.first?.isActive() ?? false {
                self?.view.reloadCollection()
                return
            }
            
            if Apphud.hasActiveSubscription() {
                self?.view.reloadCollection()
                return
            } else {
                self?.view.showAlert(title: R.string.localizable.settingsNoSubscription(),
                                     subtitle: R.string.localizable.settingsNoSubscriptionDescription())
            }
        }
    }
}
