import Foundation

enum WeatherCondition: String, Codable, CaseIterable {
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case rainy = "Rainy"
    case windy = "Windy"
    case snowy = "Snowy"
    
    var icon: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .windy: return "wind"
        case .snowy: return "snowflake"
        }
    }
}

enum TrackSurface: String, Codable, CaseIterable {
    case grass = "Grass"
    case dirt = "Dirt"
}
