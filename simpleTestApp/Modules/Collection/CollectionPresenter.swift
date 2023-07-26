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
    func viewDidLoad()
    func reloadCollection()
    func infinityScrollAction()
    func getSectionModel() -> [MainCollectionCellModel]
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
    
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func reloadCollection() {
        view.reloadCollection()
    }
    
    func infinityScrollAction() {
        interactor?.infinityScrollAction()
    }
    
    func getSectionModel() -> [MainCollectionCellModel] {
        interactor?.getSectionModel() ?? []
    }
    
}
