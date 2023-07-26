//
//  TabBarInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 25.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol TabBarInteractorInterface: AnyObject {

}

class TabBarInteractor {
    weak var presenter: TabBarPresenterInterface?
}

extension TabBarInteractor: TabBarInteractorInterface {

}
