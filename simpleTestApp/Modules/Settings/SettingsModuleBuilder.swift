//
//  SettingsModuleBuilder.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

final class SettingsModuleBuilder {

    static func build() -> UIViewController {
        let vc = SettingsViewController()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.presenter = presenter
        return vc
    }
}
