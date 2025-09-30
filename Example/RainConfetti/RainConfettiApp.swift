//
//  RainConfettiApp.swift
//  RainConfetti
//
//  Created by linghugoogle on 2025/9/28.
//

import SwiftUI

@main
struct RainConfettiApp: App {
    var body: some Scene {
        WindowGroup {
            // Debug SwiftUI
//            ContentView()
            
            // Debug UIKit
            UIKitViewControllerWrapper()
        }
    }
}

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let demoViewController = DemoViewController()
        return UINavigationController(rootViewController: demoViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
