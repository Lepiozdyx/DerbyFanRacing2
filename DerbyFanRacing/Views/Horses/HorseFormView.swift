import SwiftUI
import PhotosUI

struct HorseFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    let viewModel: HorsesViewModel
    let editingHorse: Horse?
    
    @State private var name = ""
    @State private var breed: HorseBreed = .thoroughbred
    @State private var age = ""
    @State private var coatColor: CoatColor = .bay
    @State private var breeder = ""
    @State private var notes = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?
    
    init(viewModel: HorsesViewModel, editingHorse: Horse? = nil) {
        self.viewModel = viewModel
        self.editingHorse = editingHorse
        
        if let horse = editingHorse {
            _name = State(initialValue: horse.name)
            _breed = State(initialValue: horse.breed)
            _age = State(initialValue: String(horse.age))
            _coatColor = State(initialValue: horse.coatColor)
            _breeder = State(initialValue: horse.breeder)
            _notes = State(initialValue: horse.notes)
            _photoData = State(initialValue: horse.photoData)
        }
    }
    
    private var isValid: Bool {
        !name.isEmpty && !age.isEmpty && Int(age) != nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.xl) {
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        Text("Basic Information")
                            .font(Constants.Fonts.title)
                            .foregroundStyle(.primary)
                        
                        VStack(spacing: Constants.Spacing.l) {
                            PhotosPicker(selection: $photoItem, matching: .images) {
                                if let photoData = photoData, let uiImage = UIImage(data: photoData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Constants.Components.photoFrame)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.accentColor, lineWidth: 2)
                                        )
                                } else {
                                    ZStack {
                                        Circle()
                                            .fill(.accent.opacity(0.2))
                                            .frame(width: Constants.Components.photoFrame, height: Constants.Components.photoFrame)
                                        
                                        VStack(spacing: Constants.Spacing.s) {
                                            Image(systemName: "camera.fill")
                                                .font(Constants.Fonts.largeTitle)
                                                .foregroundStyle(Color.accentColor)
                                            
                                            Text("Add Photo")
                                                .font(Constants.Fonts.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .onChange(of: photoItem) { _, newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        photoData = data
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Horse Name")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextField("e.g., Thunder Road", text: $name)
                                    .textFieldStyle(.plain)
                                    .padding(Constants.Spacing.m)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            HStack(spacing: Constants.Spacing.l) {
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Breed")
                                        .font(Constants.Fonts.subtitle)
                                        .foregroundStyle(.primary)
                                    
                                    Picker("", selection: $breed) {
                                        ForEach(HorseBreed.allCases, id: \.self) { breed in
                                            Text(breed.rawValue).tag(breed)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .padding(.horizontal, Constants.Spacing.m)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                                }
                                
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Age (years)")
                                        .font(Constants.Fonts.subtitle)
                                        .foregroundStyle(.primary)
                                    
                                    TextField("4", text: $age)
                                        .textFieldStyle(.plain)
                                        .keyboardType(.numberPad)
                                        .padding(Constants.Spacing.m)
                                        .frame(height: Constants.Components.textField)
                                        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                        .cornerRadius(Constants.CornerRadius.radius)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Coat Color")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                Picker("", selection: $coatColor) {
                                    ForEach(CoatColor.allCases, id: \.self) { color in
                                        Text(color.rawValue).tag(color)
                                    }
                                }
                                .pickerStyle(.menu)
                                .padding(.horizontal, Constants.Spacing.m)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: Constants.Components.textField)
                                .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Breeder")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextField("e.g., Krasnodar Stables", text: $breeder)
                                    .textFieldStyle(.plain)
                                    .padding(Constants.Spacing.m)
                                    .frame(height: Constants.Components.textField)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                Text("Notes & Description")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                TextEditor(text: $notes)
                                    .frame(height: 120)
                                    .padding(Constants.Spacing.s)
                                    .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                    .cornerRadius(Constants.CornerRadius.radius)
                                    .scrollContentBackground(.hidden)
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
                        
                        Button(editingHorse == nil ? "Add Horse" : "Update Horse") {
                            saveHorse()
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
            .navigationTitle(editingHorse == nil ? "Add Horse" : "Edit Horse")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveHorse() {
        guard let ageInt = Int(age) else { return }
        
        if let editingHorse = editingHorse {
            editingHorse.name = name
            editingHorse.breed = breed
            editingHorse.age = ageInt
            editingHorse.coatColor = coatColor
            editingHorse.breeder = breeder
            editingHorse.notes = notes
            editingHorse.photoData = photoData
            viewModel.updateHorse(editingHorse)
        } else {
            let horse = Horse(
                name: name,
                breed: breed,
                age: ageInt,
                coatColor: coatColor,
                breeder: breeder,
                notes: notes,
                photoData: photoData
            )
            viewModel.addHorse(horse)
        }
        
        dismiss()
    }
}

#Preview {
    HorseFormView(viewModel: HorsesViewModel())
}
