Pod::Spec.new do |s|
  s.name             = 'RainConfetti'
  s.version          = '1.0.0'
  s.summary          = 'A lightweight, high-performance iOS confetti animation library'

  s.description      = <<-DESC
                       A lightweight, high-performance iOS confetti animation library with support for multiple particle types and custom text confetti effects.
                       DESC

  s.homepage         = 'https://github.com/linghugoogle/RainConfetti'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyanbin' => 'linghugoogle@163.com' }
  s.source           = { :git => 'https://github.com/linghugoogle/RainConfetti.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/RainConfetti/**/*.{swift}'
  s.resource_bundles = {
    'RainConfetti' => ['Sources/RainConfetti/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end