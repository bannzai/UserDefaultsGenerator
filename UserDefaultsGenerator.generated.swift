import Foundation

public enum UDGBoolKey: String {
	case UserSelectedDarkMode = "DarkMode"
}
public enum UDGIntKey: String {
	case numberOfIndent
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
