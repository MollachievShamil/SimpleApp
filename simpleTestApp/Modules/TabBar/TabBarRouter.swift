//
//  TabBarRouter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 25.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarRouterInterface: AnyObject {

}

class TabBarRouter: NSObject {

    weak var viewController: UIViewController?

}

extension TabBarRouter: TabBarRouterInterface {

}
