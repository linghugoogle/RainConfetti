//
//  DemoViewController.swift
//  RainConfetti
//
//  Created by linghugoogle on 2025/9/28.
//

import UIKit

class DemoViewController: UIViewController {
    
    private var confettiView: RainConfettiView!
    private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConfettiView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Rain Confetti Demo"
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let confettiButton = createButton(title: "Confetti", action: #selector(showConfetti))
        let triangleButton = createButton(title: "Triangle", action: #selector(showTriangle))
        let starButton = createButton(title: "Star", action: #selector(showStar))
        let diamondButton = createButton(title: "Diamond", action: #selector(showDiamond))
        let textButton = createButton(title: "Text", action: #selector(showText))
        let quickButton = createButton(title: "Quick", action: #selector(quickShow))
        let stopButton = createButton(title: "Stop", action: #selector(stopConfetti))
        
        stopButton.backgroundColor = .systemRed
        
        stackView.addArrangedSubview(confettiButton)
        stackView.addArrangedSubview(triangleButton)
        stackView.addArrangedSubview(starButton)
        stackView.addArrangedSubview(diamondButton)
        stackView.addArrangedSubview(textButton)
        stackView.addArrangedSubview(quickButton)
        stackView.addArrangedSubview(stopButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupConfettiView() {
        confettiView = RainConfettiView(frame: view.bounds)
        confettiView.intensity = 0.7
        view.insertSubview(confettiView, at: 0)
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    
    @objc private func showConfetti() {
        confettiView.removeFromSuperview()
        setupConfettiView()
        confettiView.type = .confetti
        confettiView.colors = [.systemRed, .systemBlue, .systemGreen, .systemYellow, .systemPurple]
        confettiView.startConfetti()
    }
    
    @objc private func showTriangle() {
        confettiView.removeFromSuperview()
        setupConfettiView()
        confettiView.type = .triangle
        confettiView.colors = [.systemOrange, .systemPink, .systemTeal]
        confettiView.startConfetti()
    }
    
    @objc private func showStar() {
        confettiView.removeFromSuperview()
        setupConfettiView()
        confettiView.type = .star
        confettiView.colors = [.systemYellow, .systemOrange, .systemRed]
        confettiView.startConfetti()
    }
    
    @objc private func showDiamond() {
        confettiView.removeFromSuperview()
        setupConfettiView()
        confettiView.type = .diamond
        confettiView.colors = [.systemBlue, .systemPurple, .systemIndigo]
        confettiView.startConfetti()
    }
    
    @objc private func showText() {
        confettiView.removeFromSuperview()
        setupConfettiView()
        confettiView.type = .text("HAPPY")
        confettiView.colors = [.systemBlue, .systemPurple, .systemIndigo]
        confettiView.startConfetti()
    }
    
    @objc private func quickShow() {
        confettiView.removeFromSuperview()
        confettiView = RainConfettiView.showConfetti(in: self.view)
    }
    
    @objc private func stopConfetti() {
        confettiView.stopConfetti()
    }
}
