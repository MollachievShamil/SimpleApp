//
//  DetailsRouter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsRouterInterface: AnyObject {
    func dismiss()
}

final class DetailsRouter: NSObject {

    weak var viewController: UIViewController?

}

extension DetailsRouter: DetailsRouterInterface {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
