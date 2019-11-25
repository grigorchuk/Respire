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
        
        case begin, end
        case inhale, exhale, hold
    }
    
    let type: PhaseType
    let duration: Int
    let color: String
}

extension BreathePhase {
    
    static let begin = BreathePhase(type: .begin, duration: 2, color: "#FEFD00")
    static let end = BreathePhase(type: .end, duration: 2, color: "#FEFD00")
    
}
