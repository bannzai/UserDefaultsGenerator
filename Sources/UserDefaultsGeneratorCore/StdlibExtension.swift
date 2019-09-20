//
//  StdlibExtension.swift
//  UserDefaultsGeneratorCore
//
//  Created by Yudai Hirose on 2019/09/21.
//

import Foundation

extension Collection {
    func grouped<T: Hashable>(_ closure: (Element) -> (T)) -> [T: [Element]] {
        return reduce(into: [T: [Element]]()){ result, element in
            let key = closure(element)
            switch result[key] {
            case nil:
                result[key] = [element]
            case let a?:
                result[key] = a + [element]
            }
        }
    }
}

extension Dictionary where Key: Comparable {
    func ordered() -> [(key: Key, value: Value)] {
        return map { $0 }.sorted { $0.key < $1.key }
    }
}
