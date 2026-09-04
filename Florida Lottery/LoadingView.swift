//
//  LoadingView.swift
//  Florida Lottery
//
//  Created by Tyler Hartman on 12/22/25.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    let onFinished: () -> Void
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                // Existing content
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Color(hex: "#e24766")
                    }
                    .ignoresSafeArea()
                    
                    Image("loading")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                onFinished()
                            }
                        }
                }
            }
        }
    }
}
