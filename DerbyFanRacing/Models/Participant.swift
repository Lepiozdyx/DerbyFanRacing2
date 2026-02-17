import Foundation

struct Participant: Identifiable, Codable {
    let id: UUID
    let horseId: UUID
    var observationNotes: String
    
    init(id: UUID = UUID(), horseId: UUID, observationNotes: String = "") {
        self.id = id
        self.horseId = horseId
        self.observationNotes = observationNotes
    }
}
