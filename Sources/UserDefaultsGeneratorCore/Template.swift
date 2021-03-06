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
            public enum UDG{{ groupuedConfiguration.aliasName }}Key: String {
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
            // MARK: - UserDefaults {{ gc.aliasName }} Extension
            extension UserDefaults {
            \(tab)public func {{ gc.getterMethodName }}(forKey key: UDG{{ gc.aliasName }}Key) -> {{ gc.typeName }}{% if gc.isOptionalType %}?{% endif %} {
            \(tab)\(tab)return {{ gc.getterMethodName }}(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: {{ gc.typeName }}{% if gc.isOptionalType %}?{% endif %}, forKey key: UDG{{ gc.aliasName }}Key) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            {% endfor %}
            """
        }
    }
}
