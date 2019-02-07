//
//  Bool+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

public extension Bool {
	
	// MARK: - Public -
	// MARK: Methods
	
	/// Switches the value of the receiver.
	public mutating func tap_switch() {
		
		self = !self
	}
}

// MARK: - ExpressibleByIntegerLiteral
extension Bool: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        
        self.init(value != 0)
    }
}
