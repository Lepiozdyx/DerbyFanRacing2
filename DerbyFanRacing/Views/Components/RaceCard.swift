import SwiftUI

struct RaceCard: View {
    let race: Race
    @Environment(\.colorScheme) var colorScheme
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.m) {
            HStack {
                Text(race.name)
                    .font(Constants.Fonts.title)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: Constants.Spacing.s) {
                Text(dateFormatter.string(from: race.date))
                    .font(Constants.Fonts.subtitle)
                    .foregroundStyle(.secondary)
                
                Text("•")
                    .foregroundStyle(.secondary)
                
                Text(race.racetrack)
                    .font(Constants.Fonts.subtitle)
                    .foregroundStyle(.secondary)
                
                Text("•")
                    .foregroundStyle(.secondary)
                
                Text("\(race.distance)m")
                    .font(Constants.Fonts.subtitle)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text(race.surface.rawValue)
                    .font(Constants.Fonts.caption)
                    .padding(.horizontal, Constants.Spacing.m)
                    .padding(.vertical, Constants.Spacing.s)
                    .background(Color.derbyBage.opacity(0.3))
                    .cornerRadius(Constants.CornerRadius.radius / 2)
                
                if !race.participants.isEmpty {
                    Text("\(race.participants.count) participants")
                        .font(Constants.Fonts.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(Constants.Spacing.l)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
        .cornerRadius(Constants.CornerRadius.radius)
    }
}

#Preview {
    RaceCard(race: Race(
        name: "Southern Cup",
        racetrack: "Krasnodar",
        date: Date(),
        distance: 1600,
        surface: .grass,
        weather: .sunny,
        temperature: 22,
        participants: []
    ))
    .padding()
}
