import Foundation
import UIKit

class HomeCoordinator: Coordinator<UINavigationController> {

    override func start() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            self.rootView.pushViewController(homeViewController, animated: true)
        }
    }
}
