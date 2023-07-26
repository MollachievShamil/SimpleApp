//
//  CollectionPresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol CollectionPresenterInterface: AnyObject {
    func headerLeftButtonPressed()
}

final class CollectionPresenter {

    unowned var view: CollectionViewControllerInterface
    let router: CollectionRouterInterface?
    let interactor: CollectionInteractorInterface?

    init(
        interactor: CollectionInteractorInterface,
        router: CollectionRouterInterface,
        view: CollectionViewControllerInterface
      ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CollectionPresenter: CollectionPresenterInterface {
    func headerLeftButtonPressed() {
        router?.settingsTapped()
    }
}
