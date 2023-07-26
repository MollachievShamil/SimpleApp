//
//  UIVIewControllerExtension.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func alertOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
