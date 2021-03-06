//
//  SwiftType.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/20.
//

import Foundation

public enum SwiftType: String, Decodable {
    case any = "Any"
    case url = "URL"
    case array = "Array"
    case dictionary = "Dictionary"
    case string = "String"
    case stringArray = "StringArray"
    case data = "Data"
    case bool = "Bool"
    case int = "Int"
    case float = "Float"
    case double = "Double"
    
    var typeName: String {
        switch self {
        case .array:
            return "[Any]"
        case .dictionary:
            return "[String: Any]"
        case .stringArray:
            return "[String]"
        case .any, .url, .string, .data, .bool, .int, .float, .double:
            return aliasName
        }
    }
    
    var aliasName: String {
        return rawValue
    }
    
    var isOptional: Bool {
        switch self {
        case .any, .url, .array, .dictionary, .string, .stringArray, .data:
            return true
        case .bool, .int, .float, .double:
            return false
        }
    }

    var getterMethodName: String {
        switch self {
        case .int:
            return "integer"
        case .any:
            return "object"
        case _:
            return "\(self)"
        }
    }
}


extension SwiftType: Comparable {
    public static func < (lhs: SwiftType, rhs: SwiftType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
