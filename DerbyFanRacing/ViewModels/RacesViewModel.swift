import Foundation
import Observation

@Observable
class RacesViewModel {
    let storageManager = StorageManager.shared
    
    var races: [Race] {
        storageManager.races.sorted { $0.date > $1.date }
    }
    
    func addRace(_ race: Race) {
        storageManager.addRace(race)
    }
    
    func updateRace(_ race: Race) {
        storageManager.updateRace(race)
    }
    
    func deleteRace(_ race: Race) {
        storageManager.deleteRace(race)
    }
}
