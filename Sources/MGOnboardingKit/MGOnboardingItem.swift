import SwiftUI

@available(iOS 26.0, *)
public struct MGOnboardingItem: Identifiable {
    public let id = UUID()
    
        // MARK: - Core Content
    public var title: String
    public var description: String
    public var logoSystemImage: String                  = "photo"
    
        // MARK: - Component Visibility
    public var isLogoVisible: Bool                      = true
    public var isDescriptionVisible: Bool               = true
    
        // MARK: - Logo Customization
    public var logoFrameSize: CGFloat                   = 100
    public var logoCornerRadius: CGFloat                = 28
    public var logoGradientColors: [Color]              = [
        Color(red: 0.42, green: 0.24, blue: 0.95),
        Color(red: 0.18, green: 0.10, blue: 0.72)
    ]
    public var logoMainColor: Color                     = .white
    public var logoBorderLineWidth: CGFloat             = 5
    
        // MARK: - Typography Customization
    public var titleColor: Color                        = .white
    public var titleDesign: Font.Design                 = .rounded
    public var descriptionColor: Color                  = .white.opacity(0.8)
    public var descriptionDesign: Font.Design           = .rounded
    
        // MARK: - Button & Style Customization
    public var buttonColor: Color                       = .white
    public var nextButtonIcon: String                   = "arrow.right"
    public var backgroundColor: [Color]                 = [
        Color(red: 0.05, green: 0.05, blue: 0.12),
        Color(red: 0.08, green: 0.04, blue: 0.18)
    ]
    
    public init(
        title: String,
        description: String,
        logoSystemImage: String,
        isLogoVisible: Bool,
        isDescriptionVisible: Bool,
        logoFrameSize: CGFloat,
        logoCornerRadius: CGFloat,
        logoGradientColors: [Color],
        logoMainColor: Color,
        logoBorderLineWidth: CGFloat,
        titleColor: Color,
        titleDesign: Font.Design,
        descriptionColor: Color,
        descriptionDesign: Font.Design,
        buttonColor: Color,
        nextButtonIcon: String,
        backgroundColor: [Color]
    ) {
        self.title = title
        self.description = description
        self.logoSystemImage = logoSystemImage
        self.isLogoVisible = isLogoVisible
        self.isDescriptionVisible = isDescriptionVisible
        self.logoFrameSize = logoFrameSize
        self.logoCornerRadius = logoCornerRadius
        self.logoGradientColors = logoGradientColors
        self.logoMainColor = logoMainColor
        self.logoBorderLineWidth = logoBorderLineWidth
        self.titleColor = titleColor
        self.titleDesign = titleDesign
        self.descriptionColor = descriptionColor
        self.descriptionDesign = descriptionDesign
        self.buttonColor = buttonColor
        self.nextButtonIcon = nextButtonIcon
        self.backgroundColor = backgroundColor
    }
}
