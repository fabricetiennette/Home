import Foundation
import UIKit

class UpdateUserDataSource: NSObject {

    var saveItem: [String] = []
    let textField = ["update_profile_first_name",
                             "update_profile_last_name",
                             "update_profile_street_number",
                             "update_profile_street_name",
                             "update_profile_postal_code",
                             "update_profile_city",
                             "update_profile_country"]

    var user: [String?] = []

    func updateCell(user: [String?]) {
        self.user = user
    }
}

extension UpdateUserDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension UpdateUserDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textField.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userInfo = textField[indexPath.row]
        if indexPath.row > user.count-1 {
            return UITableViewCell()
        } else {
        let userData = user[indexPath.row]
        guard let cell = tableView.dequeueReusableCell( withIdentifier: "UpdateProfileTableViewCell", for: indexPath) as? UpdateProfileTableViewCell,
              textField.indices.contains(indexPath.row) else { return UITableViewCell() }
        cell.configure(userInfo: userInfo, userData: userData)
            saveItem.append(cell.dataTextField.text ?? "")
        cell.dataTextField.delegate = self
        cell.dataTextField.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
        }
    }
}

extension UpdateUserDataSource: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }

    @objc func valueChanged(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldData.firstNameTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.lastNameTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.streetNumberTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.streetNameTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.postalCodeTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.cityTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        case TextFieldData.countryTextField.rawValue:
            saveItem[textField.tag] = textField.text ?? ""
        default:
            break
        }
    }
}

enum TextFieldData: Int {

    case firstNameTextField = 0
    case lastNameTextField
    case streetNumberTextField
    case streetNameTextField
    case postalCodeTextField
    case cityTextField
    case countryTextField

}
