//
//  UIColor+Random.swift
//  AppStore-Example
//
//  Created by Vitor Ferraz Varela
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

