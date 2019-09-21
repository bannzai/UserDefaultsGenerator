import Foundation

public enum UDGAnyKey: String {
	case ABC
	case DEF
}
public enum UDGArrayKey: String {
	case XYZ
}
public enum UDGBoolKey: String {
	case UserSelectedDarkMode = "DarkMode"
}
public enum UDGIntKey: String {
	case numberOfIndent
}
public enum UDGStringArrayKey: String {
	case StringArray
}


// MARK: - UserDefaults Any Extension
extension UserDefaults {
	public func object(forKey key: UDGAnyKey) -> Any? {
		return object(forKey: key.rawValue)
	}
	public func set(_ value: Any?, forKey key: UDGAnyKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
// MARK: - UserDefaults Array Extension
extension UserDefaults {
	public func array(forKey key: UDGArrayKey) -> [Any]? {
		return array(forKey: key.rawValue)
	}
	public func set(_ value: [Any]?, forKey key: UDGArrayKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
// MARK: - UserDefaults Bool Extension
extension UserDefaults {
	public func bool(forKey key: UDGBoolKey) -> Bool {
		return bool(forKey: key.rawValue)
	}
	public func set(_ value: Bool, forKey key: UDGBoolKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
// MARK: - UserDefaults Int Extension
extension UserDefaults {
	public func integer(forKey key: UDGIntKey) -> Int {
		return integer(forKey: key.rawValue)
	}
	public func set(_ value: Int, forKey key: UDGIntKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
// MARK: - UserDefaults StringArray Extension
extension UserDefaults {
	public func stringArray(forKey key: UDGStringArrayKey) -> [String]? {
		return stringArray(forKey: key.rawValue)
	}
	public func set(_ value: [String]?, forKey key: UDGStringArrayKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
