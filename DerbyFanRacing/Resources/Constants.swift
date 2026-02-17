import SwiftUI

struct Constants {
    
    struct Fonts {
        static let largeTitle: Font = .system(size: 24, weight: .semibold)
        static let title: Font = .system(size: 18, weight: .semibold)
        static let text: Font = .system(size: 16, weight: .medium)
        static let subtitle: Font = .system(size: 14, weight: .regular)
        static let caption: Font = .system(size: 12, weight: .regular)
    }
    
    struct Spacing {
        static let xs: CGFloat = 2
        static let s: CGFloat = 4
        static let m: CGFloat = 8
        static let l: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
    
    struct CornerRadius {
        static let radius: CGFloat = 12
    }
    
    struct Components {
        static let photoFrame: CGFloat = 126
        static let circleFrame: CGFloat = 64
        static let buttonHeight: CGFloat = 36
        static let textField: CGFloat = 36
        static let textEditor: CGFloat = 65
    }
    
    struct Icons {
        static let races = "flag"
        static let horses = "trophy"
        static let calendar = "calendar"
        static let stats = "chart.xyaxis.line"
        static let settings = "gearshape"
    }
}
