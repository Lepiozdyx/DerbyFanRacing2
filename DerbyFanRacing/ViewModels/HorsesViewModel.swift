import Foundation
import Observation

@Observable
class HorsesViewModel {
    let storageManager = StorageManager.shared
    var searchText = ""
    
    var horses: [Horse] {
        let allHorses = storageManager.horses.sorted { $0.name < $1.name }
        
        guard !searchText.isEmpty else { return allHorses }
        
        return allHorses.filter { horse in
            horse.name.localizedCaseInsensitiveContains(searchText) ||
            horse.breed.rawValue.localizedCaseInsensitiveContains(searchText) ||
            horse.coatColor.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func addHorse(_ horse: Horse) {
        storageManager.addHorse(horse)
    }
    
    func updateHorse(_ horse: Horse) {
        storageManager.updateHorse(horse)
    }
    
    func deleteHorse(_ horse: Horse) {
        storageManager.deleteHorse(horse)
    }
    
    func getRacesForHorse(_ horse: Horse) -> [Race] {
        storageManager.getRacesForHorse(horse)
    }
}
