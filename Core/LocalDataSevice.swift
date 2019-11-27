//
//  LocalDataManager.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import Foundation

final class LocalDataSevice {
    
    static func named<T: Decodable>(_ name: String) -> T {
        let decoder = JSONDecoder()
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load file named <\(name)>")
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("\(error)")
        }
    }
    
}
