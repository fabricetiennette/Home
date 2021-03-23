import Foundation

protocol UpdateUserViewModelDelegate: AnyObject {
    func didTapOnSave()
}

class UpdateUserViewModel {

    weak var delegate: UpdateUserViewModelDelegate?

    var userHandler: (([String?]) -> Void)?

    func getUser() {
        guard let user = UserDefaultConfig.user.first else { return }
        let userData = getUserInfo(user: user)
        userHandler?(userData)
    }

    func getUserInfo(user: User) -> [String?] {
        var info: [String?] = []
        info.append(user.firstName)
        info.append(user.lastName)
        info.append(user.address?.streetCode)
        info.append(user.address?.street)
        info.append(String(user.address?.postalCode ?? 0))
        info.append(user.address?.city)
        info.append(user.address?.country)
        return info
    }

    func saveUserInfo(info: [String]) {
        guard let user = UserDefaultConfig.user.first else { return }
        let address = Address(city: info[5], postalCode: Int(info[4]), street: info[3], streetCode: info[3], country: info[6])
        UserDefaultConfig.user = [User(firstName: info[0], lastName: info[1], address: address, birthDate: user.birthDate)]
        delegate?.didTapOnSave()
    }
}
