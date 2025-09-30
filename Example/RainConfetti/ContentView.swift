//
//  ContentView.swift
//  RainConfetti
//
//  Created by linghugoogle on 2025/9/28.
//

import SwiftUI

struct ContentView: View {
    @State private var isConfettiActive = false
    @State private var selectedType: ConfettiType = .confetti
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Rain Confetti SwiftUI Demo")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 15) {
                    Button("🎊 Confetti") {
                        selectedType = .confetti
                        startConfetti()
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .blue))
                    
                    Button("🔺 Triangle") {
                        selectedType = .triangle
                        startConfetti()
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .green))
                    
                    Button("⭐ Star") {
                        selectedType = .star
                        startConfetti()
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .yellow))
                    
                    Button("💎 Diamond") {
                        selectedType = .diamond
                        startConfetti()
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .purple))
                    
                    Button("📚 Text") {
                        selectedType = .text("HAPPY")
                        startConfetti()
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .purple))
                    
                    Button("🛑 Stop") {
                        isConfettiActive = false
                    }
                    .buttonStyle(ConfettiButtonStyle(color: .red))
                }
            }
            
            if isConfettiActive {
                RainConfettiViewRepresentable(
                    type: selectedType,
                    isActive: $isConfettiActive
                )
                .allowsHitTesting(false)
            }
        }
    }
    
    private func startConfetti() {
        isConfettiActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            isConfettiActive = false
        }
    }
}

struct RainConfettiViewRepresentable: UIViewRepresentable {
    let type: ConfettiType
    @Binding var isActive: Bool
    
    func makeUIView(context: Context) -> RainConfettiView {
        let confettiView = RainConfettiView()
        confettiView.backgroundColor = .clear
        return confettiView
    }
    
    func updateUIView(_ uiView: RainConfettiView, context: Context) {
        uiView.type = type
        
        switch type {
        case .confetti:
            uiView.colors = [.systemRed, .systemBlue, .systemGreen, .systemYellow, .systemPurple]
        case .triangle:
            uiView.colors = [.systemOrange, .systemPink, .systemTeal]
        case .star:
            uiView.colors = [.systemYellow, .systemOrange, .systemRed]
        case .diamond:
            uiView.colors = [.systemBlue, .systemPurple, .systemIndigo]
        case .custom(_):
            uiView.colors = [.systemRed, .systemBlue, .systemGreen]
        case .text(_, _):
            uiView.colors = [.systemRed, .systemYellow, .systemBlue]
        }
        
        uiView.intensity = 0.7
        
        if isActive && !uiView.isActive() {
            uiView.startConfetti()
        } else if !isActive && uiView.isActive() {
            uiView.stopConfetti()
        }
    }
}

struct ConfettiButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
