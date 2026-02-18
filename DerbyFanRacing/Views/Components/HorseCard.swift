import SwiftUI

struct HorseCard: View {
    let horse: Horse
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: Constants.Spacing.l) {
                if let photoData = horse.photoData, let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: Constants.Components.circleFrame)
                        .clipShape(Circle())
                } else {
                    ZStack {
                        Circle()
                            .fill(.accent.opacity(0.2))
                            .frame(width: Constants.Components.circleFrame)
                        
                        Text(horse.initial)
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.accent)
                    }
                }
                
                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                    Text(horse.name)
                        .font(Constants.Fonts.title)
                        .foregroundStyle(.primary)
                    
                    HStack(spacing: Constants.Spacing.s) {
                        Text(horse.coatColor.rawValue)
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                        
                        Text("•")
                            .foregroundStyle(.secondary)
                        
                        Text("\(horse.age) years")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(horse.breed.rawValue)
                        .font(Constants.Fonts.caption)
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.vertical, Constants.Spacing.s)
                        .background(Color.derbyBage.opacity(0.3))
                        .cornerRadius(Constants.CornerRadius.radius / 3)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(Constants.Spacing.l)
            
            if !horse.notes.isEmpty {
                Text(horse.notes)
                    .font(Constants.Fonts.subtitle)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.Spacing.l)
                    .padding(.bottom, Constants.Spacing.l)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
        .cornerRadius(Constants.CornerRadius.radius)
    }
}

#Preview {
    VStack {
        HorseCard(horse: Horse(
            name: "Burya",
            breed: .thoroughbred,
            age: 4,
            coatColor: .bay,
            breeder: "Krasnodar Stables",
            notes: "Strong performer on grass tracks. Shows excellent acceleration in final stretch."
        ))
        .padding()
    }
}
