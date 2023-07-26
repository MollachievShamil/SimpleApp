//
//  SettingsPresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol SettingsPresenterInterface: AnyObject {

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

}
