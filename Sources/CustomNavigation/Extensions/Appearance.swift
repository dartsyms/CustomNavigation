//
//  Appearance.swift
//  hwappsecond
//

import Foundation
import SwiftUI

public extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first { $0.isKeyWindow }
    }
}

public extension UIDevice {
    var hasNotch: Bool {
        return UIApplication.shared.keyWindowInConnectedScenes?.safeAreaInsets.bottom ?? 0 > 0
    }
}

public extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: opacity)
        let removal = AnyTransition.slide.combined(with: opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var moveBackAndFade: AnyTransition {
        let removal = AnyTransition.slide.combined(with: opacity)
        let insertion = AnyTransition.move(edge: .trailing).combined(with: opacity)
        return .asymmetric(insertion: removal, removal: insertion)
    }
}


