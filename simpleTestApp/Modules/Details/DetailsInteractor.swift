//
//  DetailsInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol DetailsInteractorInterface: AnyObject {
    func getSectionModel() -> [DetailsSectionType]
    func getTopCells() -> DetailsCellModel?
    func getBottomCells() -> [DetailsCellModel]?
    func infinityScrollAction()
}

enum DetailsSectionType: Hashable {
    case top
    case bottom
}

enum DetailsCellModel: Hashable {
    case top(carInfo: TopCellModel)
    case bottom(post: BottomCellModel)
}

struct BottomCellModel: Hashable, Equatable {
    var mainImage: String?
    var date: String
    var description: String
    var numberOfLikes: String
    var numberOfComments: String
}

final class DetailsInteractor {
    weak var presenter: DetailsPresenterInterface?
    
    private var carId: Int
    private var topCells: DetailsCellModel?
    private var bottomCells: [DetailsCellModel]?
    private var currentPage = 1
    private let dispatch = DispatchGroup()
    var semaphore = true
    
    init(id: Int) {
        carId = id
        fetchData()
    }
    
    private func fetchData() {
        dispatch.enter()
        dispatch.enter()
        fetchTopSectionData { [weak self] data in
            guard let self = self else { return }
            topCells = .top(carInfo: createTopCellModel(data: data))
            dispatch.leave()
        }
        
        fetchBottomSectionData { [weak self] data in
            guard let self = self else { return }
            bottomCells = data.posts.map({ DetailsCellModel.bottom(post: self.createBottomCellModel(data: $0)) })
            dispatch.leave()
        }
        dispatch.notify(queue: .main) { [weak self] in
            self?.presenter?.reloadCollection()
        }
    }
    
    private func fetchTopSectionData(compl: @escaping ((AutoInfoResponse) -> Void)) {
        NetworkEngine().getAutoInfo(autoId: carId.asString) { result in
            switch result {
            case .success(let data):
                compl(data)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    private func fetchBottomSectionData(compl: @escaping ((AutoPostsResponse) -> Void)) {
        NetworkEngine().getAutoPosts(autoId: carId.asString, page: currentPage.asString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    compl(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// метод для инфинити скрола - добавляет новые темплейты в конец коллекции
    private func appendToPaginatedBottomCategory(data: AutoPostsResponse) {
        bottomCells?.append(contentsOf: data.posts.map({ DetailsCellModel.bottom(post: createBottomCellModel(data: $0)) }))
        self.presenter?.reloadCollection()
    }
    
    private func createTopCellModel(data: AutoInfoResponse) -> TopCellModel {
        TopCellModel(mainImage: data.car.images.first(where: { $0.isPrimary == true })?.url,
                     userImage: data.user.avatar.url,
                     carName: data.car.name,
                     userName: data.user.username)
    }

    private func createBottomCellModel(data: Post) -> BottomCellModel {
        BottomCellModel(mainImage: data.img,
                        date: data.createdAt,
                        description: data.text,
                        numberOfLikes: data.likeCount.asString,
                        numberOfComments: data.commentCount.asString)
    }
}

extension DetailsInteractor: DetailsInteractorInterface {
    /// проверки на возможность инфинити скролла
    /// и вызов метода для подгрузки из сети
    func infinityScrollAction() {
        guard bottomCells != nil, semaphore else { return }
        currentPage += 1
        semaphore = false
        fetchBottomSectionData { [weak self] data in
            self?.appendToPaginatedBottomCategory(data: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.semaphore = true
            }
        }
    }
    
    func getSectionModel() -> [DetailsSectionType] {
        return [.top, .bottom]
    }
    
    func getTopCells() -> DetailsCellModel? {
        topCells
    }
    
    func getBottomCells() -> [DetailsCellModel]? {
        bottomCells
    }
}
