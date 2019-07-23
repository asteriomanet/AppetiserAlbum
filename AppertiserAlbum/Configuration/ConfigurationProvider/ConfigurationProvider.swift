//
//  ConfigurationProvider.swift
//  AppertiserAlbum
//
//  Created by Ella on 23/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation

/// Read a value from the bundle options for a given key.
///
/// - parameter key: The option's key.
/// - returns: The value or `nil`.
private func bundleOption(_ key: String) -> Any? {
    return Bundle.main.object(forInfoDictionaryKey: key)
}

/// Read a string from the bundle options for a given key.
///
/// - parameter key: The option's key.
/// - returns: The value or `nil`.
private func stringBundleOption(key: ConfigKey) -> String? {
    return bundleOption(key.rawValue) as? String
}

class ConfigurationProvider {
    static let apiBaseUrl: String = {
        return stringBundleOption(key: .apiBaseUrl) ?? ""
    }()
}
