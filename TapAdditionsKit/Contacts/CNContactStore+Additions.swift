//
//  CNContactStore+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Contacts.CNContact
import class Contacts.CNContactFetchRequest
import class Contacts.CNContactStore

/// Useful additions to CNContactStore.
@available(iOS 9.0, *)
public extension CNContactStore {
    
    // MARK: - Public -
    // MARK: Methods

    /// Fetches all contacts.
    ///
    /// - Returns: Fetched contacts.
    /// - Throws: Error if occured.
    public func fetchAllContacts() throws -> [CNContact] {
        
        do {

            var result: [CNContact] = []

            try self.enumerateContacts(with: .fetchingEverything) { (contact, _) in

                result += contact
            }

            return result
        }
        catch let error {

            throw error
        }
    }
    
    /// Fetches contact with the specific identifier.
    ///
    /// - Parameter identifier: Contact identifier.
    /// - Returns: Fetched contact or nil if there is no contact with the specified identifier.
    /// - Throws: Error if occured.
    public func fetchContact(with identifier: String) throws -> CNContact? {

        do {
            
            let contacts = try self.unifiedContacts(matching: CNContact.predicateForContacts(withIdentifiers: [identifier]), keysToFetch: CNContactFetchRequest.allFetchKeys)
            return contacts.first
        }
        catch let error {

            throw error
        }
    }
}
