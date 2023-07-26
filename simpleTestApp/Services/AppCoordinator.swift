//
//  AppCoordinator.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import UIKit

class AppCoordinator {
    static let shared = AppCoordinator()
    
    private var rootController: UINavigationController?
    private init() {
        
    }
    
    func getAppStartController() -> UIViewController? {

        rootController = TabBarModuleBuilder.build()
        DispatchQueue.main.async {
            let launchScreen = LaunchScreenViewController()
            guard let controller = self.rootController else { return }
            controller.pushViewController(launchScreen, animated: false)
        }
     
        return rootController
    }
    
    func launchScreenAnimationEnded() {
        rootController?.popToRootViewController(animated: true)
    }
}
