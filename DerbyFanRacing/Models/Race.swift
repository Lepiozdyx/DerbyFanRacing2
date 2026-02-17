import Foundation
import Observation

@Observable
class Race: Identifiable, Codable {
    let id: UUID
    var name: String
    var racetrack: String
    var date: Date
    var distance: Int
    var surface: TrackSurface
    var weather: WeatherCondition
    var temperature: Int
    var participants: [Participant]
    
    init(id: UUID = UUID(), name: String, racetrack: String, date: Date = Date(), distance: Int, surface: TrackSurface = .grass, weather: WeatherCondition = .sunny, temperature: Int = 20, participants: [Participant] = []) {
        self.id = id
        self.name = name
        self.racetrack = racetrack
        self.date = date
        self.distance = distance
        self.surface = surface
        self.weather = weather
        self.temperature = temperature
        self.participants = participants
    }
    
    enum CodingKeys: CodingKey {
        case id, name, racetrack, date, distance, surface, weather, temperature, participants
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        racetrack = try container.decode(String.self, forKey: .racetrack)
        date = try container.decode(Date.self, forKey: .date)
        distance = try container.decode(Int.self, forKey: .distance)
        surface = try container.decode(TrackSurface.self, forKey: .surface)
        weather = try container.decode(WeatherCondition.self, forKey: .weather)
        temperature = try container.decode(Int.self, forKey: .temperature)
        participants = try container.decode([Participant].self, forKey: .participants)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(racetrack, forKey: .racetrack)
        try container.encode(date, forKey: .date)
        try container.encode(distance, forKey: .distance)
        try container.encode(surface, forKey: .surface)
        try container.encode(weather, forKey: .weather)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(participants, forKey: .participants)
    }
    
    var isPast: Bool {
        date < Date()
    }
    
    var isUpcoming: Bool {
        date >= Date()
    }
}
