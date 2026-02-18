import SwiftUI

struct HorsesView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = HorsesViewModel()
    @State private var showingAddHorse = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(spacing: 0) {
                        LogoHeader()
                        
                        VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                            Text("Horse Catalog")
                                .font(Constants.Fonts.largeTitle)
                                .foregroundStyle(.primary)
                            
                            Text("Your personal database of racing horses")
                                .font(Constants.Fonts.subtitle)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Constants.Spacing.l)
                        .padding(.top, Constants.Spacing.xl)
                        
                        if !viewModel.horses.isEmpty {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.secondary)
                                
                                TextField("Search horses by name, breed, or color...", text: $viewModel.searchText)
                                    .textFieldStyle(.plain)
                                
                                if !viewModel.searchText.isEmpty {
                                    Button(action: { viewModel.searchText = "" }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .padding(Constants.Spacing.m)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                            .padding(.horizontal, Constants.Spacing.l)
                            .padding(.top, Constants.Spacing.l)
                        }
                        
                        if viewModel.horses.isEmpty {
                            EmptyStateView(
                                icon: Constants.Icons.horses,
                                title: viewModel.searchText.isEmpty ? "No horses yet" : "No horses found",
                                subtitle: viewModel.searchText.isEmpty ? "Add horses to your catalog" : "Try a different search term"
                            )
                            .padding(.top, Constants.Spacing.xxl)
                        } else {
                            LazyVStack(spacing: Constants.Spacing.l) {
                                ForEach(viewModel.horses) { horse in
                                    NavigationLink(destination: HorseDetailView(horse: horse, viewModel: viewModel)) {
                                        HorseCard(horse: horse)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(Constants.Spacing.l)
                        }
                    }
                }
                .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
                
                Button(action: { showingAddHorse = true }) {
                    HStack(spacing: Constants.Spacing.s) {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Add Horse")
                            .font(Constants.Fonts.text)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, Constants.Spacing.l)
                    .padding(.vertical, Constants.Spacing.m)
                    .background(Color.accentColor)
                    .cornerRadius(Constants.CornerRadius.radius)
                }
                .padding(.top, 76)
                .padding(.trailing, Constants.Spacing.l)
            }
            .sheet(isPresented: $showingAddHorse) {
                HorseFormView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    HorsesView()
}
