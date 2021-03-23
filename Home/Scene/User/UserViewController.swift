import UIKit

class UserViewController: UIViewController {

    var viewModel: UserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        bind()
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(profileImageView)

        // Profile Image View
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor,
                                paddingTop: 100,
                                width: 150,
                                height: 150)

        // User Name Label
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor,
                         paddingTop: 10)

        // User Age Label
        view.addSubview(ageLabel)
        ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ageLabel.anchor(top: nameLabel.bottomAnchor,
                        paddingTop: 4)

        return view
    }()

    private lazy var adressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return stackView
    }()

    private let profileImageView: UIImageView = {
        let profileIV = UIImageView()
        return profileIV
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        return label
    }()

    private let streetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
}

private extension UserViewController {

    func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.userHandler = { [weak self] user in
            guard self == self else { return }
            self?.nameLabel.text = user.firstName
            self?.streetLabel.text = user.address?.street
            self?.cityLabel.text = user.address?.city
            self?.countryLabel.text = user.address?.country
            self?.ageLabel.text = Double(user.birthDate ?? 0).convertTimestampToStringDate()
        }
        viewModel.getUser()
    }

    func setupView() {
        navigationItem.title = "Profile"
        let safeArea = view.safeAreaLayoutGuide
        profileImageView.image = UIImage(named: "account")
        view.backgroundColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor,
                             left: safeArea.leftAnchor,
                             right: safeArea.rightAnchor,
                             height: 350)
        view.addSubview(adressStackView)
        adressStackView.anchor(top: containerView.bottomAnchor,
                               left: safeArea.leftAnchor,
                               right: safeArea.rightAnchor,
                               paddingTop: 40)
    }
}
