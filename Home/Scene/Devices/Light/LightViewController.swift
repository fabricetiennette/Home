import UIKit

class LightViewController: UIViewController {

    var viewModel: LightViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
        bind()
    }

    private lazy var lightSwitch: UISwitch = {
        let lightSwitcher = UISwitch()
        lightSwitcher.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        lightSwitcher.onTintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        lightSwitcher.addTarget(
            self,
            action: #selector(lightSwitchValueDidChange),
            for: .valueChanged
        )
        return lightSwitcher
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

    private lazy var lightLabel: UILabel = {
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

    private lazy var lightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = UIImage(named: "lightOff")
        slider.maximumValueImage = UIImage(named: "lightOn")
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        slider.isContinuous = true
        slider.setValue(18, animated: true)
        slider.addTarget(self, action: #selector(didMoveSlider), for: .valueChanged)
        return slider
    }()

    private lazy var lightSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle(L1s.save, for: .normal)
        button.clipsToBounds = true
        return button
    }()

    private lazy var switchView: UIView = {
        let view = UIView()
        view.addSubview(modeOffLabel)
        modeOffLabel.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
        modeOffLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(lightSwitch)
        lightSwitch.anchor(
            top: view.topAnchor,
            left: modeOffLabel.rightAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 15
        )
        lightSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lightSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(modeOnLabel)
        modeOnLabel.anchor(
            top: view.topAnchor,
            left: lightSwitch.rightAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 15
        )
        modeOnLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: L1s.delete,
                        style: .plain,
                        target: self,
                        action: #selector(didTapDeleteButton))
        return button
    }()

    @objc private func didTapDeleteButton() {
        viewModel?.deleteDevice()
    }
    
    @objc func lightSwitchValueDidChange() {
        let mode = lightSwitch.isOn
        viewModel?.observceSwithValueChanged(valueMode: mode)
        if let number = Int(lightLabel.text ?? "") {
            lightSlider.setValue(Float(number), animated: true)
        }
    }

    @objc func didMoveSlider(sender: UISlider) {
        lightLabel.text = String(Int(sender.value))
        viewModel?.observeLightIntensity(with: Int(lightSlider.value))
    }

    @objc func didTapSaveButton() {
        viewModel?.saveChanged()
    }
}

private extension LightViewController {

    func bind() {
        guard let viewModel = self.viewModel else { return }
        navigationItem.title = viewModel.device?.deviceName
        navigationItem.rightBarButtonItem = deleteButton

        viewModel.lightMode = { [weak self] mode in
            switch mode {
            case .off:
                self?.lightSwitch.setOn(false, animated: true)
            case .on:
                self?.lightSwitch.setOn(true, animated: true)
            }
        }
        viewModel.lightIntensity = { [weak self] value in
            self?.lightLabel.text = value
        }
        lightSlider.setValue(Float(viewModel.device?.intensity ?? 0), animated: true)
        viewModel.setupLightAndIntensity()
    }

    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        //Light save button
        view.addSubview(lightSaveButton)
        lightSaveButton.anchor(bottom: safeArea.bottomAnchor,
                               paddingBottom: 25,
                               width: 125,
                               height: 50)
        lightSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true

        //Light intensity slider
        view.addSubview(lightSlider)
        lightSlider.anchor(left: safeArea.leftAnchor,
                                    right: safeArea.rightAnchor,
                                    paddingLeft: 20, paddingRight: 20)
        lightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lightSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        //Light intensity label
        view.addSubview(lightLabel)
        lightLabel.anchor(top: lightSlider.bottomAnchor,
                                   paddingTop: 20,
                                   width: 60,
                                   height: 60)
        lightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //Mode view
        view.addSubview(switchView)

        switchView.anchor(top: safeArea.topAnchor,
                         paddingTop: 70,
                         width: 100,
                         height: 30)
        switchView.centerXAnchor.constraint(equalTo: lightSlider.centerXAnchor).isActive = true
    }

    
}
