//
//  CalmViewController.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import UIKit

final class CalmDownViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let calmDownView = CalmDownView()
    private let remainingTimerLabel = UILabel()
    
    private let model: CalmDownModel
    
    // MARK: - Init
    
    init(model: CalmDownModel) {
        self.model = model
        
        super.init()
        
        setupViews()
        setupCallbacks()
        
        view.backgroundColor = .white
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        remainingTimerLabel.numberOfLines = 0
        remainingTimerLabel.textAlignment = .center
        view.addSubview(remainingTimerLabel)
        
        remainingTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        remainingTimerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
        
        calmDownView.setBreathePhases(model.breathePhases)
        view.addSubview(calmDownView)
        
        calmDownView.translatesAutoresizingMaskIntoConstraints = false
        calmDownView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calmDownView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calmDownView.widthAnchor.constraint(equalToConstant: UIScreen.main.width * 0.6).isActive = true
        calmDownView.heightAnchor.constraint(equalToConstant: UIScreen.main.width * 0.6).isActive = true
    }
    
    private func setupCallbacks() {
        calmDownView.remainingTimerCallback = { [weak self] minute, second in
            self?.remainingTimerLabel.text = Localization.CalmDown.remainingTitle + "\n" + String(format: "%02d:%02d", minute, second)
        }
        calmDownView.remainingDidEndCallback = { [weak self] in
            self?.remainingTimerLabel.text = nil
        }
    }
}
