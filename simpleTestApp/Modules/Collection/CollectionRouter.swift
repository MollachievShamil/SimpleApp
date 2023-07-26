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
}
