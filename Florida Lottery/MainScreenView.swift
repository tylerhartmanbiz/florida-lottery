//
//  MainScreenView.swift
//  Florida Lottery
//
//  Created by Tyler Hartman on 12/22/25.
//

import Foundation
import SwiftUI

struct MainScreenView: View {
    let onStart: () -> Void // You can keep this or add specific actions for each button

    var body: some View {
        ZStack {
            Image("main")
                .resizable()
                .aspectRatio(contentMode: .fit)


            VStack(spacing: 0) {
                Spacer()

                // Bottom Navigation Bar
                HStack(spacing: 0) {
                    Group {
                        bottomButton(title: "Scratch-\nOffs") { print("Scratch-Offs tapped") }
                        divider
                        bottomButton(title: "Promotions") { print("Promotions tapped") }
                        divider
                        bottomButton(title: "My\nFavorites") { print("Favorites tapped") }
                        divider
                        bottomButton(title: "Check My\nTicket") { print("Check Ticket tapped")
                            onStart()
                        }
                        divider
                        bottomButton(title: "Play\nResponsibly") { print("Responsible Play tapped") }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70) // Adjust height as needed
                .background(Color(hex: "#2e3d3b")) // Dark slate color
            }
        }
        .background(Color(hex: "#2e3d3b"))
    }

    // Helper for the individual buttons
    private func bottomButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // Helper for the vertical divider lines
    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.8))
            .frame(width: 0.9)
            .padding(.vertical, 10)
    }
}
