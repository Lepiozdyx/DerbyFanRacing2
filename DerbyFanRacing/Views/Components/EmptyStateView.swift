import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: Constants.Spacing.l) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            VStack(spacing: Constants.Spacing.s) {
                Text(title)
                    .font(Constants.Fonts.title)
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(Constants.Fonts.subtitle)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(Constants.Spacing.xl)
    }
}

#Preview {
    EmptyStateView(
        icon: "flag",
        title: "No races yet",
        subtitle: "Create your first race to start tracking"
    )
}
