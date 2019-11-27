//
//  BreathePhase.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import Foundation

struct BreathePhase: Decodable {
    
    enum PhaseType: String, Decodable {
        
        case inhale, exhale, hold
        case begin, end
    }
    
    let type: PhaseType
    let duration: Int
    let color: String?
}

/// I think it’s better to use the `begin` and `end` actions like an object,
/// since if it is necessary to make changes it will be easy to change and we do not need to write the UI for this cases
extension BreathePhase {
    
    static let begin = BreathePhase(type: .begin, duration: 2, color: "#00FEFF")
    static let end = BreathePhase(type: .end, duration: 2, color: nil)
}
