//
//  UICollectionView+Extension.swift
//  TimeLine
//
//  Created by Wataru Nakanishi on 2022/01/10.
//

import UIKit

extension UICollectionView {
    func registerClass<T: UICollectionViewCell>(cellType: T.Type) {
            register(cellType, forCellWithReuseIdentifier: cellType.className)
        }

    func dequeueReusableCell<T: UICollectionViewCell>(
        type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            fatalError("could not dequeue cell with identifier = \(type.className)")
        }
        return cell
    }
}
