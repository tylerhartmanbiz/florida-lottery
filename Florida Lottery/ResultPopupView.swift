//
//  ResultView.swift
//  Florida Lottery
//
//  Created by Tyler Hartman on 12/20/25.
//

//
//  ResultPopupView.swift
//  Florida Lottery
//
//  Created by Tyler Hartman on 12/20/25.
//
import Foundation
import SwiftUI

struct ResultPopupView: View {
    let isValid: Bool
    let onClose: () -> Void

    // Transcribed text from the screenshot
    private let disclaimerText = """
    “Check  My  Ticket” is solely a convenience feature of the Florida Lottery Mobile Convenience App and in no way constitutes evidence of game play, ticket purchase, numbers selected or evidence of a winning ticket and cannot be used to validate a winning ticket or claim a prize. Please note that every effort has been made to ensure that the ticket checker results are accurate; however, in the event of an error, the results in the official records of the Florida Lottery shall be controlling. Ticket checker results do not include tickets entered into a second chance promotion.
    """

    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            Text("Are You a Winner?")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.black)
//                .padding(.top, 25)
                .padding(.bottom, 15)
            
            // 2. Result Status Text
            if isValid {
                // The screenshot was a losing ticket, so I put a placeholder here for the winner state
                VStack(spacing: 5) {
                    Text("Congratulations!")
                        .fontWeight(.bold)
                    Text("$50,000.00") // Example Amount
                        .fontWeight(.bold)
                    Text("YOU ARE A WINNER! CLAIM AT DISTRICT OFFICE.") // Example Amount
                        .fontWeight(.bold)
                    
                }
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.bottom, 20)
                
            } else {
                // The requested Losing Text
                Text("Sorry, no winning pattern.\nTotal Win for Ticket: $0.00")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }

            // 3. OK Button
            Button(action: onClose) {
                Text("OK")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 1, green: 0.43, blue: 0.08), Color(red: 1, green: 0.6, blue: 0.01)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 25)

            // 4. Disclaimer Text
            Text(disclaimerText)
                .font(.system(size: 13)) // Smaller font for disclaimer
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
                .lineSpacing(2)
        }
        .frame(width: UIScreen.main.bounds.width * 0.85,
               height: UIScreen.main.bounds.height * 0.6) // Adjust width to mimic popup
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview for Testing
struct ResultPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea() // Dimmed background simulation
            
            // Change isValid to true to see the winning state
            ResultPopupView(isValid: false, onClose: {})
        }
    }
}
