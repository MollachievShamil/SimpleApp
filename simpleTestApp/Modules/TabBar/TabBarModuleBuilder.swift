//
//  TabBarModuleBuilder.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
import UIKit

class TabBarModuleBuilder {
    
    private enum TabBarControllers {
        case collection
        case favorite
        
        func getTabBarItem() -> UITabBarItem {
            switch self {
            case .collection:
                return UITabBarItem(title: R.string.localizable.tabBatItemsCollection(),
                                    image: UIImage(systemName: "sun.max.fill"),
                                    selectedImage: nil)
            case .favorite:
                return UITabBarItem(title: R.string.localizable.tabBatItemsFavorite(),
                                    image: UIImage(systemName: "clock"),
                                    selectedImage: nil)
            }
        }
        
        func getController() -> UIViewController {
            switch self {
            case .collection:
               let vc = CollectionModuleBuilder.build()
                vc.tabBarItem = getTabBarItem()
                return vc
            case .favorite:
                let vc = FavoriteModuleBuilder.build()
                vc.tabBarItem = getTabBarItem()
                return vc
            }
        }
    }
    
    static func build() -> UINavigationController {
        let vc = TabBarViewController()
        let interactor = TabBarInteractor()
        let router = TabBarRouter()
        let presenter = TabBarPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.presenter = presenter

        vc.viewControllers = [
            TabBarControllers.collection.getController(),
            TabBarControllers.favorite.getController()
        ]
        
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        return navController
    }
}
