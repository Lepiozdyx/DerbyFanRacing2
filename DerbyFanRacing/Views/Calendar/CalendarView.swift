import SwiftUI

struct CalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = CalendarViewModel()
    
    private let calendar = Calendar.current
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private var daysInMonth: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: viewModel.currentMonth) else {
            return []
        }
        
        let monthStart = monthInterval.start
        let monthEnd = monthInterval.end
        
        guard let firstWeekday = calendar.dateComponents([.weekday], from: monthStart).weekday else {
            return []
        }
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        
        var currentDate = monthStart
        while currentDate < monthEnd {
            days.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }
        
        return days
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.xs) {
                LogoHeader()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                        Text("Race Calendar")
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.primary)
                        
                        Text("View scheduled and past races by date")
                            .font(Constants.Fonts.subtitle)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.Spacing.l)
                    .padding(.top, Constants.Spacing.xl)
                    
                    if viewModel.races.isEmpty {
                        EmptyStateView(
                            icon: Constants.Icons.calendar,
                            title: "No races scheduled",
                            subtitle: "Add races to see them on the calendar"
                        )
                        .padding(.top, Constants.Spacing.xxl)
                    } else {
                        VStack(spacing: Constants.Spacing.l) {
                            HStack {
                                Button(action: { viewModel.previousMonth() }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18))
                                        .foregroundStyle(.primary)
                                        .frame(width: 44, height: 44)
                                }
                                
                                Spacer()
                                
                                Text(monthFormatter.string(from: viewModel.currentMonth))
                                    .font(Constants.Fonts.title)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Button(action: { viewModel.nextMonth() }) {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 18))
                                        .foregroundStyle(.primary)
                                        .frame(width: 44, height: 44)
                                }
                            }
                            .padding(.horizontal, Constants.Spacing.l)
                            
                            VStack(spacing: Constants.Spacing.m) {
                                HStack(spacing: 0) {
                                    ForEach(weekDays, id: \.self) { day in
                                        Text(day)
                                            .font(Constants.Fonts.caption)
                                            .foregroundStyle(.secondary)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                
                                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                                let days = daysInMonth
                                LazyVGrid(columns: columns, spacing: Constants.Spacing.m) {
                                    ForEach(Array(days.enumerated()), id: \.offset) { _, date in
                                        if let date {
                                            CalendarDayCell(
                                                date: date,
                                                isSelected: calendar.isDate(date, inSameDayAs: viewModel.selectedDate ?? Date.distantPast),
                                                hasRaces: viewModel.hasRacesOnDate(date),
                                                isPast: date < Date()
                                            )
                                            .onTapGesture {
                                                if viewModel.hasRacesOnDate(date) {
                                                    viewModel.selectedDate = date
                                                }
                                            }
                                        } else {
                                            Color.clear
                                                .frame(height: 44)
                                        }
                                    }
                                }
                            }
                            .padding(Constants.Spacing.l)
                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                            .cornerRadius(Constants.CornerRadius.radius)
                            .padding(.horizontal, Constants.Spacing.l)
                            
                            HStack(spacing: Constants.Spacing.l) {
                                HStack(spacing: Constants.Spacing.s) {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 8, height: 8)
                                    
                                    Text("Past race")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                HStack(spacing: Constants.Spacing.s) {
                                    Circle()
                                        .fill(Color("derbyBage"))
                                        .frame(width: 8, height: 8)
                                    
                                    Text("Upcoming race")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.horizontal, Constants.Spacing.l)
                            
                            if let selectedDate = viewModel.selectedDate {
                                let racesForDay = viewModel.racesForDate(selectedDate)
                                if !racesForDay.isEmpty {
                                    VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                                        Text(dateFormatter.string(from: selectedDate))
                                            .font(Constants.Fonts.subtitle)
                                            .foregroundStyle(.secondary)
                                        
                                        ForEach(racesForDay) { race in
                                            VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                                                Text(race.name)
                                                    .font(Constants.Fonts.text)
                                                    .foregroundStyle(.primary)
                                                
                                                HStack(spacing: Constants.Spacing.s) {
                                                    Text(race.racetrack)
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.secondary)
                                                    
                                                    Text("•")
                                                        .foregroundStyle(.secondary)
                                                    
                                                    Text("\(race.distance)m")
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.secondary)
                                                    
                                                    Text("•")
                                                        .foregroundStyle(.secondary)
                                                    
                                                    Text(race.surface.rawValue)
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                            .padding(Constants.Spacing.l)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(colorScheme == .dark ? Color("cardColorDark") : Color("cardColor"))
                                            .cornerRadius(Constants.CornerRadius.radius)
                                        }
                                    }
                                    .padding(.horizontal, Constants.Spacing.l)
                                }
                            }
                        }
                        .padding(.top, Constants.Spacing.l)
                    }
                }
            }
            .background(colorScheme == .dark ? Color("backgroundDark") : Color("background"))
        }
    }
}

struct CalendarDayCell: View {
    let date: Date
    let isSelected: Bool
    let hasRaces: Bool
    let isPast: Bool
    
    private var dayNumber: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        VStack(spacing: Constants.Spacing.xs) {
            Text(dayNumber)
                .font(Constants.Fonts.subtitle)
                .foregroundStyle(isToday ? Color.accentColor : .primary)
            
            if hasRaces {
                Circle()
                    .fill(isPast ? Color.gray : Color("derbyBage"))
                    .frame(width: 6, height: 6)
            } else {
                Color.clear
                    .frame(width: 6, height: 6)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
        .cornerRadius(Constants.CornerRadius.radius / 2)
    }
}

#Preview {
    CalendarView()
}
