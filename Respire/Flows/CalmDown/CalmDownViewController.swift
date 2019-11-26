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
    
    private let model: CalmDownModel
    
    // MARK: - Init
    
    init(model: CalmDownModel) {
        self.model = model
        
        super.init()
        
        setupViews()
        
        view.backgroundColor = .white
    }
     
    // MARK: - Private functions
    
    private func setupViews() {
        calmDownView.setBreathePhases(model.breathePhases)
        
        view.addSubview(calmDownView)
        calmDownView.translatesAutoresizingMaskIntoConstraints = false
        calmDownView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calmDownView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calmDownView.widthAnchor.constraint(equalToConstant: UIScreen.main.width * 0.6).isActive = true
        calmDownView.heightAnchor.constraint(equalToConstant: UIScreen.main.width * 0.6).isActive = true
    }
}
