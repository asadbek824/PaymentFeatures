import SwiftUI

// The BannerManager tracks when the banner is active and holds the data to be displayed.
class BannerManager: ObservableObject {
    @Published var isActive: Bool = false
    @Published var title: String = ""
    @Published var amount: Double = 0.0

    // Store pending banner request
    private var pendingTitle: String?
    private var pendingAmount: Double?

    func showBanner(title: String, amount: Double) {
        if isActive {
            // Save the new banner data to show after the current one
            pendingTitle = title
            pendingAmount = amount
            dismissBanner()
        } else {
            show(title: title, amount: amount)
        }
    }

    private func show(title: String, amount: Double) {
        self.title = title
        self.amount = amount
        self.isActive = true
    }

    func dismissBanner(completion: @escaping () -> Void = {}) {
        isActive = false

        // Wait for the dismissal animation before possibly showing next banner
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let nextTitle = self.pendingTitle,
               let nextAmount = self.pendingAmount {
                // Clear the pending request
                self.pendingTitle = nil
                self.pendingAmount = nil
                self.show(title: nextTitle, amount: nextAmount)
            }
            completion()
        }
    }
}


struct CustomDialog: View {
    @Binding var isActive: Bool

    let title: String
    let amount: Double  // The amount value received from the backend.

    // Offset for animating in/out from the top. Start above the visible area.
    @State private var offsetY: CGFloat = -200

    var body: some View {
        // Using a VStack with a Spacer below makes the banner stick to the top.
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    // Compose the message with two Text views for different styling.
                    (
                        Text("Transferred to the card: ")
                        +
                        Text("\(amount, specifier: "%.2f")")
                            .foregroundColor(.blue) // You can change .blue to any color you need.
                            .fontWeight(.semibold)
                    )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray, radius: 3, x: 0, y: 1)
            .offset(y: offsetY)
            // Dismiss the popup on tap or drag.
            .onTapGesture {
                dismissBanner()
            }
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        dismissBanner()
                    }
            )
            
            Spacer() // Pushes the banner to the top of the screen.
        }
        .padding(.horizontal, 16)
        .onAppear {
            // Animate the banner into view.
            withAnimation(.spring()) {
                offsetY = 0
            }
            // Auto dismiss after 3 seconds if the banner is not interacted with.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                dismissBanner()
            }
        }
    }
    
    /// Animates the dismissal of the banner.
    private func dismissBanner() {
        withAnimation(.spring()) {
            offsetY = -200
        }
        // Delay updating isActive so the dismiss animation is visible.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isActive = false
        }
    }
}

struct ContentView: View {
    @StateObject private var bannerManager = BannerManager()

    var body: some View {
        ZStack {
            // Your normal content goes here. For demo purposes, we add two buttons.
            VStack(spacing: 20) {
                Button("Show Banner") {
                    // When tapping this button a banner is shown.
                    bannerManager.showBanner(title: "Transaction Success", amount: 150.00)
                }
                Button("Show Another Banner") {
                    // This call demonstrates showing a new banner if one is already being shown.
                    bannerManager.showBanner(title: "New Transaction", amount: 250.00)
                }
            }
            .padding()

            // The banner is displayed as an overlay when active.
            if bannerManager.isActive {
                CustomDialog(isActive: $bannerManager.isActive,
                             title: bannerManager.title,
                             amount: bannerManager.amount)
                    .transition(.move(edge: .top))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: bannerManager.isActive)
    }
}

struct NotificationBanner_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
