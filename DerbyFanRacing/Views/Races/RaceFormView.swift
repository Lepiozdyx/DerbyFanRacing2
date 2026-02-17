import SwiftUI

struct RaceFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    let viewModel: RacesViewModel
    let editingRace: Race?
    
    @State private var name = ""
    @State private var racetrack = ""
    @State private var date = Date()
    @State private var distance = ""
    @State private var surface: TrackSurface = .grass
    @State private var weather: WeatherCondition = .sunny
    @State private var temperature = "20"
    @State private var participants: [Participant] = []
    @State private var showingAddParticipant = false
    
    init(viewModel: RacesViewModel, editingRace: Race? = nil) {
        self.viewModel = viewModel
        self.editingRace = editingRace
        
        if let race = editingRace {
            _name = State(initialValue: race.name)
            _racetrack = State(initialValue: race.racetrack)
            _date = State(initialValue: race.date)
            _distance = State(initialValue: String(race.distance))
            _surface = State(initialValue: race.surface)
            _weather = State(initialValue: race.weather)
            _temperature = State(initialValue: String(race.temperature))
            _participants = State(initialValue: race.participants)
        }
    }
    
    private var isValid: Bool {
        !name.isEmpty && !racetrack.isEmpty && !distance.isEmpty && Int(distance) != nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.xl) {
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        Text("Race Information")
                            .font(Constants.Fonts.title)
                            .foregroundStyle(.primary)
                        
                        VStack(spacing: Constants.Spacing.l) {
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Race Name")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextField("e.g., Southern Cup", text: $name)
                                    .textFieldStyle(.plain)
                                    .padding(Constants.Spacing.m)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Racetrack")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextField("e.g., Krasnodar", text: $racetrack)
                                    .textFieldStyle(.plain)
                                    .padding(Constants.Spacing.m)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Date")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .padding(Constants.Spacing.m)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            HStack(spacing: Constants.Spacing.l) {
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Distance (meters)")
                                        .font(Constants.Fonts.subtitle)
                                        .foregroundStyle(.primary)
                                    
                                    TextField("1600", text: $distance)
                                        .textFieldStyle(.plain)
                                        .keyboardType(.numberPad)
                                        .padding(Constants.Spacing.m)
                                        .frame(height: Constants.Components.textField)
                                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                        .cornerRadius(Constants.CornerRadius.radius)
                                }
                                
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Track Surface")
                                        .font(Constants.Fonts.subtitle)
                                        .foregroundStyle(.primary)
                                    
                                    Picker("", selection: $surface) {
                                        ForEach(TrackSurface.allCases, id: \.self) { surface in
                                            Text(surface.rawValue).tag(surface)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .padding(.horizontal, Constants.Spacing.m)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Weather Conditions")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                HStack(spacing: Constants.Spacing.m) {
                                    ForEach(WeatherCondition.allCases, id: \.self) { condition in
                                        Button(action: { weather = condition }) {
                                            Image(systemName: condition.icon)
                                                .font(.system(size: 20))
                                                .foregroundStyle(weather == condition ? .white : .primary)
                                                .frame(width: 50, height: 50)
                                                .background(weather == condition ? Color.accentColor : (colorScheme == .dark ? Color("cardColorDark") : Color("cardColor")))
                                                .cornerRadius(Constants.CornerRadius.radius)
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Temperature (°C)")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextField("20", text: $temperature)
                                    .textFieldStyle(.plain)
                                    .keyboardType(.numberPad)
                                    .padding(Constants.Spacing.m)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        HStack {
                            Text("Participants")
                                .font(Constants.Fonts.title)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Button(action: { showingAddParticipant = true }) {
                                HStack(spacing: Constants.Spacing.s) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 12))
                                    Text("Add Horse")
                                        .font(Constants.Fonts.subtitle)
                                }
                                .foregroundStyle(Color.accentColor)
                            }
                        }
                        
                        if participants.isEmpty {
                            Text("No participants added yet")
                                .font(Constants.Fonts.subtitle)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, Constants.Spacing.xl)
                        } else {
                            VStack(spacing: Constants.Spacing.m) {
                                ForEach(participants) { participant in
                                    if let horse = StorageManager.shared.getHorse(byId: participant.horseId) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                                Text(horse.name)
                                                    .font(Constants.Fonts.text)
                                                    .foregroundStyle(.primary)
                                                
                                                if !participant.observationNotes.isEmpty {
                                                    Text(participant.observationNotes)
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.secondary)
                                                        .lineLimit(2)
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                participants.removeAll { $0.id == participant.id }
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                        .padding(Constants.Spacing.m)
                                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                        .cornerRadius(Constants.CornerRadius.radius)
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack(spacing: Constants.Spacing.l) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .font(Constants.Fonts.text)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: Constants.Components.buttonHeight)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                        
                        Button(editingRace == nil ? "Create Race" : "Update Race") {
                            saveRace()
                        }
                        .font(Constants.Fonts.text)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: Constants.Components.buttonHeight)
                        .background(isValid ? Color.accentColor : Color.gray)
                        .cornerRadius(Constants.CornerRadius.radius)
                        .disabled(!isValid)
                    }
                }
                .padding(Constants.Spacing.l)
            }
            .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
            .navigationTitle(editingRace == nil ? "New Race" : "Edit Race")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddParticipant) {
                AddParticipantView(participants: $participants)
            }
        }
    }
    
    private func saveRace() {
        guard let distanceInt = Int(distance),
              let temperatureInt = Int(temperature) else { return }
        
        if let editingRace = editingRace {
            editingRace.name = name
            editingRace.racetrack = racetrack
            editingRace.date = date
            editingRace.distance = distanceInt
            editingRace.surface = surface
            editingRace.weather = weather
            editingRace.temperature = temperatureInt
            editingRace.participants = participants
            viewModel.updateRace(editingRace)
        } else {
            let race = Race(
                name: name,
                racetrack: racetrack,
                date: date,
                distance: distanceInt,
                surface: surface,
                weather: weather,
                temperature: temperatureInt,
                participants: participants
            )
            viewModel.addRace(race)
        }
        
        dismiss()
    }
}

