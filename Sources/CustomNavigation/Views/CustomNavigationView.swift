//
//  CustomNavigationView.swift
//  hwappsecond
//

import SwiftUI
import Combine

public struct CustomNavigationView<Content: View>: View {
    @ObservedObject private var viewModel: CustomNavigationViewModel
    
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    public init(transition: CustomTransition, easing: Animation = .easeOut(duration: 0.3), @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = CustomNavigationViewModel(easing: easing)
        self.content = content()
        switch transition {
        case .custom(let pushTransition, let popTransition):
            self.transition = (pushTransition, popTransition)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                content.environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.currentScreen!.next
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}
