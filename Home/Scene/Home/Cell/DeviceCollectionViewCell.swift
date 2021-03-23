import UIKit

final class DeviceCollectionViewCell: UICollectionViewCell {

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(deviceImageView)
        stackView.addArrangedSubview(deviceNameLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    private let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let deviceNameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .center
        name.lineBreakMode = .byWordWrapping
        name.font = UIFont.boldSystemFont(ofSize: 15)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(cellStackView)
        
        cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        cellStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        deviceImageView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 1/2).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        deviceNameLabel.text = nil
        deviceImageView.image = nil
    }

    func configure(device: Device) {
        deviceNameLabel.text = device.deviceName
        deviceImageView.image = imageProductType(productType: device.productType)
        contentView.backgroundColor = setBackgroundColor(productType: device.productType)
    }
}

private extension DeviceCollectionViewCell {

    func imageProductType(productType: String?) -> UIImage? {
        guard let productType = productType else { return nil }
        switch productType {
        case "Heater":
            return UIImage(named: productType)
        case "Light":
            return UIImage(named: productType)
        case "RollerShutter":
            return UIImage(named: productType)
        default:
            return nil
        }
    }

    func setBackgroundColor(productType: String?) -> UIColor? {
        switch productType {
        case "Heater":
            return UIColor(cgColor: #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1))
        case "Light":
            return UIColor(cgColor: #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1))
        case "RollerShutter":
            return UIColor(cgColor: #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1))
        default:
            return UIColor(cgColor: #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1))
        }
    }
}
