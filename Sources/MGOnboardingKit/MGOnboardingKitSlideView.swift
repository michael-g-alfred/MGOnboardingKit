import SwiftUI

    // MARK: Slide View
@available(iOS 26.0, *)
struct MGOnboardingKitSlideView: View {
    let item: MGOnboardingItem
    let isLast: Bool
    let nextButtonTitle: String
    let lastButtonTitle: String
    let isSkipVisible: Bool
    let nextAction: () -> Void
    let skipAction: () -> Void
    
    @State private var anim: [CGFloat] = [0.6, 0, 24, 0, 20, 0] // Scale, Opacity, Offsets
    
    var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                Color(red: 0.05, green: 0.05, blue: 0.12).ignoresSafeArea()
            } else {
                    // Fallback on earlier versions
            }
            
            VStack {
                Spacer()
                
                if item.isLogoVisible {
                    OnboardingLogo(item: item, scale: anim[0], opacity: anim[1])
                }
                
                Spacer().frame(height: 44)
                
                OnboardingTitle(item: item, offset: anim[2], opacity: anim[3])
                
                Spacer().frame(height: 16)
                
                if item.isDescriptionVisible {
                    OnboardingDescription(item: item, offset: anim[4], opacity: anim[5])
                }
                
                Spacer()
                
                HStack {
                    if isSkipVisible {
                        OnboardingButton(title: "Skip", icon: "", visible: false, color: item.buttonColor, opacity: 0.5, action: skipAction)
                    }
                    Spacer()
                    OnboardingButton(
                        title: isLast ? lastButtonTitle : nextButtonTitle,
                        icon: isLast ? "checkmark" : item.nextButtonIcon,
                        visible: true,
                        color: item.buttonColor,
                        action: nextAction
                    )
                }
                .padding(.horizontal, 32).padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.55).delay(0.1)) { anim[0] = 1; anim[1] = 1 }
            withAnimation(.easeOut(duration: 0.55).delay(0.45)) { anim[2] = 0; anim[3] = 1 }
            withAnimation(.easeOut(duration: 0.55).delay(0.65)) { anim[4] = 0; anim[5] = 1 }
        }
    }
}

    // MARK: Components
@available(iOS 26.0, *)
struct OnboardingLogo: View {
    let item: MGOnboardingItem
    var scale: CGFloat; var opacity: Double
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: item.logoCornerRadius, style: .continuous)
                .fill(LinearGradient(colors: item.logoGradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: item.logoFrameSize, height: item.logoFrameSize)
                .overlay(RoundedRectangle(cornerRadius: item.logoCornerRadius).stroke(Color.white.opacity(0.12), lineWidth: item.logoBorderLineWidth))
            Image(systemName: item.logoSystemImage).font(.system(size: item.logoFrameSize/1.6)).foregroundStyle(item.logoMainColor)
        }.scaleEffect(scale).opacity(opacity)
    }
}

@available(iOS 26.0, *)
struct OnboardingTitle: View {
    let item: MGOnboardingItem
    var offset: CGFloat; var opacity: Double
    var body: some View {
        Text(item.title).font(.largeTitle).bold().fontDesign(item.titleDesign).multilineTextAlignment(.center).foregroundStyle(item.titleColor).offset(y: offset).opacity(opacity)
    }
}

@available(iOS 26.0, *)
struct OnboardingDescription: View {
    let item: MGOnboardingItem
    var offset: CGFloat; var opacity: Double
    var body: some View {
        Text(item.description).font(.body).fontDesign(item.descriptionDesign).multilineTextAlignment(.center).foregroundColor(item.descriptionColor).frame(maxWidth: 320).offset(y: offset).opacity(opacity)
    }
}

@available(iOS 26.0, *)
struct OnboardingButton: View {
    var title: String; var icon: String; var visible: Bool; var color: Color; var opacity: Double = 1.0; var action: () -> Void
    var body: some View {
        Button(action: action) {
            if visible { Label(title, systemImage: icon) } else { Text(title) }
        }.foregroundStyle(color).buttonStyle(.glassProminent).controlSize(.extraLarge).opacity(opacity)
    }
}
