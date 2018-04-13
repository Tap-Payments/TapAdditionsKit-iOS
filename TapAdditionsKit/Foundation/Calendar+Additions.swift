//
//  Calendar+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful addition to calendar.
public extension Calendar {
    
    // MARK: - Public -
    public struct CalendarConstants {
        
        public static let wellKnownLeapYear = 2000
    }
    
    // MARK: Methods
    
    /// Returns maximal number of days in a specific month.
    ///
    /// - Parameter month: Month ( 1..12 )
    /// - Returns: Maximal number of days.
    public func maximalNumberOfDays(in month: Int) -> Int {
        
        return self.numberOfDays(in: month, in: CalendarConstants.wellKnownLeapYear)
    }
    
    /// Returns number of days for a specific month of a specific year.
    ///
    /// - Parameters:
    ///   - month: Month ( 1..12 )
    ///   - year: Year
    /// - Returns: Number of days.
    public func numberOfDays(in month: Int, in year: Int) -> Int {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        
        guard let date = self.date(from: components) else {
            
            return 0
        }
        
        guard let range = self.range(of: .day, in: .month, for: date) else {
            
            return 0
        }
        
        return range.count
    }
}
