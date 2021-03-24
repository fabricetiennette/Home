import UIKit

class UpdateUserViewController: UIViewController {

    private lazy var tableViewDataSource = UpdateUserDataSource()
    var viewModel: UpdateUserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setNavigationBar()
        setTableView()
    }

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.register(UpdateProfileTableViewCell.self, forCellReuseIdentifier: "UpdateProfileTableViewCell")
        table.separatorStyle = .none
        return table
    }()

    private lazy var saveInformationsButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(title: L1s.save,
                        style: .plain,
                        target: self,
                        action: #selector(didTapUpdateProfileButton))
        return updateButton
    }()

    @objc func didTapUpdateProfileButton() {
        viewModel?.saveUserInfo(info: tableViewDataSource.saveItem)
    }
}

private extension UpdateUserViewController {

    func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.userHandler = { [weak self] userData in
            guard self == self else { return }
            DispatchQueue.main.async {
                self?.tableViewDataSource.updateCell(user: userData)
                self?.tableView.reloadData()
            }
        }
        viewModel.getUser()
    }
    func setNavigationBar() {
        navigationItem.rightBarButtonItem  = saveInformationsButton
    }

    func setTableView() {
        view.addSubview(tableView)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
}
