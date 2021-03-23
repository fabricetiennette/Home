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
}

extension HomeCoordinator: HomeViewModelDelegate {

    func didTapOnProfile(user: User) {
        DispatchQueue.main.async {
            let userViewController = UserViewController()
            let viewModel = UserViewModel(user: user)
            userViewController.viewModel = viewModel
            self.rootView.pushViewController(userViewController, animated: true)
        }
    }
    

    func didTapOnLight(device: Device) {
        DispatchQueue.main.async {
            let lightViewController = LightViewController()
            let viewModel = LightViewModel(device:device)
            lightViewController.viewModel = viewModel
            self.rootView.pushViewController(lightViewController, animated: true)
        }
    }
    
    func didTapOnRollerShutter(device: Device) {
        DispatchQueue.main.async {
            let rollerShutterViewController = RollerShutterViewController()
            let viewModel = RollerShutterViewModel(device:device)
            rollerShutterViewController.viewModel = viewModel
            self.rootView.pushViewController(rollerShutterViewController, animated: true)
        }
    }

    func didTapOnHeater(device: Device) {
        DispatchQueue.main.async {
            let heaterViewController = HeaterViewController()
            let viewModel = HeaterViewModel(device:device)
            heaterViewController.viewModel = viewModel
            self.rootView.pushViewController(heaterViewController, animated: true)
        }
    }
}
