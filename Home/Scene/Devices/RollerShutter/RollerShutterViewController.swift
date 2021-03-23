import UIKit

class RollerShutterViewController: UIViewController {

    var viewModel: RollerShutterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
    }

    private lazy var rollerShutterPositionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "80"
        label.clipsToBounds = true
        return label
    }()

    private lazy var rollerShutterPositionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = UIImage(named: "sunDown")
        slider.maximumValueImage = UIImage(named: "sunUp")
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1)
        slider.isContinuous = true
        slider.addTarget(self,
                         action: #selector(didMovePositionSlider),
                         for: .valueChanged)
//        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        return slider
    }()

    private lazy var rollerShutterSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.clipsToBounds = true
        return button
    }()

    @objc func didTapSaveButton() {
        
    }

    @objc func didMovePositionSlider() {
        
    }
}

private extension RollerShutterViewController {

    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(rollerShutterSaveButton)
        rollerShutterSaveButton.anchor(bottom: safeArea.bottomAnchor,
                                       paddingBottom: 15,
                                       width: 125,
                                       height: 50)
        rollerShutterSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true

        view.addSubview(rollerShutterPositionSlider)
        rollerShutterPositionSlider.anchor(left: safeArea.leftAnchor,
                                           right: safeArea.rightAnchor,
                                           paddingLeft: 20, paddingRight: 20)
        rollerShutterPositionSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rollerShutterPositionSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(rollerShutterPositionLabel)
        rollerShutterPositionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rollerShutterPositionLabel.anchor(bottom: rollerShutterPositionSlider.bottomAnchor,
                                          paddingBottom: -80,
                                          width: 60, height: 60)
        
    }
}
