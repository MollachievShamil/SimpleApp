//
//  CollectionRouter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionRouterInterface: AnyObject {
    func settingsTapped()
    func presentDetailsController(id: Int)
}

final class CollectionRouter: NSObject {

    weak var viewController: UIViewController?

}

extension CollectionRouter: CollectionRouterInterface {
    func settingsTapped() {
        let controller = SettingsModuleBuilder.build()
        controller.modalPresentationStyle = .fullScreen
        viewController?.present(controller, animated: true)
    }
    
    func presentDetailsController(id: Int) {
        let controller = DetailsModuleBuilder.build(carId: id)
        controller.modalPresentationStyle = .fullScreen
        viewController?.present(controller, animated: true)
    }
}
