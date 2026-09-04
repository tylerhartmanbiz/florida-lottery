# Florida Lottery (Prank App)

A SwiftUI iOS app that mimics the look and flow of the official Florida Lottery mobile app's "Check My Ticket" barcode scanner — built purely as a prank/gag app to play on friends and family.

> **Disclaimer:** This is a parody project, not affiliated with, endorsed by, or connected to the Florida Lottery or the State of Florida in any way. It cannot validate real tickets, cannot be used to claim a real prize, and produces no real winnings. It's meant to be used as a harmless practical joke between consenting people, not for any kind of fraud or deception with real money at stake.

## How it works

1. The app opens with a splash/loading screen, then a home screen styled after the real Florida Lottery app's main menu.
2. Tapping **Check My Ticket** opens a live camera barcode scanner (built on VisionKit's `DataScannerViewController`).
3. The scanned barcode payload is compared against a single hardcoded "winning" code baked into [`ContentView.swift`](Florida%20Lottery/ContentView.swift).
   - Scan a random ticket → **"Sorry, no winning pattern. Total Win for Ticket: $0.00"**
   - Scan the one specific pre-set code → **"Congratulations! YOU ARE A WINNER! CLAIM AT DISTRICT OFFICE."**
4. A popup styled after the real app's ticket-checker result (including its official-sounding disclaimer text) shows the outcome.

To use it as a prank, print/generate a barcode that encodes the winning value from `ContentView.swift` and have your target scan it with the app.

## Requirements

- Xcode 15+
- iOS 16+ (VisionKit's `DataScannerViewController` requires a physical device with a camera — it does not work in the iOS Simulator)

## Project structure

- `Florida Lottery/Florida_LotteryApp.swift` — app entry point
- `Florida Lottery/RootView.swift` — top-level screen router (loading → main menu → scanner flow)
- `Florida Lottery/LoadingView.swift` — splash screen
- `Florida Lottery/MainScreenView.swift` — fake lottery app home screen / bottom nav
- `Florida Lottery/ContentView.swift` — "Check My Ticket" screen and win/lose logic
- `Florida Lottery/BarcodeScannerView.swift` / `DataScannerView.swift` — camera barcode scanning (VisionKit)
- `Florida Lottery/ResultPopupView.swift` — win/lose result popup
- `Florida Lottery/AppViewModel.swift` — camera permission / scanner availability state
- `Florida Lottery/Assets.xcassets` — app icon and screen images

## Getting started

```bash
open "Florida Lottery.xcodeproj"
```

Build and run on a physical iOS device (camera access required).

## Customizing

- Change the winning barcode value in `ContentView.swift`.
- Change the payout amount / winning message in `ResultPopupView.swift`.
- Swap out the images in `Assets.xcassets` to restyle the app.
