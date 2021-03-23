import Foundation

    // MARK: - Response

struct Response: Codable {
    
    let devices: [Device]
    let user: User?
}

    // MARK: - Device

struct Device: Codable, Hashable {
    let deviceId: Int?
    let deviceName: String?
    let intensity: Int?
    let mode: String?
    let productType: String?
    let position: Int?
    let temperature: Int?

    enum CodingKeys: String, CodingKey {
        case deviceId = "id"
        case deviceName
        case intensity
        case mode
        case productType
        case position
        case temperature
    }

    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.deviceId == rhs.deviceId && lhs.deviceName == rhs.deviceName && lhs.intensity == rhs.intensity && lhs.mode == rhs.mode && lhs.productType == rhs.productType && lhs.position == rhs.position && lhs.temperature == rhs.temperature
    }
}

    // MARK: - User

struct User: Codable, Equatable {
    
    let firstName: String?
    let lastName: String?
    let address: Address?
    let birthDate: Int?

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.address == rhs.address && lhs.birthDate == rhs.birthDate
    }
}

    // MARK: - Address

struct Address: Codable, Equatable {
    let city: String?
    let postalCode: Int?
    let street: String?
    let streetCode: String?
    let country: String?
}
