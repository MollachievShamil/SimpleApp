//
//  SettingsInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import Foundation

protocol SettingsInteractorInterface: AnyObject {

}

final class SettingsInteractor {
    weak var presenter: SettingsPresenterInterface?
}

extension SettingsInteractor: SettingsInteractorInterface {

}
