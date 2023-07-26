//
//  CollectionInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol CollectionInteractorInterface: AnyObject {
    func viewDidLoad()
    func infinityScrollAction()
    func getSectionModel() -> [MainCollectionCellModel]
    func getCellId(index: Int) -> Int 
}

struct MainCollectionCellModel: Hashable {
    var image: String
    var title: String
    var id: Int
}

final class CollectionInteractor {
    weak var presenter: CollectionPresenterInterface?
    private var currentPage = 1
    var semaphore = true
    
    private var cellModelsArray: [MainCollectionCellModel] = []
    
    private func fetchData(page: String) {
        semaphore = false
        NetworkEngine().getAllAuto(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if page == "1" {
                        self.createPaginatedBottomCategory(data: data)
                    } else {
                        self.appendToPaginatedBottomCategory(data: data)
                    }
                    semaphore = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// собираем модельку нажней секции и сохраняем в переменную
    /// далее релодим данные и они уже запрашиваются из этой переменной
    private func createPaginatedBottomCategory(data: [AllAutoResponse]) {
        let cells = data.map({ MainCollectionCellModel(image: $0.image,
                                                       title: $0.name,
                                                       id: $0.id) })

        cellModelsArray = cells
        self.presenter?.reloadCollection()
    }
    
    /// метод для инфинити скрола - добавляет новые темплейты в конец коллекции
    private func appendToPaginatedBottomCategory(data: [AllAutoResponse]) {
        let cells = data.map({ MainCollectionCellModel(image: $0.image,
                                                       title: $0.name,
                                                       id: $0.id) })

        cellModelsArray.append(contentsOf: cells)
        self.presenter?.reloadCollection()
    }

}

extension CollectionInteractor: CollectionInteractorInterface {
    
    /// проверки на возможность инфинити скролла
    /// и вызов метода для подгрузки из сети
    func infinityScrollAction() {
        guard !cellModelsArray.isEmpty, semaphore else { return }
        currentPage += 1
        fetchData(page: currentPage.asString)
    }
    
    func viewDidLoad() {
        fetchData(page: currentPage.asString)
    }
    
    func getSectionModel() -> [MainCollectionCellModel] {
        cellModelsArray
    }
    
    func getCellId(index: Int) -> Int {
        cellModelsArray[index].id
    }
}
