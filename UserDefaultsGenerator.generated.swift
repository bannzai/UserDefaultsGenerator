public enum UDGBoolKey: String {
case UserSelectedDarkMode = "DarkMode"
}
public enum UDGIntKey: String {
case numberOfIndent
}
extension UserDefaults {
    public func Bool(forKey key: UDGBoolKey) -> Bool {
        return bool(forKey: key.rawValue)
    }
    public func set(_ value: Bool, forKey key: UDGBoolKey) {
        set(value, forKey: key.rawValue)
        synchronize()
    }
}
extension UserDefaults {
    public func Int(forKey key: UDGIntKey) -> Int {
        return integer(forKey: key.rawValue)
    }
    public func set(_ value: Int, forKey key: UDGIntKey) {
        set(value, forKey: key.rawValue)
        synchronize()
    }
}