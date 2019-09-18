//
//  UserDefaults.generated.swift
//  UserDefaultsGeneratorDemo
//
//  Created by Yudai Hirose on 2019/09/18.
//  Copyright © 2019 Yudai Hirose. All rights reserved.
//

import Foundation

public enum UDGIntKey: String {
    case numberOfIndent
}

public enum UDGBoolKey: String {
    case UserSelectedDarkMode = "DarkMode"
}

// MARK: - Int Extension
extension UserDefaults {
    public func integer(forKey key: UDGIntKey) -> Int {
        return integer(forKey: key.rawValue)
    }
    public func set(_ value: Int, forKey key: UDGIntKey) {
        set(value, forKey: key.rawValue)
        synchronize()
    }
}

// MARK: Bool Extension
extension UserDefaults {
    public func bool(forKey key: UDGBoolKey) -> Bool {
        return bool(forKey: key.rawValue)
    }
    public func set(_ value: Bool, forKey key: UDGBoolKey) {
        set(value, forKey: key.rawValue)
        synchronize()
    }
}
