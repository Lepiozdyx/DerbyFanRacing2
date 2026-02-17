import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    LogoHeader()
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                        Text("Settings")
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.primary)
                        
                        Text("Manage your app preferences")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.Spacing.l)
                    .padding(.top, Constants.Spacing.xl)
                    
                    VStack(spacing: Constants.Spacing.l) {
                        VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                            Text("Appearance")
                                .font(Constants.Fonts.title)
                                .foregroundStyle(.primary)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Dark Mode")
                                        .font(Constants.Fonts.text)
                                        .foregroundStyle(.primary)
                                    
                                    Text("Switch between light and dark theme")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $viewModel.isDarkModeEnabled)
                                    .labelsHidden()
                            }
                            .padding(Constants.Spacing.l)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                        }
                        
                        VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                            Text("Notifications")
                                .font(Constants.Fonts.title)
                                .foregroundStyle(.primary)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Race Reminders")
                                        .font(Constants.Fonts.text)
                                        .foregroundStyle(.primary)
                                    
                                    Text("Get notified about upcoming races")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $viewModel.areNotificationsEnabled)
                                    .labelsHidden()
                            }
                            .padding(Constants.Spacing.l)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                        }
                        
                        VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                            Text("About")
                                .font(Constants.Fonts.title)
                                .foregroundStyle(.primary)
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.l) {
                                VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                    Text("Derby Fan Racing City")
                                        .font(Constants.Fonts.text)
                                        .foregroundStyle(.primary)
                                    
                                    Text("Version 1.0.0")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Divider()
                                
                                Text("A professional horse racing observation journal designed for tracking races, recording performance data, and maintaining a personal catalog of horses.")
                                    .font(Constants.Fonts.subtitle)
                                    .foregroundStyle(.primary)
                                
                                Text("Important: This app is an analysis and tracking tool only. It is not related to betting or gambling.")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.top, Constants.Spacing.m)
                            }
                            .padding(Constants.Spacing.l)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                        }
                    }
                    .padding(Constants.Spacing.l)
                }
            }
            .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
        }
    }
}

#Preview {
    SettingsView()
}
