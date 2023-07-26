//
//  SettingsInteractor.swift
//  CIViperGenerator
//
//  Created by MollachievShamil on 26.07.2023.
//  Copyright © 2023 MollachievShamil. All rights reserved.
//

import ApphudSDK
import UIKit

enum SettingsCellType {
    case restore
    case rateUs
    case contact
    case termsOfUse
    case privacy
    
    func getImage() -> UIImage? {
        switch self {
        case .restore:
            return UIImage(systemName: "arrow.triangle.2.circlepath.circle")
        case .rateUs:
            return UIImage(systemName: "hand.thumbsup")
        case .contact:
            return UIImage(systemName: "text.bubble.fill")
        case .termsOfUse:
            return UIImage(systemName: "list.star")
        case .privacy:
            return UIImage(systemName: "text.word.spacing")
        }
    }
    
    func getTitle() -> String? {
        switch self {
        case .restore:
            return R.string.localizable.settingsRestore()
        case .rateUs:
            return R.string.localizable.settingsRateUs()
        case .contact:
            return R.string.localizable.settingsContact()
        case .termsOfUse:
            return R.string.localizable.settingsTerms()
        case .privacy:
            return R.string.localizable.settingsPrivacy()
        }
    }
}

protocol SettingsInteractorInterface: AnyObject {
    func getSectionsModel() -> [SettingsCellType]
}

final class SettingsInteractor {
    weak var presenter: SettingsPresenterInterface?
    private var dataSource: [SettingsCellType] = [.contact, .privacy, .rateUs, .restore, .termsOfUse ]
}

extension SettingsInteractor: SettingsInteractorInterface {
    func getSectionsModel() -> [SettingsCellType] {
        return dataSource
    }
}
