//
//  NavPopButton.swift
//  hwappsecond
//

import SwiftUI

public struct NavPopButton<Label: View>: View {
    @EnvironmentObject private var viewModel: CustomNavigationViewModel
    
    private var label: Label
    private var destination: PopDestination
    
    init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            label
        }.onTapGesture {
            self.viewModel.pop(to: self.destination)
        }
    }
}

public struct NavPopButton_Previews: PreviewProvider {
    public static var previews: some View {
        NavPopButton(destination: .prev) {
            Text("Back")
        }
    }
}
