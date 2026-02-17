import SwiftUI

struct RaceDetailView: View {
    let race: Race
    let viewModel: RacesViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LogoHeader()
                
                VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                    HStack {
                        Text(race.name)
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: Constants.Spacing.l) {
                        HStack {
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Racetrack")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(race.racetrack)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: Constants.Spacing.s) {
                                Text("Date")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(dateFormatter.string(from: race.date))
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .padding(Constants.Spacing.l)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Distance")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text("\(race.distance) meters")
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: Constants.Spacing.s) {
                                Text("Surface")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(race.surface.rawValue)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .padding(Constants.Spacing.l)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                        
                        VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                            Text("Weather Conditions")
                                .font(Constants.Fonts.caption)
                                .foregroundStyle(.secondary)
                            
                            HStack {
                                Image(systemName: race.weather.icon)
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.accentColor)
                                
                                Text(race.weather.rawValue)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                HStack(spacing: Constants.Spacing.s) {
                                    Image(systemName: "thermometer")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.secondary)
                                    
                                    Text("\(race.temperature)°C")
                                        .font(Constants.Fonts.text)
                                        .foregroundStyle(.primary)
                                }
                            }
                        }
                        .padding(Constants.Spacing.l)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        Text("Participants")
                            .font(Constants.Fonts.title)
                            .foregroundStyle(.primary)
                        
                        if race.participants.isEmpty {
                            Text("No participants added yet")
                                .font(Constants.Fonts.subtitle)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, Constants.Spacing.xl)
                        } else {
                            VStack(spacing: Constants.Spacing.m) {
                                ForEach(race.participants) { participant in
                                    if let horse = StorageManager.shared.getHorse(byId: participant.horseId) {
                                        VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                                            HStack {
                                                Text(horse.name)
                                                    .font(Constants.Fonts.text)
                                                    .foregroundStyle(.primary)
                                                
                                                Spacer()
                                                
                                                Text("\(horse.coatColor.rawValue) • \(horse.age) years")
                                                    .font(Constants.Fonts.caption)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            if !participant.observationNotes.isEmpty {
                                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                                    Text("Observation Notes")
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.secondary)
                                                    
                                                    Text(participant.observationNotes)
                                                        .font(Constants.Fonts.subtitle)
                                                        .foregroundStyle(.primary)
                                                }
                                            }
                                        }
                                        .padding(Constants.Spacing.l)
                                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                        .cornerRadius(Constants.CornerRadius.radius)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(Constants.Spacing.l)
            }
        }
        .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    showingEditSheet = true
                }
                .foregroundStyle(Color.accentColor)
            }
            
            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            RaceFormView(viewModel: viewModel, editingRace: race)
        }
        .alert("Delete Race", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteRace(race)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this race? This action cannot be undone.")
        }
    }
}

#Preview {
    NavigationStack {
        RaceDetailView(
            race: Race(
                name: "Southern Cup",
                racetrack: "Krasnodar",
                date: Date(),
                distance: 1600,
                surface: .grass,
                weather: .sunny,
                temperature: 22,
                participants: []
            ),
            viewModel: RacesViewModel()
        )
    }
}
