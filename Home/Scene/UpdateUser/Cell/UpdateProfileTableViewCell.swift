//
//  UpdateProfileTableViewCell.swift
//  Home
//
//  Created by Fabrice Etiennette on 23/03/2021.
//

import UIKit

class UpdateProfileTableViewCell: UITableViewCell {

    lazy var informationTypeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(userInfo: String, userData: String?) {
        contentView.addSubview(dataTextField)
        contentView.addSubview(informationTypeLabel)
        informationTypeLabel.anchor(top: contentView.topAnchor,
                                    left: contentView.leftAnchor,
                                    bottom: contentView.bottomAnchor,
                                    paddingLeft: 15,
                                    width: 150)
        dataTextField.centerYAnchor.constraint(equalTo: informationTypeLabel.centerYAnchor, constant: 0).isActive = true
        dataTextField.anchor(left: informationTypeLabel.rightAnchor,
                             paddingLeft: 10)
        informationTypeLabel.text = userInfo
        if let userData = userData {
            dataTextField.text = userData
        }
    }
}
