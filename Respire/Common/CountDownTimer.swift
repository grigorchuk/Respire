//
//  CountDownTimer.swift
//  Respire
//
//  Created by Alex on 11/26/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import Foundation

final class CountDownTimer {
    
    // MARK: - Properties
    
    var updateCallback: ((Int, Int, Int) -> Void)?
    var didEndCallback: (() -> Void)?
    
    private var timer: Timer?
    private var count = 0
    
    // MARK: - Public functions
    
    func start(with second: Int) {
        count = second
        updateCount()
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCount),
            userInfo: nil,
            repeats: true
        )
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        
        didEndCallback?()
    }
    
    // MARK: - Private functions
    
    @objc
    private func updateCount() {
        guard count > 0 else { return }
        count -= 1
        
        let hour = Int(count) / 3600
        let minute = Int(count) / 60 % 60
        let second = Int(count) % 60
        
        updateCallback?(hour, minute, second)
    }
}
