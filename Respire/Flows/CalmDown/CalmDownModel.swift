//
//  CalmDownModel.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import Foundation

final class CalmDownModel {
    
    // MARK: - Properties
    
    var breathePhases: [BreathePhase] = []
    
    // MARK: - Init
    
    init() {
        setupBreathePhases()
    }
    
    // MARK: - Private functions
    
    private func setupBreathePhases() {
        let fetchedPhases: [BreathePhase] = LocalDataSevice.named("Sample")
        
        breathePhases.append(BreathePhase.begin)
        breathePhases.append(contentsOf: fetchedPhases)
        breathePhases.append(BreathePhase.end)
    }
}

