//
//  DetailsPresenter.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol DetailsPresenterInterface: AnyObject {
    func headerLeftButtonPressed()
    func reloadCollection()
    func getSectionModel() -> [DetailsSectionType]
    func getTopCells() -> DetailsCellModel?
    func getBottomCells() -> [DetailsCellModel]?
    func infinityScrollAction()
}

final class DetailsPresenter {

    unowned var view: DetailsViewControllerInterface
    let router: DetailsRouterInterface?
    let interactor: DetailsInteractorInterface?

    init(
        interactor: DetailsInteractorInterface,
        router: DetailsRouterInterface,
        view: DetailsViewControllerInterface
      ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailsPresenter: DetailsPresenterInterface {
    func headerLeftButtonPressed() {
        router?.dismiss()
    }
    
    func reloadCollection() {
        view.reloadCollection()
    }
    
    func getSectionModel() -> [DetailsSectionType] {
        interactor?.getSectionModel() ?? []
    }
    
    func getTopCells() -> DetailsCellModel? {
        interactor?.getTopCells()
    }
    
    func getBottomCells() -> [DetailsCellModel]? {
        interactor?.getBottomCells()
    }
    
    func infinityScrollAction() {
        interactor?.infinityScrollAction()
    }
}
