//
//  Date+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extension to Date.
public extension Date {
    
    // MARK: - Public -
    // MARK: Properties
    
    // Month (1..12) using current calendar.
    public var month: Int {
        
        return self.get(.month)
    }
    
    /// Year using current calendar.
    public var year: Int {
        
        return self.get(.year)
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private var currentCalendar: Calendar {
        
        return Calendar.current
    }
    
    // MARK: Methods
    
    private func get(_ component: Calendar.Component) -> Int {
        
        return self.currentCalendar.component(component, from: self)
    }
}
