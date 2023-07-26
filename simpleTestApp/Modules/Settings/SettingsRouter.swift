//
//  SettingsRouter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsRouterInterface: AnyObject {

}

final class SettingsRouter: NSObject {

    weak var viewController: UIViewController?

}

extension SettingsRouter: SettingsRouterInterface {

}