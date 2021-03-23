import Foundation

class UserViewModel {

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
}
