//
//  KeyChainManager.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 29/7/23.
//

import Foundation
import KeychainSwift

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()
    
    private let userTokenKey = "token"
    
    func saveUserToken(_ token: String) {
        keychain.set(token, forKey: userTokenKey)
    }
    
    func getUserToken() -> String? {
        return keychain.get(userTokenKey)
    }
    
    func deleteUserToken() {
        keychain.delete(userTokenKey)
    }
}
