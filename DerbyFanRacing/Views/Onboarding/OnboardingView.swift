import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Skip") {
                    hasCompletedOnboarding = true
                }
                .font(Constants.Fonts.text)
                .foregroundStyle(.accent)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            }
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    PageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .ignoresSafeArea(edges: .top)
            
            Button {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    hasCompletedOnboarding = true
                }
            } label: {
                HStack(spacing: Constants.Spacing.s) {
                    Text(currentPage < pages.count - 1
                         ? "Next"
                         : "Get Started")
                        .font(Constants.Fonts.text)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.primary)
                .padding(.horizontal, Constants.Spacing.l)
                .padding(.vertical, Constants.Spacing.m)
                .background(.orange)
                .cornerRadius(Constants.CornerRadius.radius/2)
            }
            .padding([.bottom, .horizontal], 24)
        }
        .background(
            Image(.startbg)
                .resizable()
                .ignoresSafeArea()
        )
    }
    
    private let pages: [Page] = [
        Page(
            icon: "logo",
            title: "Track Horse Racing Like a Professional",
            description: "Record races, observe horses, and build your personal racing journal."
        ),
        Page(
            icon: "miniOnb2",
            title: "Detailed Race Records",
            description: "Save race details, participants, conditions, and your personal observations."
        ),
        Page(
            icon: "miniOnb3",
            title: "Your Horse Database",
            description: "Create profiles, add photos, track performance history over time."
        ),
        Page(
            icon: "miniOnb4",
            title: "See Patterns and Progress",
            description: "Explore race history in the calendar and analyze statistics by horse and track."
        ),
        Page(
            icon: "logo2",
            title: "Analysis Only. No Betting.",
            description: "Derby Fan Racing City is an analytical and educational tool. It does not support gambling, betting, or monetary features."
        )
    ]
}

struct Page {
    let icon: String
    let title: String
    let description: String
}

struct PageView: View {
    let page: Page
    
    var body: some View {
        VStack(spacing: 40) {
            Image(page.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding(.horizontal)

            VStack(spacing: 10) {
                Text(page.title)
                    .font(Constants.Fonts.largeTitle)
                    .foregroundStyle(.onb)
                    .multilineTextAlignment(.center)

                Text(page.description)
                    .font(Constants.Fonts.text)
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}


#Preview {
    OnboardingView()
}

