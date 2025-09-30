//
//  RainConfettiView.swift
//  RainConfetti
//
//  Created by linghugoogle on 2025/9/28.
//

import UIKit

public enum ConfettiType {
    case confetti
    case triangle
    case star
    case diamond
    case text(String, UIFont? = nil)
    case custom(UIImage)
}

public class RainConfettiView: UIView {

    // MARK: - Public Properties

    public var type: ConfettiType = .confetti {
        didSet {
            updateEmitterCell()
        }
    }

    public var colors: [UIColor] = [
        UIColor.systemRed,
        UIColor.systemBlue,
        UIColor.systemGreen,
        UIColor.systemYellow,
        UIColor.systemPurple,
        UIColor.systemOrange,
        UIColor.systemPink
    ] {
        didSet {
            updateEmitterCell()
        }
    }

    /// 0.0 - 1.0
    public var intensity: Float = 0.5 {
        didSet {
            intensity = max(0.0, min(1.0, intensity))
            updateIntensity()
        }
    }

    /// after duration auto stop, 0 means never auto stop
    public var duration: TimeInterval = 0
    public var autoRemove: Bool = true

    // MARK: - Private Properties

    private var emitterLayer: CAEmitterLayer!
    private var emitterCell: CAEmitterCell!
    private var active: Bool = false

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmitterLayer()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupEmitterLayer()
    }

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -10)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
    }

    // MARK: - Setup

    private func setupEmitterLayer() {
        isUserInteractionEnabled = false

        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -10)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)

        layer.addSublayer(emitterLayer)

        setupEmitterCell()
        updateEmitterCell()
    }

    private func setupEmitterCell() {
        emitterCell = CAEmitterCell()
        emitterCell.birthRate = 0
        emitterCell.lifetime = 7.0
        emitterCell.lifetimeRange = 0
        emitterCell.velocity = 350
        emitterCell.velocityRange = 80
        emitterCell.emissionLongitude = .pi
        emitterCell.emissionRange = .pi / 4
        emitterCell.spin = 2
        emitterCell.spinRange = 3
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.05

        emitterLayer.emitterCells = [emitterCell]
    }

    private func updateEmitterCell() {
        var cells: [CAEmitterCell] = []

        if case .text(let text, let font) = type {
            let characters = Array(text)
            let colorCount = colors.count

            for (index, character) in characters.enumerated() {
                guard let image = createTextImage(text: String(character), font: font) else { continue }

                let cell = CAEmitterCell()
                cell.contents = image.cgImage
                cell.birthRate = active ? intensity * 10 / Float(characters.count) : 0
                cell.lifetime = 7.0
                cell.lifetimeRange = 0
                cell.velocity = 350
                cell.velocityRange = 80
                cell.emissionLongitude = .pi
                cell.emissionRange = .pi / 4
                cell.spin = 2
                cell.spinRange = 3
                cell.scaleRange = 0.5
                cell.scaleSpeed = -0.05

                let colorIndex = index % colorCount
                cell.color = colors[colorIndex].cgColor

                cells.append(cell)
            }
        } else {
            guard let image = getImageForType() else { return }

            emitterCell.contents = image.cgImage
            emitterCell.color = colors.first?.cgColor

            for color in colors {
                let cell = CAEmitterCell()
                cell.contents = image.cgImage
                cell.birthRate = active ? intensity * 10 : 0
                cell.lifetime = 7.0
                cell.lifetimeRange = 0
                cell.velocity = 350
                cell.velocityRange = 80
                cell.emissionLongitude = .pi
                cell.emissionRange = .pi / 4
                cell.spin = 2
                cell.spinRange = 3
                cell.scaleRange = 0.5
                cell.scaleSpeed = -0.05
                cell.color = color.cgColor

                cells.append(cell)
            }
        }

        emitterLayer.emitterCells = cells
    }

    private func getImageForType() -> UIImage? {
        switch type {
        case .confetti:
            return UIImage(named: "confetti")
        case .triangle:
            return UIImage(named: "triangle")
        case .star:
            return UIImage(named: "star")
        case .diamond:
            return UIImage(named: "diamond")
        case .text(let text, let font):
            return createTextImage(text: text, font: font)
        case .custom(let image):
            return image
        }
    }

    private func createTextImage(text: String, font: UIFont?) -> UIImage? {
        let textFont = font ?? UIFont.systemFont(ofSize: 8, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: UIColor.white
        ]

        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let size = attributedString.size()

        let imageSize = CGSize(width: size.width + 2, height: size.height + 2)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard UIGraphicsGetCurrentContext() != nil else { return nil }

        let drawRect = CGRect(x: 2, y: 2, width: size.width, height: size.height)
        attributedString.draw(in: drawRect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    private func updateIntensity() {
        guard active else { return }

        let birthRate = intensity * 10

        emitterLayer.emitterCells?.forEach { cell in
            cell.birthRate = birthRate
        }
    }

    // MARK: - Public Methods

    public func startConfetti() {
        guard !active else { return }

        active = true
        updateEmitterCell()
        updateIntensity()

        if duration > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?.stopConfetti()
            }
        }
    }

    public func stopConfetti() {
        guard active else { return }

        active = false
        emitterLayer.birthRate = 0
        if autoRemove {
            removeFromSuperview()
        }
    }

    public func isActive() -> Bool {
        return active
    }
}

// MARK: - Convenience Methods

public extension RainConfettiView {

    /// quick start
    static func showConfetti(
        in view: UIView,
        type: ConfettiType = .confetti,
        colors: [UIColor]? = nil,
        intensity: Float = 0.5,
        duration: TimeInterval = 3.0,
        autoRemove: Bool = true
    ) -> RainConfettiView {
        let confettiView = RainConfettiView(frame: view.bounds)
        confettiView.type = type
        if let colors = colors {
            confettiView.colors = colors
        }
        confettiView.intensity = intensity
        confettiView.duration = duration

        view.addSubview(confettiView)
        confettiView.startConfetti()

        return confettiView
    }
}
