import SwiftUI

    // MARK: Slide View
@available(iOS 26.0, *)
public struct MGOnboardingKitSlideView: View {
    public let item: MGOnboardingItem
    public let isLast: Bool
    public let nextButtonTitle: String
    public let lastButtonTitle: String
    public let isSkipVisible: Bool
    public let nextAction: () -> Void
    public let skipAction: () -> Void
    
    @State private var anim: [CGFloat] = [0.6, 0, 24, 0, 20, 0]
    
    public init(
        item: MGOnboardingItem,
        isLast: Bool,
        nextButtonTitle: String,
        lastButtonTitle: String,
        isSkipVisible: Bool,
        nextAction: @escaping () -> Void,
        skipAction: @escaping () -> Void
    ) {
        self.item = item
        self.isLast = isLast
        self.nextButtonTitle = nextButtonTitle
        self.lastButtonTitle = lastButtonTitle
        self.isSkipVisible = isSkipVisible
        self.nextAction = nextAction
        self.skipAction = skipAction
    }
    
    public var body: some View {
        ZStack {
            LinearGradient(
                colors: item.backgroundColor,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
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
public struct OnboardingLogo: View {
    public let item: MGOnboardingItem
    public var scale: CGFloat
    public var opacity: Double
    
    public init(item: MGOnboardingItem, scale: CGFloat, opacity: Double) {
        self.item = item
        self.scale = scale
        self.opacity = opacity
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: item.logoCornerRadius, style: .continuous)
                .fill(LinearGradient(colors: item.logoGradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: item.logoFrameSize, height: item.logoFrameSize)
                .overlay(RoundedRectangle(cornerRadius: item.logoCornerRadius).stroke(Color.white.opacity(0.12), lineWidth: item.logoBorderLineWidth))
            Image(systemName: item.logoSystemImage)
                .font(.system(size: item.logoFrameSize / 1.6))
                .foregroundStyle(item.logoMainColor)
        }
        .scaleEffect(scale)
        .opacity(opacity)
    }
}

@available(iOS 26.0, *)
public struct OnboardingTitle: View {
    public let item: MGOnboardingItem
    public var offset: CGFloat
    public var opacity: Double
    
    public init(item: MGOnboardingItem, offset: CGFloat, opacity: Double) {
        self.item = item
        self.offset = offset
        self.opacity = opacity
    }
    
    public var body: some View {
        Text(item.title)
            .font(.largeTitle)
            .bold()
            .fontDesign(item.titleDesign)
            .multilineTextAlignment(.center)
            .foregroundStyle(item.titleColor)
            .offset(y: offset)
            .opacity(opacity)
    }
}

@available(iOS 26.0, *)
public struct OnboardingDescription: View {
    public let item: MGOnboardingItem
    public var offset: CGFloat
    public var opacity: Double
    
    public init(item: MGOnboardingItem, offset: CGFloat, opacity: Double) {
        self.item = item
        self.offset = offset
        self.opacity = opacity
    }
    
    public var body: some View {
        Text(item.description)
            .font(.body)
            .fontDesign(item.descriptionDesign)
            .multilineTextAlignment(.center)
            .foregroundColor(item.descriptionColor)
            .frame(maxWidth: 320)
            .offset(y: offset)
            .opacity(opacity)
    }
}

@available(iOS 26.0, *)
public struct OnboardingButton: View {
    public var title: String
    public var icon: String
    public var visible: Bool
    public var color: Color
    public var opacity: Double
    public var action: () -> Void
    
    public init(title: String, icon: String, visible: Bool, color: Color, opacity: Double = 1.0, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.visible = visible
        self.color = color
        self.opacity = opacity
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            if visible {
                Label(title, systemImage: icon)
            } else {
                Text(title)
            }
        }
        .foregroundStyle(color)
        .buttonStyle(.glassProminent)
        .controlSize(.extraLarge)
        .opacity(opacity)
    }
}
