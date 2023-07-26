//
//  UICollectionviewExtension.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import UIKit

extension UICollectionView {
    func register<T>(classCell: T.Type) where T: UICollectionViewCell {
        self.register(classCell, forCellWithReuseIdentifier: classCell.className)
    }
    
    func reusableCell<T>(classCell: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        if let newCell = self.dequeueReusableCell(withReuseIdentifier: classCell.className, for: indexPath) as? T {
            return newCell
        }
        return T()
    }
    
    func registerHeader<T>(classHeader: T.Type) where T: UICollectionReusableView {
        self.register(classHeader,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: classHeader.className)
    }
    
    func registerFooter<T>(classFooter: T.Type) where T: UICollectionReusableView {
        self.register(classFooter,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: classFooter.className)
    }
    
    func reusableHeader<T>(classHeader: T.Type, indexPath: IndexPath) -> T? where T: UICollectionReusableView {
        if let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                              withReuseIdentifier: classHeader.className,
                                                              for: indexPath) as? T {
            return header
        }
        return nil
    }
    
    func reusableFooter<T>(classFooter: T.Type, indexPath: IndexPath) -> T? where T: UICollectionReusableView {
        if let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                              withReuseIdentifier: classFooter.className,
                                                              for: indexPath) as? T {
            return header
        }
        return nil
    }
}

extension NSObject {
    class var className: String {
        let array = String(describing: self).components(separatedBy: ".")
        return array.last ?? "className"
    }
}
