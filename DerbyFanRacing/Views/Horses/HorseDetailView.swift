import SwiftUI

struct HorseDetailView: View {
    let horse: Horse
    let viewModel: HorsesViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    
    private var races: [Race] {
        viewModel.getRacesForHorse(horse)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.Spacing.xl) {
                if let photoData = horse.photoData, let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: Constants.Components.photoFrame, height: Constants.Components.photoFrame)
                        .clipShape(Circle())
                } else {
                    ZStack {
                        Circle()
                            .fill(.accent.opacity(0.2))
                        
                        Text(horse.initial)
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(Color.accentColor)
                    }
                    .frame(width: Constants.Components.photoFrame, height: Constants.Components.photoFrame)
                }
                
                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                    Text("Details")
                        .font(Constants.Fonts.title)
                        .foregroundStyle(.primary)
                    
                    VStack(spacing: Constants.Spacing.l) {
                        HStack {
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Breed")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(horse.breed.rawValue)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: Constants.Spacing.s) {
                                Text("Age")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text("\(horse.age) years")
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Coat Color")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(horse.coatColor.rawValue)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: Constants.Spacing.s) {
                                Text("Breeder")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                Text(horse.breeder.isEmpty ? "—" : horse.breeder)
                                    .font(Constants.Fonts.text)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                    .padding(Constants.Spacing.l)
                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                    .cornerRadius(Constants.CornerRadius.radius)
                    
                    if !horse.notes.isEmpty {
                        VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                            Text("Notes")
                                .font(Constants.Fonts.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(horse.notes)
                                .font(Constants.Fonts.text)
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(Constants.Spacing.l)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                    }
                }
                
                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                    Text("Race History")
                        .font(Constants.Fonts.title)
                        .foregroundStyle(.primary)
                    
                    if races.isEmpty {
                        Text("No race history yet")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, Constants.Spacing.xl)
                    } else {
                        VStack(spacing: Constants.Spacing.m) {
                            ForEach(races) { race in
                                if let participant = race.participants.first(where: { $0.horseId == horse.id }) {
                                    VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                                        HStack {
                                            Image(systemName: Constants.Icons.races)
                                                .foregroundStyle(Color.accentColor)
                                            
                                            Text(race.name)
                                                .font(Constants.Fonts.text)
                                                .foregroundStyle(.primary)
                                            
                                            Spacer()
                                        }
                                        
                                        HStack(spacing: Constants.Spacing.s) {
                                            Text(dateFormatter.string(from: race.date))
                                                .font(Constants.Fonts.caption)
                                                .foregroundStyle(.secondary)
                                            
                                            Text("•")
                                                .foregroundStyle(.secondary)
                                            
                                            Text(race.racetrack)
                                                .font(Constants.Fonts.caption)
                                                .foregroundStyle(.secondary)
                                            
                                            Text("•")
                                                .foregroundStyle(.secondary)
                                            
                                            Text("\(race.distance)m")
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
        .navigationTitle(horse.name)
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
            HorseFormView(viewModel: viewModel, editingHorse: horse)
                .presentationDragIndicator(.visible)
        }
        .alert("Delete Horse", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteHorse(horse)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this horse? This will also remove it from all races. This action cannot be undone.")
        }
    }
}

#Preview {
    NavigationStack {
        HorseDetailView(
            horse: Horse(
                name: "Burya",
                breed: .thoroughbred,
                age: 4,
                coatColor: .bay,
                breeder: "Krasnodar Stables",
                notes: "Strong performer on grass tracks. Shows excellent acceleration in final stretch."
            ),
            viewModel: HorsesViewModel()
        )
    }
}
