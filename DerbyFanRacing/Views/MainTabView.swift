import SwiftUI

struct MainTabView: View {
    @State private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView {
            RacesView()
                .tabItem {
                    Label("Races", systemImage: Constants.Icons.races)
                }
            
            HorsesView()
                .tabItem {
                    Label("Horses", systemImage: Constants.Icons.horses)
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: Constants.Icons.calendar)
                }
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: Constants.Icons.stats)
                }
            
            SettingsView(viewModel: settingsViewModel)
                .tabItem {
                    Label("Settings", systemImage: Constants.Icons.settings)
                }
        }
        .preferredColorScheme(settingsViewModel.colorScheme)
        .onAppear {
            settingsViewModel.scheduleNotifications()
        }
    }
}

#Preview {
    MainTabView()
}