struct AddParticipantView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Binding var participants: [Participant]
    
    @State private var selectedHorseId: UUID?
    @State private var observationNotes = ""
    
    private var horses: [Horse] {
        StorageManager.shared.horses
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.xl) {
                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                    Text("Select Horse")
                        .font(Constants.Fonts.subtitle)
                        .foregroundStyle(.primary)
                    
                    if horses.isEmpty {
                        Text("No horses available. Add horses first.")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(Constants.Spacing.xl)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                    } else {
                        Picker("Choose a horse", selection: $selectedHorseId) {
                            Text("Choose a horse").tag(nil as UUID?)
                            ForEach(horses) { horse in
                                Text(horse.name).tag(horse.id as UUID?)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(Constants.Spacing.m)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                    }
                }
                
                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                    Text("Observation Notes")
                        .font(Constants.Fonts.subtitle)
                        .foregroundStyle(.primary)
                    
                    TextEditor(text: $observationNotes)
                        .frame(height: Constants.Components.textEditor)
                        .padding(Constants.Spacing.s)
                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                        .cornerRadius(Constants.CornerRadius.radius)
                        .scrollContentBackground(.hidden)
                }
                
                Button("Add Participant") {
                    if let horseId = selectedHorseId {
                        let participant = Participant(horseId: horseId, observationNotes: observationNotes)
                        participants.append(participant)
                        dismiss()
                    }
                }
                .font(Constants.Fonts.text)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.Components.buttonHeight)
                .background(selectedHorseId != nil ? Color.accentColor : Color.gray)
                .cornerRadius(Constants.CornerRadius.radius)
                .disabled(selectedHorseId == nil)
                
                Spacer()
            }
            .padding(Constants.Spacing.l)
            .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
            .navigationTitle("Add Participant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    RaceFormView(viewModel: RacesViewModel())
}
