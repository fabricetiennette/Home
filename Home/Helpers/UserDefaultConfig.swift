import Foundation

struct UserDefaultConfig {
    @UserDefault("user", defaultValue: [])
    static var user: [User]

    @UserDefault("device", defaultValue: [])
    static var device: [Device]
}
