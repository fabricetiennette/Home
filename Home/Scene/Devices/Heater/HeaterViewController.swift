import UIKit

class HeaterViewController: UIViewController {

    var viewModel: HeaterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
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
        label.text = "ON"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.text = "OFF"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "18"
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
        button.anchor(width: 80, height: 80)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        button.anchor(width: 80, height: 80)
        return button
    }()

    private lazy var heaterSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.clipsToBounds = true
        button.anchor(width: 125, height: 50)
        return button
    }()

    @objc func heaterSwitchValueDidChange() {
        
    }

    @objc func didTapPlusButton() {
        
    }

    @objc func didTapMinusButton() {
        
    }

    @objc func didTapSaveButton() {
        
    }
}

private extension HeaterViewController {

    func setupView() {
        let stackView = UIStackView(arrangedSubviews: [OnAndOffButton(), temperatureView(), heaterSaveButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 25)
        
    }

    func OnAndOffButton() -> UIStackView {
        let buttonStack = UIStackView()
        buttonStack.addArrangedSubview(modeOffLabel)
        buttonStack.addArrangedSubview(heaterSwitch)
        buttonStack.addArrangedSubview(modeOnLabel)
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.spacing = 5
        return buttonStack
    }

    func temperatureView() -> UIStackView {
        let tempStack = UIStackView()
        tempStack.addArrangedSubview(heaterMinusButton)
        tempStack.addArrangedSubview(temperatureLabel)
        tempStack.addArrangedSubview(heaterPlusButton)
        tempStack.axis = .horizontal
        tempStack.alignment = .center
        tempStack.spacing = 10
        return tempStack
    }
}
