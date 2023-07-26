//
//  FavoriteModuleBuilder.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

final class FavoriteModuleBuilder {

    static func build() -> UIViewController {
        let vc = FavoriteViewController()
        let interactor = FavoriteInteractor()
        let router = FavoriteRouter()
        let presenter = FavoritePresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.presenter = presenter
        return vc
    }
}
