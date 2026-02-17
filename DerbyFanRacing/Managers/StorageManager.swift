import Foundation

@Observable
class StorageManager {
    static let shared = StorageManager()
    
    private let racesKey = "races"
    private let horsesKey = "horses"
    
    var races: [Race] = [] {
        didSet {
            saveRaces()
        }
    }
    
    var horses: [Horse] = [] {
        didSet {
            saveHorses()
        }
    }
    
    private init() {
        loadRaces()
        loadHorses()
    }
    
    private func saveRaces() {
        do {
            let data = try JSONEncoder().encode(races)
            UserDefaults.standard.set(data, forKey: racesKey)
        } catch {
            print("Failed to save races: \(error)")
        }
    }
    
    private func loadRaces() {
        guard let data = UserDefaults.standard.data(forKey: racesKey) else { return }
        do {
            races = try JSONDecoder().decode([Race].self, from: data)
        } catch {
            print("Failed to load races: \(error)")
        }
    }
    
    private func saveHorses() {
        do {
            let data = try JSONEncoder().encode(horses)
            UserDefaults.standard.set(data, forKey: horsesKey)
        } catch {
            print("Failed to save horses: \(error)")
        }
    }
    
    private func loadHorses() {
        guard let data = UserDefaults.standard.data(forKey: horsesKey) else { return }
        do {
            horses = try JSONDecoder().decode([Horse].self, from: data)
        } catch {
            print("Failed to load horses: \(error)")
        }
    }
    
    func addRace(_ race: Race) {
        races.append(race)
    }
    
    func updateRace(_ race: Race) {
        if let index = races.firstIndex(where: { $0.id == race.id }) {
            races[index] = race
        }
    }
    
    func deleteRace(_ race: Race) {
        races.removeAll { $0.id == race.id }
    }
    
    func addHorse(_ horse: Horse) {
        horses.append(horse)
    }
    
    func updateHorse(_ horse: Horse) {
        if let index = horses.firstIndex(where: { $0.id == horse.id }) {
            horses[index] = horse
        }
    }
    
    func deleteHorse(_ horse: Horse) {
        horses.removeAll { $0.id == horse.id }
        races.forEach { race in
            race.participants.removeAll { $0.horseId == horse.id }
        }
        saveRaces()
    }
    
    func getHorse(byId id: UUID) -> Horse? {
        horses.first { $0.id == id }
    }
    
    func getRacesForHorse(_ horse: Horse) -> [Race] {
        races.filter { race in
            race.participants.contains { $0.horseId == horse.id }
        }.sorted { $0.date > $1.date }
    }
}
