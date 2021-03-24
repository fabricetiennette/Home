import UIKit

class HeaterViewController: UIViewController {

    var viewModel: HeaterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }

    private lazy var heaterSwitch: UISwitch = {
        let heatSwitcher = UISwitch()
        heatSwitcher.tintColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        heatSwitcher.onTintColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        heatSwitcher.addTarget(
            self,
            action: #selector(heaterSwitchValueDidChange),
            for: .valueChanged
        )
        return heatSwitcher
    }()

    private lazy var modeOnLabel: UILabel = {
        let label = UILabel()
        label.text = L1s.on
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.text = L1s.off
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    private lazy var heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()

    private lazy var heaterSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle(L1s.save, for: .normal)
        button.clipsToBounds = true
        return button
    }()

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: L1s.delete,
            style: .plain,
            target: self,
            action: #selector(didTapDeleteButton)
        )
        return button
    }()

    private lazy var switchView: UIView = {
        let view = UIView()
        view.addSubview(modeOffLabel)
        modeOffLabel.anchor(top: view.topAnchor,
                            bottom: view.bottomAnchor)
        modeOffLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(heaterSwitch)
        heaterSwitch.anchor(
            top: view.topAnchor,
            left: modeOffLabel.rightAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 15
        )
        heaterSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heaterSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(modeOnLabel)
        modeOnLabel.anchor(
            top: view.topAnchor,
            left: heaterSwitch.rightAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 15
        )
        modeOnLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var temperatureView: UIView = {
        let view = UIView()
        view.addSubview(heaterMinusButton)
        heaterMinusButton.anchor(top: view.topAnchor,
                                 bottom: view.bottomAnchor)
        heaterMinusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: view.topAnchor,
                               left: heaterMinusButton.rightAnchor,
                               bottom: view.bottomAnchor,
                               paddingLeft: 15)
        temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(heaterPlusButton)
        heaterPlusButton.anchor(top: view.topAnchor,
                                left: temperatureLabel.rightAnchor,
                                bottom: view.bottomAnchor,
                                paddingLeft: 15)
        heaterPlusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    @objc private func didTapDeleteButton() {
        viewModel?.deleteDevice()
    }

    @objc func heaterSwitchValueDidChange() {
        viewModel?.observeModeSwitchValue(withOnvalue: heaterSwitch.isOn)
    }

    @objc func didTapPlusButton() {
        viewModel?.didPressPlusButton()
    }

    @objc func didTapMinusButton() {
        viewModel?.didPressMinusButton()
    }

    @objc func didTapSaveButton() {
        viewModel?.saveChanged()
    }
}

private extension HeaterViewController {

    func bind() {
        guard let viewModel = self.viewModel else { return }
        navigationItem.title = viewModel.device?.deviceName
        navigationItem.rightBarButtonItem = deleteButton

        viewModel.heaterMode = { [weak self] mode in
            switch mode {
            case .off:
                self?.heaterSwitch.setOn(false, animated: true)
            case .on:
                self?.heaterSwitch.setOn(true, animated: true)
            }
        }
        viewModel.heaterTemperature = { [weak self] temperature in
            self?.temperatureLabel.text = temperature
        }
        viewModel.setupModeAndTemperature()
    }

    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(heaterSaveButton)

        view.addSubview(switchView)

        switchView.anchor(
            top: safeArea.topAnchor,
            paddingTop: 70,
            width: 100,
            height: 30
        )
        switchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(temperatureView)
        temperatureView.anchor(width: 200, height: 80)
        temperatureView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        temperatureView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true

        temperatureLabel.anchor(width: 80, height: 80)
        heaterSaveButton.anchor(
            bottom: safeArea.bottomAnchor,
            paddingTop: 15,
            paddingBottom: 15,
            width: 125,
            height: 50
        )
        heaterSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }
}
