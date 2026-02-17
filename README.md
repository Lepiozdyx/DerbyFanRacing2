# Derby Fan Racing City

A professional horse racing observation journal designed for tracking races, recording performance data, and maintaining a personal catalog of horses.

## Features

### 🏁 Races
- Create and manage race entries with detailed information
- Track racetrack, date, distance, surface type, and weather conditions
- Add multiple horse participants to each race
- Record observation notes for each participant
- Edit and delete races
- View comprehensive race details

### 🐴 Horses
- Maintain a personal catalog of racing horses
- Add horse photos from your photo library
- Track breed, age, coat color, and breeder information
- Search horses by name, breed, or color
- View complete race history for each horse
- Edit and delete horse entries

### 📅 Calendar
- Custom calendar view showing all scheduled races
- Visual indicators for past (gray) and upcoming (beige) races
- Tap dates to view race details
- Navigate between months
- Empty state when no races are scheduled

### 📊 Statistics
- Total races and horses tracked
- Past and upcoming race counts
- Race activity over time (bar chart)
- Racetrack activity breakdown
- Track surface preferences (grass vs dirt)
- Average distance and distance range
- Empty state when no data is available

### ⚙️ Settings
- Dark mode toggle with automatic theme switching
- Race reminder notifications (24 hours before race)
- App information and version
- Disclaimer about app purpose

## Technical Details

### Architecture
- **Pattern**: MVVM (Model-View-ViewModel)
- **UI Framework**: SwiftUI
- **State Management**: iOS 17+ @Observable macro
- **Navigation**: NavigationStack
- **Data Persistence**: UserDefaults with Codable
- **Charts**: iOS 17+ Charts framework
- **Notifications**: UserNotifications framework
- **Photo Picker**: PhotosUI framework

### Project Structure
```
DerbyFanRacing/
├── Models/
│   ├── Race.swift
│   ├── Horse.swift
│   ├── Participant.swift
│   └── WeatherCondition.swift
├── Managers/
│   ├── StorageManager.swift
│   └── NotificationManager.swift
├── ViewModels/
│   ├── RacesViewModel.swift
│   ├── HorsesViewModel.swift
│   ├── CalendarViewModel.swift
│   ├── StatsViewModel.swift
│   └── SettingsViewModel.swift
├── Views/
│   ├── MainTabView.swift
│   ├── Components/
│   │   ├── LogoHeader.swift
│   │   ├── RaceCard.swift
│   │   ├── HorseCard.swift
│   │   └── EmptyStateView.swift
│   ├── Races/
│   │   ├── RacesView.swift
│   │   ├── RaceDetailView.swift
│   │   └── RaceFormView.swift
│   ├── Horses/
│   │   ├── HorsesView.swift
│   │   ├── HorseDetailView.swift
│   │   └── HorseFormView.swift
│   ├── Calendar/
│   │   └── CalendarView.swift
│   ├── Stats/
│   │   └── StatsView.swift
│   └── Settings/
│       └── SettingsView.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Constants.swift
├── DerbyFanRacingApp.swift
└── Info.plist
```

### Design System

#### Colors
- **Backgrounds**: `.background` (light) / `.backgroundDark` (dark)
- **Cards**: `.cardColor` / `.cardColorDark`
- **Accent**: `.accent` (burgundy #8B1538)
- **Auxiliary**: `.derbyBage`, `.derbyGray`
- **Text**: `.primary`, `.secondary`

#### Typography
- **Large Title**: 24pt, semibold
- **Title**: 18pt, semibold
- **Text**: 16pt, medium
- **Subtitle**: 14pt, regular
- **Caption**: 12pt, regular

#### Spacing
- **XS**: 2pt
- **S**: 4pt
- **M**: 8pt
- **L**: 16pt
- **XL**: 24pt
- **XXL**: 32pt

#### Component Sizes
- **Photo Frame**: 126pt
- **Circle Frame**: 64pt (for horse initials)
- **Button Height**: 36pt
- **Text Field**: 36pt
- **Text Editor**: 65pt
- **Corner Radius**: 12pt

### Data Models

#### Race
- ID (UUID)
- Name
- Racetrack
- Date
- Distance (meters)
- Surface (Grass/Dirt)
- Weather condition
- Temperature
- Participants

#### Horse
- ID (UUID)
- Name
- Breed (8 types)
- Age
- Coat Color (11 types)
- Breeder
- Notes
- Photo (optional)

#### Participant
- ID (UUID)
- Horse ID (reference)
- Observation notes

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Privacy Permissions

The app requests the following permissions:
- **Photo Library**: To add horse photos
- **Notifications**: To send race reminders

## Installation

1. Open `DerbyFanRacing.xcodeproj` in Xcode
2. Select your development team
3. Build and run on simulator or device

## Usage

### Adding a Race
1. Tap the "Races" tab
2. Tap "+ New Race" button
3. Fill in race information (name, racetrack, date, distance, surface, weather, temperature)
4. Optionally add participants by tapping "+ Add Horse"
5. Tap "Create Race"

### Adding a Horse
1. Tap the "Horses" tab
2. Tap "+ Add Horse" button
3. Optionally add a photo from your library
4. Fill in horse details (name, breed, age, coat color, breeder, notes)
5. Tap "Add Horse"

### Viewing Statistics
1. Tap the "Stats" tab
2. View metrics, charts, and insights based on your race data

### Enabling Notifications
1. Tap the "Settings" tab
2. Toggle "Race Reminders" on
3. Grant notification permission when prompted
4. You'll receive reminders 24 hours before each upcoming race

## Notes

- This app is an analysis and tracking tool only
- It is not related to betting or gambling
- All data is stored locally on your device
- Deleting a horse will remove it from all associated races
- Dark mode can be controlled independently from system settings

## Version

1.0.0

## License

All rights reserved.
