import SwiftUI

struct CustomDialog: View {
    @Binding var isActive: Bool
    
    let title: String
    let message: String
    
    // Offset for animating in/out from the top. Start above the visible area.
    @State private var offsetY: CGFloat = -200
    // Track any vertical drag in progress.
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        // Using a VStack with a Spacer below makes the banner stick to the top.
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
            .shadow(radius: 8)
            .offset(y: offsetY + dragOffset.height)
            // Add a drag gesture. When the user swipes upward beyond a threshold, dismiss.
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        // if the user swipes up more than 50 points, dismiss the banner
                        if value.translation.height < -50 {
                            dismissBanner()
                        } else {
                            // Otherwise, if not enough drag, animate back to original position.
                            withAnimation(.spring()) {
                                offsetY = 0
                            }
                        }
                    }
            )
            
            Spacer() // pushes the banner to the top of the screen.
        }
        .padding(.horizontal, 16)
        .onAppear {
            // Animate the banner into view.
            withAnimation(.spring()) {
                offsetY = 0
            }
            // Auto dismiss after 3 seconds.
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

struct NotificationBanner_Previews: PreviewProvider {
    static var previews: some View {
        // Use a parent view or an overlay to test the banner as a notification.
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            CustomDialog(isActive: .constant(true),
                               title: "New Message",
                               message: "Hello, you have a new notification!")
                .padding(.top, 40)
        }
    }
}
