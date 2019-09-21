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
            {% for groupuedConfiguration in groupedConfigurations where not groupedConfigurations.count == 0 %}
            public enum UDG{{ groupuedConfiguration.typeName }}Key: String {
            {% for configuration in groupuedConfiguration.configurations where not groupedConfiguration.configurations.count == 0 %}
            \(tab)case {% if configuration.key == "" %}{{ configuration.name }}{% else %}{{ configuration.name }} = "{{ configuration.key }}"{% endif %}
            {% endfor %}
            }
            {% endfor %}
            """
        case .extension:
            return """
            {% for groupedConfiguration in groupedConfigurations where not groupedConfigurations.count == 0 %}
            {% set gc groupedConfiguration %}
            extension UserDefaults {
            \(tab)public func {{ gc.getterMethodName }}(forKey key: UDG{{ gc.typeName }}Key) -> {{ gc.typeName }} {
            \(tab)\(tab)return {{ gc.getterMethodName }}(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: {{ gc.typeName }}, forKey key: UDG{{ gc.typeName }}Key) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            {% endfor %}
            """
        }
    }
}
