import Foundation
import UserNotifications
import Observation

@Observable
class NotificationManager {
    static let shared = NotificationManager()
    
    var isAuthorized = false
    
    private init() {
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            await MainActor.run {
                isAuthorized = granted
            }
            return granted
        } catch {
            print("Failed to request authorization: \(error)")
            return false
        }
    }
    
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Task { @MainActor in
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func scheduleRaceReminders(for races: [Race]) {
        guard isAuthorized else { return }
        
        cancelAllNotifications()
        
        let calendar = Calendar.current
        let upcomingRaces = races.filter { $0.isUpcoming }
        
        for race in upcomingRaces {
            guard let reminderDate = calendar.date(byAdding: .day, value: -1, to: race.date) else {
                continue
            }
            
            if reminderDate > Date() {
                let content = UNMutableNotificationContent()
                content.title = "Upcoming Race Tomorrow"
                content.body = "\(race.name) at \(race.racetrack)"
                content.sound = .default
                
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                
                let request = UNNotificationRequest(identifier: race.id.uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Failed to schedule notification: \(error)")
                    }
                }
            }
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
