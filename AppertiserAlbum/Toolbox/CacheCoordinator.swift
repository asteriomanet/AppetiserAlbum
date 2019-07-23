//
//  CacheCoordinator.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation
import KeychainAccess

enum CacheKey: String {
    case albumList
    case currentDate
}

/* Persistence requirement
 - This is just one of approch to persist data
 - Can be improved using Realm
 */

class CacheCoordinator {
    
    fileprivate static let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "crishea.AppertiserAlbum")

    static func persist(data: Data, for urlKey: String?) {
        guard let key = urlKey else { return }
        do { try keychain.set(data, key: key) }
        catch {}
    }

    static func retrieveData(for key: String?) -> Data? {
        guard let key = key else { return nil }
        do { return try keychain.getData(key) }
        catch { return nil }
    }

    static func clearCache() {
        do { try keychain.removeAll() }
        catch {}
    }
}
