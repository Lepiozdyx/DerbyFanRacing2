import Foundation
import SwiftUI
import Observation

@Observable
class SettingsViewModel {
    private let darkModeKey = "darkModeEnabled"
    private let notificationsKey = "notificationsEnabled"
    
    let notificationManager = NotificationManager.shared
    let storageManager = StorageManager.shared
    
    var isDarkModeEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isDarkModeEnabled, forKey: darkModeKey)
        }
    }
    
    var areNotificationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(areNotificationsEnabled, forKey: notificationsKey)
            if areNotificationsEnabled {
                Task {
                    let granted = await notificationManager.requestAuthorization()
                    if granted {
                        await MainActor.run {
                            scheduleNotifications()
                        }
                    } else {
                        await MainActor.run {
                            areNotificationsEnabled = false
                        }
                    }
                }
            } else {
                notificationManager.cancelAllNotifications()
            }
        }
    }
    
    var colorScheme: ColorScheme? {
        isDarkModeEnabled ? .dark : .light
    }
    
    init() {
        isDarkModeEnabled = UserDefaults.standard.bool(forKey: darkModeKey)
        areNotificationsEnabled = UserDefaults.standard.bool(forKey: notificationsKey)
    }
    
    func scheduleNotifications() {
        if areNotificationsEnabled {
            notificationManager.scheduleRaceReminders(for: storageManager.races)
        }
    }
}
