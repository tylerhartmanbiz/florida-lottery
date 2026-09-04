//
//  RootView.swift
//  Florida Lottery
//
//  Created by Tyler Hartman on 12/22/25.
//

import Foundation
import SwiftUI

struct RootView: View {

    enum Screen {
        case loading
        case main
        case content
    }

    @State private var currentScreen: Screen = .loading

    var body: some View {
        switch currentScreen {
        case .loading:
            LoadingView {
                currentScreen = .main
            }

        case .main:
            MainScreenView {
                currentScreen = .content
            }

        case .content:
            ContentView()
        }
    }
}
