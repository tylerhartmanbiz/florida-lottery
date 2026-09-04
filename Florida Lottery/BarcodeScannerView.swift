import SwiftUI
import VisionKit

struct BarcodeScannerView: View {
    
    var onScan: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            ScannerView(onScan: onScan)
            scannerOverlay
        }
        .statusBar(hidden: true)
        .safeAreaInset(edge: .top) { headerBar }
        .ignoresSafeArea()
    }
    
    private var headerBar: some View {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .font(.body)
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 70)      // 👈 adjust this if needed
            .padding(.bottom, 14)
            .background(Color.black)
            .zIndex(10)
        }


    // MARK: - Overlay UI (NEW)
    private var scannerOverlay: some View {
        GeometryReader { geo in
            ZStack {

                // Dark overlay with cutout
                Color.black.opacity(0.6)
                    .mask(
                        Rectangle()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(
                                        width: geo.size.width * 0.9,
                                        height: geo.size.height * 0.20
                                    )
                                    .blendMode(.destinationOut)
                                    .position(
                                        x: geo.size.width / 2,
                                        y: geo.size.height / 2.4
                                    )
                            )
                    )
                    .compositingGroup()

                // White scan frame
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white, lineWidth: 2)
                    .frame(
                        width: geo.size.width * 0.9,
                        height: geo.size.height * 0.20
                    )
                    .position(
                        x: geo.size.width / 2,
                        y: geo.size.height / 2.4
                    )

                // Instruction text
                   
                    Text("Center ticket code")
                        .foregroundColor(.white)
                        .font(.body)
                        .padding(.top, 16)
                        .position(
                            x: geo.size.width / 2,
                            y: geo.size.height * 0.55)
            }
        }
    }
}



private struct ScannerView: UIViewControllerRepresentable {

    var onScan: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onScan: onScan)
    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isGuidanceEnabled: false,      // 🔴 changed
            isHighlightingEnabled: false   // 🔴 changed
        )

        vc.delegate = context.coordinator
        try? vc.startScanning()
        return vc
    }

    func updateUIViewController(
        _ uiViewController: DataScannerViewController,
        context: Context
    ) {}

    static func dismantleUIViewController(
        _ uiViewController: DataScannerViewController,
        coordinator: Coordinator
    ) {
        uiViewController.stopScanning()
    }

    class Coordinator: NSObject, DataScannerViewControllerDelegate {

        let onScan: (String) -> Void
        private var hasScanned = false

        init(onScan: @escaping (String) -> Void) {
            self.onScan = onScan
        }

        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didAdd addedItems: [RecognizedItem],
            allItems: [RecognizedItem]
        ) {
            guard
                !hasScanned,
                let item = addedItems.first,
                case let .barcode(barcode) = item,
                let value = barcode.payloadStringValue
            else { return }

            hasScanned = true
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            onScan(value)
        }
    }
}
