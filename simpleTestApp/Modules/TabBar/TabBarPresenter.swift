//
//  TabBarPresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 25.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol TabBarPresenterInterface: AnyObject {
    func viewDidLoad()
}

class TabBarPresenter {
    var viewDidLoadCallback: (() -> Void)?

    unowned var view: TabBarViewControllerInterface
    let router: TabBarRouterInterface?
    let interactor: TabBarInteractorInterface?

    init(
        interactor: TabBarInteractorInterface,
        router: TabBarRouterInterface,
        view: TabBarViewControllerInterface
      ) {
        self.view = view
        self.interactor = interactor
        self.router = router
          viewDidLoadCallback?()
    }
}

extension TabBarPresenter: TabBarPresenterInterface {
    
    func viewDidLoad() {
        
    }
}
