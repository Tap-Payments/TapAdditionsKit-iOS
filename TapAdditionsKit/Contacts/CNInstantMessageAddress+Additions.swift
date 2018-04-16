//
//  CNInstantMessageAddress+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Contacts.CNInstantMessageAddress

import var Contacts.CNInstantMessageAddress.CNInstantMessageAddressServiceKey
import var Contacts.CNInstantMessageAddress.CNInstantMessageAddressUsernameKey

/// Useful addition to CNInstantMessageAddress.
@available(iOS 9.0, *)
public extension CNInstantMessageAddress {

    // MARK: - Public -
    // MARK: Properties

    /// Returns JSON dictionary representation of the receiver.
    public var jsonDictionary: [String: String] {

        var result: [String: String] = [:]

        if !self.service.isEmpty {

            result[CNInstantMessageAddressServiceKey] = self.service
        }

        if !self.username.isEmpty {

            result[CNInstantMessageAddressUsernameKey] = self.username
        }

        return result
    }
}

/// Dummy struct to import Contacts/CNInstantMessageAddress module.
public struct CNInstantMessageAddressAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
