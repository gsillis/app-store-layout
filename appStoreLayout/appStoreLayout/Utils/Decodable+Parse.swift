//
//  Decodable+Parse.swift
//  AppStore-Example
//
//  Created by Gabriela Sillis on 02/12/21.
//

import UIKit

extension Decodable {
    static func parse(jsonFile: String) -> Self {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
                  fatalError("Error to find json file \(jsonFile)")
              }
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch  {
            fatalError("Error to find json file \(error.localizedDescription)")
        }
    }
}
