import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewLoad()
    }

    func viewLoad() {
        guard let viewModel = viewModel else { return }
        viewModel.getDevice()
    }
}
