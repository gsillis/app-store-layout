//
//  ConfigureCell.swift
//  AppStore-Example
//
//  Created by Gabriela Sillis on 02/12/21.
//

import UIKit

protocol ConfigureCell {
    associatedtype Model
    static var identifier: String { get }
    func configure(with model: Model)
}

extension UICollectionView {
    func configure<T: ConfigureCell>(_ cellType: T.Type, with model: T.Model, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: model)
        return cell
    }
}
