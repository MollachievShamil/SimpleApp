//
//  DetailsModuleBuilder.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

final class DetailsModuleBuilder {

    static func build(carId: Int) -> UIViewController {
        let vc = DetailsViewController()
        let interactor = DetailsInteractor(id: carId)
        let router = DetailsRouter()
        let presenter = DetailsPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.presenter = presenter
        return vc
    }
}
