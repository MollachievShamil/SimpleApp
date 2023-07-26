//
//  FavoriteInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol FavoriteInteractorInterface: AnyObject {

}

final class FavoriteInteractor {
    weak var presenter: FavoritePresenterInterface?
}

extension FavoriteInteractor: FavoriteInteractorInterface {

}
