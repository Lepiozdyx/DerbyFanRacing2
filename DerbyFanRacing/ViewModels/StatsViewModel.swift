import Foundation
import Observation

struct RaceActivityData: Identifiable {
    let id = UUID()
    let month: String
    let count: Int
}

struct RacetrackActivityData: Identifiable {
    let id = UUID()
    let racetrack: String
    let count: Int
}

@Observable
class StatsViewModel {
    let storageManager = StorageManager.shared
    
    var totalRaces: Int {
        storageManager.races.count
    }
    
    var horsesTracked: Int {
        storageManager.horses.count
    }
    
    var pastRaces: Int {
        storageManager.races.filter { $0.isPast }.count
    }
    
    var upcomingRaces: Int {
        storageManager.races.filter { $0.isUpcoming }.count
    }
    
    var raceActivityOverTime: [RaceActivityData] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        let grouped = Dictionary(grouping: storageManager.races) { race in
            dateFormatter.string(from: race.date)
        }

        guard !grouped.isEmpty else { return [] }

        let allDates = storageManager.races.map { $0.date }
        let earliestMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: allDates.min()!))!
        let latestMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: allDates.max()!))!

        let monthSpan = (calendar.dateComponents([.month], from: earliestMonthStart, to: latestMonthStart).month ?? 0) + 1
        let displayMonths = max(4, min(6, monthSpan))

        let startDate: Date
        if monthSpan > 6 {
            startDate = calendar.date(byAdding: .month, value: -5, to: latestMonthStart)!
        } else if monthSpan < 4 {
            startDate = calendar.date(byAdding: .month, value: -(4 - monthSpan), to: earliestMonthStart)!
        } else {
            startDate = earliestMonthStart
        }

        return (0..<displayMonths).map { i in
            let date = calendar.date(byAdding: .month, value: i, to: startDate)!
            let key = dateFormatter.string(from: date)
            return RaceActivityData(month: key, count: grouped[key]?.count ?? 0)
        }
    }
    
    var racetrackActivity: [RacetrackActivityData] {
        let grouped = Dictionary(grouping: storageManager.races) { $0.racetrack }
        
        return grouped.map { racetrack, races in
            RacetrackActivityData(racetrack: racetrack, count: races.count)
        }.sorted { $0.count > $1.count }
    }
    
    var mostActiveRacetrack: String {
        racetrackActivity.first?.racetrack ?? "—"
    }
    
    var mostActiveRacetrackCount: Int {
        racetrackActivity.first?.count ?? 0
    }
    
    var grassRacesCount: Int {
        storageManager.races.filter { $0.surface == .grass }.count
    }
    
    var dirtRacesCount: Int {
        storageManager.races.filter { $0.surface == .dirt }.count
    }
    
    var averageDistance: Int {
        guard !storageManager.races.isEmpty else { return 0 }
        let total = storageManager.races.reduce(0) { $0 + $1.distance }
        return total / storageManager.races.count
    }
    
    var distanceRange: String {
        guard !storageManager.races.isEmpty else { return "—" }
        let distances = storageManager.races.map { $0.distance }
        let min = distances.min() ?? 0
        let max = distances.max() ?? 0
        return "\(min)m - \(max)m"
    }
}
