//
//  CalmDownModel.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import Foundation

final class CalmDownModel {
    
    var breathePhases: [BreathePhase] = []
    
    init() {
        fetchBreathePhases()
    }
    
    private func fetchBreathePhases() {
        let fetchedPhases: [BreathePhase] = LocalDataSevice.named("Sample")
        
        breathePhases.append(BreathePhase.begin)
        breathePhases.append(contentsOf: fetchedPhases)
        breathePhases.append(BreathePhase.end)
    }
}
