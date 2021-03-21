import Foundation
import UIKit

class HomeCoordinator: Coordinator<UINavigationController> {

    override func start() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            let viewModel = HomeViewModel()
            homeViewController.viewModel = viewModel
            self.rootView.pushViewController(homeViewController, animated: true)
        }
    }
}
