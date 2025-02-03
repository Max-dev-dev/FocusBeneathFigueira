import SwiftUI

struct LoaderView: View {
    @State var onboard = false
    let close: () -> Void
    var body: some View {
        if onboard {
            OnboardingView() {
                close()
            }
        } else {
            Image(.loaderImageForScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        onboard = true
                    }
                }
        }
    }
}

#Preview {
    LoaderView() {}
}
