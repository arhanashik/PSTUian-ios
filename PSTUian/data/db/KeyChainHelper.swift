//
//  KeyChainHelper.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

final class KeychainHelper {
    
    static let standard = KeychainHelper()
    private init() {}
    
    // This function inserts the provided data using KeyChain.
    // If the key alreay exists while inserting(error code -25299), it will update the data
    func save(_ data: Data, service: String, account: String) -> Bool {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        var status: OSStatus
        status = SecItemAdd(query, nil)
        if status == errSecSuccess {
            // Data inserted successfully
            return true
        }
        
        // If Item already exist, try to update it.
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            // Update existing item
            status = SecItemUpdate(query, attributesToUpdate)
            if status == errSecSuccess {
                // Data updated successfully
                return true
            }
        }
        
        // Print out the error
        print("Error: \(status)")
        
        // Failed to save data
        return false
    }
    
    // Read the data from KeyChain
    // Return nil if not found
    func read(service: String, account: String) -> Data? {
        // Create query
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        // Copy data from keychain
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        // Parse data and return
        return (result as? Data)
    }
    
    // Delete data from KeyChain
    func delete(service: String, account: String) -> Bool {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        // Delete item from keychain
        let status = SecItemDelete(query)
        if status == errSecSuccess {
            // Data deleted successfully
            return true
        }
        // Failed to delete
        print("Error: \(status)")
        return false
    }
    
    // This function inserts the provided generic data using KeyChain.
    // If the key alreay exists while inserting(error code -25299), it will update the data
    func save<T>(_ item: T, service: String, account: String)  -> Bool where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            return save(data, service: service, account: account)
        } catch {
            // Encoding failed
            print("Fail to encode item for keychain: \(error)")
            return false
        }
    }
    
    // Read generic data from KeyChain
    // Return nil if not found
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            print("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
