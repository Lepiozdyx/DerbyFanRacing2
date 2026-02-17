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
        _ = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        let grouped = Dictionary(grouping: storageManager.races) { race in
            dateFormatter.string(from: race.date)
        }
        
        return grouped.map { month, races in
            RaceActivityData(month: month, count: races.count)
        }.sorted { month1, month2 in
            let date1 = dateFormatter.date(from: month1.month) ?? Date()
            let date2 = dateFormatter.date(from: month2.month) ?? Date()
            return date1 < date2
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
