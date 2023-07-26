//
//  UIDeviceExtension.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import UIKit

extension UIDevice {
    static var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    public enum ScreenType: String {
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXSMax
        case iPhone11
        case iPhone13
        case iPhoneSE2
        case iPhone12
        case iPhone12Pro
        case iPhone12Mini
        case unknown
    }
    
    static var isSmallDevice: Bool {
        switch UIDevice.screenType {
        case .iPhone8, .iPhone8Plus, .iPhoneSE2:
            return true
        default:
            return false
        }
    }
    
    static var screenType: ScreenType {
        guard iPhone else { return .unknown }

        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE2
        case 1334:
            return .iPhone8
        case 2208:
            return .iPhone8Plus
        case 2436:
            return .iPhoneX
        case 2521:
            return .iPhone12
        case 2532:
            return .iPhone13
        case 2688:
            return .iPhoneXSMax
        case 2778:
            return .iPhone12Pro
        case 1792:
            return .iPhone11
        default:
            return .unknown
        }
    }
}

