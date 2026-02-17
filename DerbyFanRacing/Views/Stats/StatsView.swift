import SwiftUI
import Charts

struct StatsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    LogoHeader()
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        Text("Statistics")
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.primary)
                        
                        Text("Analytics and insights from your racing journal")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.Spacing.l)
                    .padding(.top, Constants.Spacing.xl)
                    
                    if viewModel.totalRaces == 0 {
                        EmptyStateView(
                            icon: Constants.Icons.stats,
                            title: "No statistics yet",
                            subtitle: "Add races to see insights"
                        )
                        .padding(.top, Constants.Spacing.xxl)
                    } else {
                        VStack(spacing: Constants.Spacing.l) {
                            HStack(spacing: Constants.Spacing.l) {
                                StatCard(title: "Total Races", value: "\(viewModel.totalRaces)")
                                StatCard(title: "Horses Tracked", value: "\(viewModel.horsesTracked)")
                            }
                            
                            HStack(spacing: Constants.Spacing.l) {
                                StatCard(title: "Past Races", value: "\(viewModel.pastRaces)")
                                StatCard(title: "Upcoming", value: "\(viewModel.upcomingRaces)")
                            }
                            
                            if !viewModel.raceActivityOverTime.isEmpty {
                                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                                    Text("Race Activity Over Time")
                                        .font(Constants.Fonts.title)
                                        .foregroundStyle(.primary)
                                    
                                    Chart(viewModel.raceActivityOverTime) { data in
                                        BarMark(
                                            x: .value("Month", data.month),
                                            y: .value("Count", data.count)
                                        )
                                        .foregroundStyle(Color.accentColor)
                                    }
                                    .frame(height: 200)
                                    .chartYAxis {
                                        AxisMarks(position: .leading)
                                    }
                                }
                                .padding(Constants.Spacing.l)
                                .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            if !viewModel.racetrackActivity.isEmpty {
                                VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                                    Text("Racetrack Activity")
                                        .font(Constants.Fonts.title)
                                        .foregroundStyle(.primary)
                                    
                                    VStack(spacing: Constants.Spacing.m) {
                                        ForEach(viewModel.racetrackActivity) { data in
                                            HStack {
                                                Text(data.racetrack)
                                                    .font(Constants.Fonts.text)
                                                    .foregroundStyle(.primary)
                                                
                                                Spacer()
                                                
                                                ZStack(alignment: .leading) {
                                                    Rectangle()
                                                        .fill(Color("derbyGray"))
                                                        .frame(width: 120, height: 8)
                                                        .cornerRadius(4)
                                                    
                                                    Rectangle()
                                                        .fill(Color.accentColor)
                                                        .frame(width: CGFloat(data.count) / CGFloat(viewModel.totalRaces) * 120, height: 8)
                                                        .cornerRadius(4)
                                                }
                                                
                                                Text("\(data.count)")
                                                    .font(Constants.Fonts.text)
                                                    .foregroundStyle(.primary)
                                                    .frame(width: 30, alignment: .trailing)
                                            }
                                        }
                                    }
                                    
                                    HStack {
                                        Text("Most Active")
                                            .font(Constants.Fonts.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text("\(viewModel.mostActiveRacetrack) (\(viewModel.mostActiveRacetrackCount) races)")
                                            .font(Constants.Fonts.caption)
                                            .foregroundStyle(.primary)
                                    }
                                    .padding(.top, Constants.Spacing.s)
                                }
                                .padding(Constants.Spacing.l)
                                .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                .cornerRadius(Constants.CornerRadius.radius)
                            }
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                                Text("Track Preferences")
                                    .font(Constants.Fonts.title)
                                    .foregroundStyle(.primary)
                                
                                VStack(spacing: Constants.Spacing.m) {
                                    HStack {
                                        Text("Surface Type")
                                            .font(Constants.Fonts.subtitle)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Grass")
                                            .font(Constants.Fonts.text)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                        
                                        Text("\(viewModel.grassRacesCount) races")
                                            .font(Constants.Fonts.text)
                                            .foregroundStyle(.primary)
                                    }
                                    
                                    HStack {
                                        Text("Dirt")
                                            .font(Constants.Fonts.text)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                        
                                        Text("\(viewModel.dirtRacesCount) races")
                                            .font(Constants.Fonts.text)
                                            .foregroundStyle(.primary)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, Constants.Spacing.s)
                                    
                                    HStack {
                                        Text("Average Distance")
                                            .font(Constants.Fonts.subtitle)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("\(viewModel.averageDistance) m")
                                            .font(Constants.Fonts.largeTitle)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Distance Range")
                                            .font(Constants.Fonts.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(viewModel.distanceRange)
                                            .font(Constants.Fonts.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(Constants.Spacing.l)
                                .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                .cornerRadius(Constants.CornerRadius.radius)
                            }
                        }
                        .padding(Constants.Spacing.l)
                    }
                }
            }
            .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: Constants.Spacing.m) {
            Text(title)
                .font(Constants.Fonts.subtitle)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(value)
                .font(Constants.Fonts.largeTitle)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Constants.Spacing.l)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
        .cornerRadius(Constants.CornerRadius.radius)
    }
}

#Preview {
    StatsView()
}
