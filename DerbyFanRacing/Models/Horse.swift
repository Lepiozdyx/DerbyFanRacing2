import Foundation
import Observation

enum HorseBreed: String, Codable, CaseIterable {
    case thoroughbred = "Thoroughbred"
    case arabian = "Arabian"
    case quarterHorse = "Quarter Horse"
    case standardbred = "Standardbred"
    case appaloosa = "Appaloosa"
    case paintHorse = "Paint Horse"
    case morgan = "Morgan"
    case tennesseeWalker = "Tennessee Walker"
}

enum CoatColor: String, Codable, CaseIterable {
    case bay = "Bay"
    case black = "Black"
    case chestnut = "Chestnut"
    case gray = "Gray"
    case brown = "Brown"
    case palomino = "Palomino"
    case white = "White"
    case roan = "Roan"
    case dun = "Dun"
    case buckskin = "Buckskin"
    case darkBay = "Dark Bay"
}

@Observable
class Horse: Identifiable, Codable {
    let id: UUID
    var name: String
    var breed: HorseBreed
    var age: Int
    var coatColor: CoatColor
    var breeder: String
    var notes: String
    var photoData: Data?
    
    init(id: UUID = UUID(), name: String, breed: HorseBreed, age: Int, coatColor: CoatColor, breeder: String = "", notes: String = "", photoData: Data? = nil) {
        self.id = id
        self.name = name
        self.breed = breed
        self.age = age
        self.coatColor = coatColor
        self.breeder = breeder
        self.notes = notes
        self.photoData = photoData
    }
    
    enum CodingKeys: CodingKey {
        case id, name, breed, age, coatColor, breeder, notes, photoData
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        breed = try container.decode(HorseBreed.self, forKey: .breed)
        age = try container.decode(Int.self, forKey: .age)
        coatColor = try container.decode(CoatColor.self, forKey: .coatColor)
        breeder = try container.decode(String.self, forKey: .breeder)
        notes = try container.decode(String.self, forKey: .notes)
        photoData = try container.decodeIfPresent(Data.self, forKey: .photoData)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(breed, forKey: .breed)
        try container.encode(age, forKey: .age)
        try container.encode(coatColor, forKey: .coatColor)
        try container.encode(breeder, forKey: .breeder)
        try container.encode(notes, forKey: .notes)
        try container.encodeIfPresent(photoData, forKey: .photoData)
    }
    
    var initial: String {
        String(name.prefix(1)).uppercased()
    }
}
