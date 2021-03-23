import Foundation

struct UserDefaultConfig {
    @UserDefault("user", defaultValue: [])
    static var user: [User]
}
