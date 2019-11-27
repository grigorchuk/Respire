//
//  CalmDownView.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import UIKit

final class CalmDownView: UIView {
    
    // MARK: - Properties
    
    var remainingTimerCallback: ((Int, Int) -> Void)?
    var remainingDidEndCallback: (() -> Void)?
    
    private let rectangleLayer = CALayer()
    private let phaseNameLabel = UILabel()
    private let phaseTimerLabel = UILabel()
    private let actionCountDownTimer = CountDownTimer()
    private let remainingCountDownTimer = CountDownTimer()
    
    private var breathePhases: [BreathePhase] = []
    private var listOfActions: [(breathePhase: BreathePhase, animation: CABasicAnimation)] = []
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupCallbacks()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupRectangleLayer()
    }
    
    // MARK: - Public functions
    
    func setBreathePhases(_ phases: [BreathePhase]) {
        breathePhases = phases
        
        setDefaultState()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        phaseNameLabel.numberOfLines = 0
        phaseNameLabel.textAlignment = .center
        phaseTimerLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [phaseNameLabel, phaseTimerLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupRectangleLayer() {
        guard rectangleLayer.superlayer == nil else { return }
        
        /// it necessary for correct display when the colors of the rectangle and the background are the same
        rectangleLayer.borderWidth = 1.0
        rectangleLayer.borderColor = UIColor.lightGray.cgColor
        rectangleLayer.frame.size = frame.size
        layer.insertSublayer(rectangleLayer, at: 0)
    }
    
    private func setupCallbacks() {
        remainingCountDownTimer.updateCallback = { [weak self] _, minute, second in
            self?.remainingTimerCallback?(minute, second)
        }
        remainingCountDownTimer.didEndCallback = { [weak self] in
            self?.remainingDidEndCallback?()
        }
        actionCountDownTimer.updateCallback = { [weak self] _, minute, second in
            self?.phaseTimerLabel.text = String(format: "%02d:%02d", minute, second)
        }
        actionCountDownTimer.didEndCallback = { [weak self] in
            self?.phaseTimerLabel.text = nil
        }
    }
    
    private func setupListOfActions() {
        guard listOfActions.isEmpty else { return }
        
        breathePhases.forEach { listOfActions.append(($0, animation(with: $0))) }
    }
        
    private func applyNextAnimation() {
        guard !listOfActions.isEmpty else { return }
        handleremainingTimer()
        
        let action = listOfActions.removeFirst()
        
        phaseNameLabel.text = action.breathePhase.type.title
        phaseTimerLabel.isHidden = !action.breathePhase.type.needDisplay
        rectangleLayer.backgroundColor = action.breathePhase.color?.uiColor().cgColor ?? rectangleLayer.backgroundColor
        actionCountDownTimer.start(with: Int(action.animation.duration))
        
        add(animation: action.animation, isNeedEndCallback: listOfActions.isEmpty)
    }
    
    private func setDefaultState() {
        phaseNameLabel.text = Localization.CalmDown.tapHereTitle
        rectangleLayer.backgroundColor = UIColor.yellow().cgColor
    }
    
    private func add(animation: CAAnimation, isNeedEndCallback: Bool) {
        if isNeedEndCallback {
            /// There is currently no other way to receive notifications
            /// when the animation is fully complete
            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.setDefaultState()
            }
            rectangleLayer.add(animation, forKey: nil)
            CATransaction.commit()
        } else {
            rectangleLayer.add(animation, forKey: nil)
        }
    }
    
    private func animation(with breathePhase: BreathePhase) -> CABasicAnimation {
        let fromValue = listOfActions.last?.animation.toValue as? CATransform3D
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fromValue = fromValue
        animation.duration = breathePhase.duration.toDouble
        animation.toValue = breathePhase.type.transform ?? fromValue
        animation.delegate = self
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    private func handleremainingTimer() {
        if (listOfActions.count + 1) == breathePhases.count {
            let allAnimationsDuration = breathePhases.compactMap {
                $0.type != .begin && $0.type != .end ? $0.duration : nil
            }.reduce(0, { $0 + $1 })
            
            remainingCountDownTimer.start(with: allAnimationsDuration)
        } else if listOfActions.count == 1 {
            remainingCountDownTimer.stop()
        }
    }
    
    // MARK: - UIResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self), rectangleLayer.contains(point) && listOfActions.isEmpty else { return }
        
        setupListOfActions()
        applyNextAnimation()
    }
}

// MARK: - CAAnimationDelegate

extension CalmDownView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        actionCountDownTimer.stop()
        
        guard flag else { return }
        applyNextAnimation()
    }
}

// MARK: - Private extenstions

private extension BreathePhase.PhaseType {
    
    var transform: CATransform3D? {
        switch self {
        case .begin: return CATransform3DMakeScale(0.75, 0.75, 1.0)
        case .end: return CATransform3DMakeScale(1.0, 1.0, 1.0)
        case .inhale: return CATransform3DMakeScale(1.0, 1.0, 1.0)
        case .exhale: return CATransform3DMakeScale(0.5, 0.5, 1.0)
        case .hold: return nil
        }
    }
    
    var title: String? {
        switch self {
        case .inhale, .exhale, .hold: return self.rawValue.uppercased()
        default: return nil
        }
    }
    
    var needDisplay: Bool {
        switch self {
        case .begin, .end: return false
        default: return true
        }
    }
}
