//
//  CollectionModuleBuilder.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

final class CollectionModuleBuilder {

    static func build() -> UIViewController {
        let vc = CollectionViewController()
        let interactor = CollectionInteractor()
        let router = CollectionRouter()
        let presenter = CollectionPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.presenter = presenter
        return vc
    }
}
