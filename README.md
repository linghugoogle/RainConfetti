# RainConfetti 🎉

[![Swift](https://img.shields.io/badge/Swift-5.7+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2013.0%2B%20%7C%20macOS%2010.15%2B-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/LLMMarkdown.svg)](https://cocoapods.org/pods/LLMMarkdown)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

[中文文档](README_CN.md) | English

A lightweight, high-performance iOS confetti animation library with support for multiple particle types and custom text confetti effects.

## Features

- ✨ Multiple built-in particle types (confetti, triangle, star, diamond)
- 🔤 Support for custom text confetti (each character animates independently)
- 🎨 Custom color and intensity control
- ⏱️ Configurable animation duration
- 🖼️ Support for custom image particles
- 🎮 Complete animation control (start, stop, pause, resume)
- 📱 Pure Swift implementation, supports iOS 13.0+

## Preview

![RainConfetti Demo](Preview/demo.jpg)

## Installation

### Swift Package Manager

In Xcode, select `File` > `Add Package Dependencies`, then enter:

https://github.com/linghugoogle/RainConfetti

### CocoaPods

```ruby
pod 'RainConfetti'
```

Then run:

```bash
pod install
```

### Manual Installation

Drag the `RainConfettiView.swift` file into your project.

## Quick Start

### Basic Usage

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create confetti view
        let confettiView = RainConfettiView(frame: view.bounds)
        confettiView.intensity = 0.7
        view.addSubview(confettiView)

        // Start confetti
        confettiView.startConfetti()
    }
}
```

### Quick Confetti

```swift
// One line to create confetti effect
RainConfettiView.showConfetti(
    in: view,
    type: .confetti,
    colors: [.systemRed, .systemBlue, .systemGreen],
    intensity: 0.8,
    duration: 3.0
)
```

## Detailed Usage

### Particle Types

```swift
// Confetti
confettiView.type = .confetti

// Triangle
confettiView.type = .triangle

// Star
confettiView.type = .star

// Diamond
confettiView.type = .diamond

// Text confetti
confettiView.type = .text("Congratulations", UIFont.systemFont(ofSize: 24, weight: .bold))

// Custom image
confettiView.type = .custom(UIImage(named: "custom_particle")!)
```

### Custom Configuration

```swift
let confettiView = RainConfettiView(frame: view.bounds)

// Set colors
confettiView.colors = [
    .systemRed,
    .systemBlue,
    .systemGreen,
    .systemYellow,
    .systemPurple
]

// Set intensity (0.0 - 1.0)
confettiView.intensity = 0.5

// Set duration (0 means don't stop automatically)
confettiView.duration = 5.0

// Start animation
confettiView.startConfetti()
```

### Animation Control

```swift
// Start confetti
confettiView.startConfetti()

// Stop confetti
confettiView.stopConfetti()

// Pause animation
confettiView.pauseConfetti()

// Resume animation
confettiView.resumeConfetti()

// Check if active
if confettiView.isActive() {
    print("Confetti is active...")
}
```

### Text Confetti

Text confetti is a special feature of RainConfetti, where each character animates as an independent particle:

```swift
// Chinese text confetti
confettiView.type = .text("新年快乐", UIFont.systemFont(ofSize: 28, weight: .bold))
confettiView.colors = [.red, .gold, .orange, .yellow]

// Emoji confetti
confettiView.type = .text("🎉🎊🥳🎈", UIFont.systemFont(ofSize: 32))

// English text confetti
confettiView.type = .text("HAPPY", UIFont.systemFont(ofSize: 24, weight: .heavy))
```

## API Documentation

### RainConfettiView

#### Properties

| Property      | Type             | Description                                |
| ------------- | ---------------- | ------------------------------------------ |
| `type`      | `ConfettiType` | Particle type                              |
| `colors`    | `[UIColor]`    | Array of particle colors                   |
| `intensity` | `Float`        | Confetti intensity (0.0-1.0)               |
| `duration`  | `TimeInterval` | Duration, 0 means don't stop automatically |

#### Methods

| Method               | Description              |
| -------------------- | ------------------------ |
| `startConfetti()`  | Start confetti animation |
| `stopConfetti()`   | Stop confetti animation  |
| `pauseConfetti()`  | Pause animation          |
| `resumeConfetti()` | Resume animation         |
| `isActive()`       | Check if active          |

#### Class Methods

```swift
static func showConfetti(
    in view: UIView,
    type: ConfettiType = .confetti,
    colors: [UIColor]? = nil,
    intensity: Float = 0.5,
    duration: TimeInterval = 3.0
) -> RainConfettiView
```

### ConfettiType

```swift
public enum ConfettiType {
    case confetti                           // Standard confetti
    case triangle                          // Triangle shape
    case star                              // Star shape
    case diamond                           // Diamond shape
    case text(String, UIFont? = nil)       // Text particles
    case custom(UIImage)                   // Custom image particles
}
```

## System Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

## Example Project

Clone the repository and run the example project:

```bash
git clone https://github.com/linghugoogle/RainConfetti.git
cd RainConfetti
open RainConfetti.xcodeproj
```

## Contribution

Contributions are welcome! Please submit issues and pull requests.

1. Fork this project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

- **liyanbin** - [GitHub](https://github.com/linghugoogle)

## Acknowledgements

- Thanks to all contributors
- Inspired by the need for celebration animations

---

If this project helped you, please give it a ⭐️ for support!
