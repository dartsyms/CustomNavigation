//
//  CustomNavigationViewModel.swift
//  hwappsecond
//

import SwiftUI
import Combine

public struct Screen: Identifiable, Equatable {
    let id: String
    let next: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

public enum CustomTransition {
    case none
    case custom(AnyTransition, AnyTransition)
}

public enum CustomNavigationType {
    case push, pop
}

public enum PopDestination {
    case prev, root
}

public final class CustomNavigationViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    private struct ScreenStack {
        private var screens = [Screen]()
        
        func top() -> Screen? {
            screens.last
        }
        
        mutating func push(_ s: Screen) {
            screens.append(s)
        }
        
        @discardableResult
        mutating func pop() -> Screen? {
            screens.popLast()
        }
        
        mutating func popToRoot() {
            screens.removeAll()
        }
    }
    
    private let easing: Animation
    var navigationType = CustomNavigationType.push
    
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, next: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .prev) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .prev:
                screenStack.pop()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
    
}
