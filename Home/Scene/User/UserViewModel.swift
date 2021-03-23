import Foundation

protocol UserViewModelDelegate: AnyObject {
    func didTapOnUpdate()
}

class UserViewModel {

    weak var delegate: UserViewModelDelegate?

    var userHandler: ((User) -> Void)?

    var user: User

    init(user: User) {
        self.user = user
    }

    func getUser() {
        if UserDefaultConfig.user == [] {
            UserDefaultConfig.user = [user]
        }
        guard let user = UserDefaultConfig.user.first else { return }
        userHandler?(user)
    }

    func showUpdateProfile() {
        delegate?.didTapOnUpdate()
    }
}
