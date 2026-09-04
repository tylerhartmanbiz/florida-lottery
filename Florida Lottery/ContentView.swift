import SwiftUI

struct ContentView: View {

    @State private var showScanner = false
    @State private var isValid: Bool?
    @State private var showResultScreen = false


    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                // Existing content
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Color(hex: "#2e3d3b")
                        Color.white
                    }
                    .ignoresSafeArea()

                    Image("IMG_1869")
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                    Button {
                        showScanner = true
                    } label: {
                        Text("SCAN BARCODE")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(
                                width: geo.size.width * 0.9,
                                height: geo.size.height * 0.07
                            )
                            .background(Color(hex: "#db4d68"))
                            .cornerRadius(5)
                    }
                    .position(
                        x: geo.size.width / 2,
                        y: geo.size.height * 0.95
                    )
                }

                // Popup overlay
                if showResultScreen, let valid = isValid {
                    ZStack {
                        // Dark semi-transparent background
                        Color.black.opacity(0.7)
                            .ignoresSafeArea()
                            .onTapGesture {
                                // Optional: close popup if user taps outside
                                showResultScreen = false
                            }

                        // White popup box
                        ResultPopupView(isValid: valid) {
                            showResultScreen = false
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: showResultScreen)
                }

            }

        }
        
        
        
        .fullScreenCover(isPresented: $showScanner) {
            BarcodeScannerView { scannedValue in
                isValid = (scannedValue == "160900397592372058162803378")
                showScanner = false

                DispatchQueue.main.async {
                    showResultScreen = true
                }
            }
        }


    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
