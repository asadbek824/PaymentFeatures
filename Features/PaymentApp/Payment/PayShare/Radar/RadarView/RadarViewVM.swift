//
//  RadarViewVM.swift
//  PaymentApp
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import SwiftUI

class RadarViewVM: ObservableObject {
    @Published var circles: [RadarCircle] = []
    private let maxCircles = 5
    private let maxSize: CGFloat = UIScreen.main.bounds.width
    private let circleSpawnInterval: TimeInterval = 0.7
    private let animationDuration: TimeInterval = 3.0
    
    private var timer: Timer?
    
    deinit {
        stopRadarAnimation()
    }
    
    func startRadarAnimation() {
        // Stop any existing animation before starting a new one
        stopRadarAnimation()
        
        // Clear any existing circles
        circles.removeAll()
        
        // Create and store a reference to the timer
        timer = Timer.scheduledTimer(withTimeInterval: circleSpawnInterval, repeats: true) { [weak self] _ in
            self?.spawnNewCircle()
        }
        
        spawnNewCircle()
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    func stopRadarAnimation() {
        timer?.invalidate()
        timer = nil
    }
    
    private func spawnNewCircle() {
        let newCircle = RadarCircle(id: UUID(), size: 0, opacity: 1.0)
        circles.append(newCircle)
        
        withAnimation(.easeOut(duration: animationDuration)) {
            if let index = circles.firstIndex(where: { $0.id == newCircle.id }) {
                circles[index].size = maxSize
                circles[index].opacity = 0.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.1) { [weak self] in
            guard let self = self else { return }
            self.circles.removeAll(where: { $0.id == newCircle.id })
        }
        
        if circles.count > maxCircles {
            circles.removeFirst()
        }
    }
}
