//
//  CollectionInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol CollectionInteractorInterface: AnyObject {

}

final class CollectionInteractor {
    weak var presenter: CollectionPresenterInterface?
}

extension CollectionInteractor: CollectionInteractorInterface {

}
