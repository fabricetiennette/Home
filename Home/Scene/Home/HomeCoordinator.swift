import Foundation
import UIKit

class HomeCoordinator: Coordinator<UINavigationController> {

    override func start() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            let viewModel = HomeViewModel()
            viewModel.delegate = self
            homeViewController.viewModel = viewModel
            self.rootView.pushViewController(homeViewController, animated: true)
        }
    }

    func back() {
        self.rootView.popViewController(animated: true)
    }
}

extension HomeCoordinator: HomeViewModelDelegate {

    func didTapOnProfile(user: User) {
        DispatchQueue.main.async {
            let userViewController = UserViewController()
            let viewModel = UserViewModel(user: user)
            viewModel.delegate = self
            userViewController.viewModel = viewModel
            self.rootView.pushViewController(userViewController, animated: true)
        }
    }

    func didTapOnLight(deviceID: Int?) {
        DispatchQueue.main.async {
            let lightViewController = LightViewController()
            let viewModel = LightViewModel(deviceID: deviceID)
            viewModel.delegate = self
            lightViewController.viewModel = viewModel
            self.rootView.pushViewController(lightViewController, animated: true)
        }
    }

    func didTapOnRollerShutter(deviceID: Int?) {
        DispatchQueue.main.async {
            let rollerShutterViewController = RollerShutterViewController()
            let viewModel = RollerShutterViewModel(deviceID: deviceID)
            viewModel.delegate = self
            rollerShutterViewController.viewModel = viewModel
            self.rootView.pushViewController(rollerShutterViewController, animated: true)
        }
    }

    func didTapOnHeater(deviceID: Int?) {
        DispatchQueue.main.async {
            let heaterViewController = HeaterViewController()
            let viewModel = HeaterViewModel(deviceID: deviceID)
            viewModel.delegate = self
            heaterViewController.viewModel = viewModel
            self.rootView.pushViewController(heaterViewController, animated: true)
        }
    }
}

extension HomeCoordinator: UserViewModelDelegate {

    func didTapOnUpdate() {
        DispatchQueue.main.async {
            let updateProfileViewController = UpdateUserViewController()
            let viewModel = UpdateUserViewModel()
            viewModel.delegate = self
            updateProfileViewController.viewModel = viewModel
            self.rootView.pushViewController(updateProfileViewController, animated: true)
        }
    }
}

extension HomeCoordinator: UpdateUserViewModelDelegate {
    
    func didTapOnSave() {
        back()
    }
}

extension HomeCoordinator: RollerShutterViewModelDelegate {

    func didTapOnDeleteRollerShutterView() {
        back()
    }
}

extension HomeCoordinator: HeaterViewModelDelegate {

    func didTapOnDeleteHeaterView() {
        back()
    }
}

extension HomeCoordinator: LightViewModelDelegate {

    func didTapOnDeleteLightView() {
        back()
    }
}
