//
//  AppFlowCoordinator.swift
//  Travel Planner 2
//
//  Created by Sebastian Ibarra on 10/9/24.
//
import SwiftUI

final class AppFlowCoordinator: ObservableObject {
    @Published var activeFlow: Flow = .selectorview
    
    // Handles switching views with fade-out and fade-in
    func transition(to flow: Flow) {
        // First, fade out the current view
        withAnimation(.easeOut(duration: 0.25)) {
            self.activeFlow = .loadingview
        }
        
        // After fade out completes, switch the view and fade it in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) {
            withAnimation(.easeIn(duration: 0.25)) {
                self.activeFlow = flow
            }
        }
    }
    
    func showSelectorView() {
        transition(to: .selectorview)
    }
    
    func showOrderView() {
        transition(to: .orderview)
    }
    
    func showMapView() {
        transition(to: .mapview)
    }
}

extension AppFlowCoordinator {
    enum Flow {
        case selectorview, orderview, mapview, loadingview
    }
}
