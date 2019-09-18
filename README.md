# ⚠️  This project Work In Progress ⚠️

## UserDefaultsGenerator
UserDefaultsGenerator generate swift code for easily management for (NS)UserDefaults key and value type.

## Usage
First, you should prepare `udg.yml` file of below structure.

```yml
- name: numberOfIndent
type: Int

- name: UserSelectedDarkMode
type: Bool
key: DarkMode
```

Next, and exec below command.
```
$ udg generate 
```


Last, you can confirm result of udg command about generated swift code for managiment UserDefaults.
```swift
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

// MARK: - Bool Extension
extension UserDefaults {
  public func bool(forKey key: UDGBoolKey) -> Bool {
    return bool(forKey: key.rawValue)
  }
  public func set(_ value: Bool, forKey key: UDGBoolKey) {
    set(value, forKey: key.rawValue)
    synchronize()
  }
}

```

## Yaml Configuration 
|  Key  |  Description  |  Required/Optional  |
| ---- | ---- | ---- |
|  name  |  Name of UserDefaults type key  |  Required  |
|  type  |  Type of UserDefaults stored value  |  Required  |
|  key  |  Custom key name if you want to use different name  |  Optional  |


### Supported Swift Type
- Bool
- Int

## LICENSE
UserDefaultsGenerator is available under the MIT license. See the LICENSE file for more info.

