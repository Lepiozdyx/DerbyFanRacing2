import SwiftUI

struct RacesView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = RacesViewModel()
    @State private var showingAddRace = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: Constants.Spacing.xs) {
                    LogoHeader()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                            HStack {
                                Text("Race Journal")
                                    .font(Constants.Fonts.largeTitle)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Button {
                                    showingAddRace = true
                                } label: {
                                    HStack(spacing: Constants.Spacing.s) {
                                        Image(systemName: "plus")
                                            .font(Constants.Fonts.text)
                                        
                                        Text("New Race")
                                            .font(Constants.Fonts.text)
                                    }
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, Constants.Spacing.l)
                                    .padding(.vertical, Constants.Spacing.m)
                                    .background(.accent)
                                    .cornerRadius(Constants.CornerRadius.radius/2)
                                }
                            }
                            
                            Text("Track and analyze horse racing performance")
                                .font(Constants.Fonts.subtitle)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Constants.Spacing.l)
                        .padding(.top, Constants.Spacing.xl)
                        
                        if viewModel.races.isEmpty {
                            EmptyStateView(
                                icon: Constants.Icons.races,
                                title: "No races yet",
                                subtitle: "Create your first race to start tracking"
                            )
                            .padding(.top, Constants.Spacing.xxl)
                        } else {
                            LazyVStack(spacing: Constants.Spacing.s) {
                                ForEach(viewModel.races) { race in
                                    NavigationLink(destination: RaceDetailView(race: race, viewModel: viewModel)) {
                                        RaceCard(race: race)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(Constants.Spacing.l)
                        }
                    }
                }
                .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
            }
            .sheet(isPresented: $showingAddRace) {
                RaceFormView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    RacesView()
}
