//
//  ViewCode.swift
//  AppStore-Example
//
//  Created by Vitor Ferraz Varela
//

import Foundation
protocol ViewCode {
    func buildViewHierarchy()
    func addConstraints()
    func additionalConfiguration()
    func setup()
}

extension ViewCode {
    func setup() {
        buildViewHierarchy()
        addConstraints()
        additionalConfiguration()
    }
    
    func additionalConfiguration() {} 
}
