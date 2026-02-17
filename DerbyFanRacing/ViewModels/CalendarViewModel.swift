import Foundation
import Observation

@Observable
class CalendarViewModel {
    let storageManager = StorageManager.shared
    var currentMonth = Date()
    var selectedDate: Date?
    
    var races: [Race] {
        storageManager.races
    }
    
    func racesForDate(_ date: Date) -> [Race] {
        let calendar = Calendar.current
        return races.filter { race in
            calendar.isDate(race.date, inSameDayAs: date)
        }
    }
    
    func hasRacesOnDate(_ date: Date) -> Bool {
        !racesForDate(date).isEmpty
    }
    
    func previousMonth() {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func nextMonth() {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}
