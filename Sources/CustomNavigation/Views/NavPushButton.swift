//
//  NavPushButton.swift
//  hwappsecond
//

import SwiftUI

public struct NavPushButton_Previews: PreviewProvider {
    public static var previews: some View {
        NavPushButton(destination: EmptyView()) {
            Text("More...")
        }
    }
}

public struct NavPushButton<Label: View, Destination: View>: View {
    @EnvironmentObject private var viewModel: CustomNavigationViewModel
    
    private var label: Label
    private var destination: Destination
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        HStack {
            label
            Image(systemName: "chevron.right")
        }.onTapGesture {
            self.viewModel.push(self.destination)
        }
    }
}


