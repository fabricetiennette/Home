import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel?

    private var segmentedControl: UISegmentedControl?
    private var devicesCollectionView: UICollectionView?
    private lazy var devicesDataSource = DevicesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
    }

    private lazy var profileButton: UIBarButtonItem = {
        let profileButton = UIBarButtonItem(
            image: UIImage(named: "userImage"),
            style: .plain,
            target: self,
            action: #selector(didTapProfileButton)
        )
        return profileButton
    }()

    @objc func didTapProfileButton() {
        viewModel?.showUser()
    }

    @objc func handleSegmentChange() {
        guard let sc = segmentedControl,
              let producTypeName = sc.titleForSegment(at: sc.selectedSegmentIndex) else { return }
        self.viewModel?.filteredDevices(producTypeName: producTypeName)
    }
}

private extension HomeViewController {

    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.devicesHandler = { [weak self] device in
            guard self == self else { return }
            DispatchQueue.main.async {
                self?.devicesDataSource.update(with: device)
                self?.devicesCollectionView?.reloadData()
            }
        }
        viewModel.errorHandler = {
            self.showAlert(title: L1s.errorTitle, message: L1s.alertError)
        }
        devicesDataSource.didSelectHandler =  { selectedDevice in
            viewModel.getSelectedDevice(selectedDevice: selectedDevice)
        }
        viewModel.getDevice()
    }

    func setupView() {
        navigationItem.title = L1s.homeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem  = profileButton

        guard let segmentedControl = setupSegmentedController(),
              let collectionView = setupCollectionView() else { return }
        
        let segmentControl = UIStackView(arrangedSubviews: [segmentedControl])
        segmentControl.layoutMargins = .init(top: 12, left: 12, bottom: 6, right: 12)
        segmentControl.isLayoutMarginsRelativeArrangement = true

        let stackView = UIStackView()
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(collectionView)
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }

    func setupSegmentedController() -> UISegmentedControl? {
        segmentedControl = UISegmentedControl(
            items: [L1s.all, L1s.heater, L1s.light, L1s.shutter]
        )
        segmentedControl?.selectedSegmentIndex = 0
        segmentedControl?.addTarget(
            self,
            action: #selector(handleSegmentChange),
            for: .valueChanged
        )
        return segmentedControl
    }

    func setupCollectionView() -> UICollectionView? {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        devicesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        devicesCollectionView?.register(
            DeviceCollectionViewCell.self,
            forCellWithReuseIdentifier: "DeviceCollectionViewCell"
        )
        devicesCollectionView?.delegate = devicesDataSource
        devicesCollectionView?.dataSource = devicesDataSource
        devicesCollectionView?.backgroundColor = .white
        return devicesCollectionView
    }
}
