import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlertAndConfirmDelete(callback: @escaping () -> Void) {
        let ac = UIAlertController(
            title: L1s.delete,
            message: L1s.deleteMessage,
            preferredStyle: .alert
        )
        let submitAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            callback()
        }
        ac.addAction(
            UIAlertAction(title: L1s.cancel, style: .cancel, handler: nil)
        )
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

