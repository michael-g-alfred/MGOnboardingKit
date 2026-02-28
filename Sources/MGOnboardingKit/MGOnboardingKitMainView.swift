import SwiftUI

    // MARK: (Main Container)
@available(iOS 26.0, *)
struct MGOnboardingKitMainView: View {
    var items: [MGOnboardingItem]
    var nextButtonTitle: String  = "Next"
    var lastButtonTitle: String  = "Start"
    var onFinish: () -> Void
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<items.count, id: \.self) { index in
                let item = items[index]
                let isLast = (index == items.count - 1)
                
                MGOnboardingKitSlideView(
                    item: item,
                    isLast: isLast,
                    nextButtonTitle: nextButtonTitle,
                    lastButtonTitle: lastButtonTitle,
                    isSkipVisible: !isLast,
                    nextAction: { withAnimation { isLast ? onFinish() : (currentIndex += 1) } },
                    skipAction: { onFinish() }
                )
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
    }
}
