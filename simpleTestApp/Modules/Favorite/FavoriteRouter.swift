//
//  FavoriteRouter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteRouterInterface: AnyObject {

}

final class FavoriteRouter: NSObject {

    weak var viewController: UIViewController?

}

extension FavoriteRouter: FavoriteRouterInterface {

}