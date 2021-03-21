import Foundation

    // MARK: - Response

struct Response: Decodable {
    let devices: [Device]?
    let user: User?
}

    // MARK: - Device

struct Device: Decodable {
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
}

    // MARK: - User

struct User: Decodable {
    let firstName: String?
    let lastName: String?
    let address: Address?
    let birthDate: Int?
}

    // MARK: - Address

struct Address: Decodable {
    let city: String?
    let postalCode: Int?
    let street: String?
    let streetCode: String?
    let country: String?
}
