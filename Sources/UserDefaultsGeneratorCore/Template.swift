//
//  Template.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/21.
//

import Foundation

enum TemplateType {
    case `enum`
    case `extension`
    
    var template: String {
        switch self {
        case .enum:
            return """
            {% for groupedConfiguration in groupedConfigurations where not groupedConfigurations.count == 0 %}
            public enum UDG{{ groupedConfiguration.type.rawValue }}Key: String {
            {% for configuration in groupedConfiguration.configuration where not groupedConfiguration.configuration.count == 0 %}
            \(tab)case {% if not configuration.name == "" %}{{ configuration.key }} {% else %} {{ configuration.key }} = "{{ configuration.name }}" {% endif %}
            {% endfor %}
            }
            {% endfor %}
            """
        case .extension:
            return """
            {% for groupedConfiguration in groupedConfigurations where not groupedConfigurations.count == 0 %}
            {% set type groupedConfigurations.type %}
            extension UserDefaults {
            \(tab)public func {{ type.getterName }}(forKey key: UDG{{ type.rawValue }}Key) -> {{ type.rawValue }} {
            \(tab)\(tab)return {{ type.getterMethodName }}(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: {{ type.rawValue }}, forKey key: UDG{{ type.rawValue }}Key) -> {{ type.rawValue }} {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            {% endfor %}
            """
        }
    }
}
