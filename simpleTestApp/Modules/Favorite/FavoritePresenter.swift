//
//  FavoritePresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol FavoritePresenterInterface: AnyObject {

}

final class FavoritePresenter {

    unowned var view: FavoriteViewControllerInterface
    let router: FavoriteRouterInterface?
    let interactor: FavoriteInteractorInterface?

    init(
        interactor: FavoriteInteractorInterface,
        router: FavoriteRouterInterface,
        view: FavoriteViewControllerInterface
      ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritePresenter: FavoritePresenterInterface {

}
