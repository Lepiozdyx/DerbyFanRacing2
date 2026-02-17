import SwiftUI

struct LogoHeader: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .padding(.vertical, Constants.Spacing.m)
            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
    }
}

#Preview {
    LogoHeader()
}
