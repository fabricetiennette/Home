import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate: AnyObject {
    func didTapOnHeater(device: Device)
    func didTapOnLight(device: Device)
    func didTapOnRollerShutter(device: Device)
    func didTapOnProfile(user: User)
}
class HomeViewModel {

    weak var delegate: HomeViewModelDelegate?

    var devicesHandler: ((_ devices: [Device]) -> Void)?
    private var devices: [Device] = []
    private var user: User?
    private var unFilteredDevices: [Device] = []

    let homeService: HomeService
    let disposeBag = DisposeBag()

    init(homeService: HomeService = .init()) {
        self.homeService = homeService
    }

    func getDevice() {
        do {
            try homeService.getDevicesAndUser()
                .subscribe(onNext: { [weak self] result in
                    self?.user = result.user
                    self?.unFilteredDevices = result.devices
                    self?.devicesHandler?(result.devices)
                }, onError: { error in
                    print(error.localizedDescription)
                }, onCompleted: {
                    print("completed event")
                }).disposed(by: disposeBag)
        } catch {}
    }

    func filteredDevices(producTypeName: String){
        switch producTypeName {
        case "All":
            devices = unFilteredDevices
        case "Shutters":
            devices = unFilteredDevices.filter({ $0.productType == "RollerShutter" })
        default:
            devices = unFilteredDevices.filter({ $0.productType == producTypeName })
        }
        devicesHandler?(devices)
    }

    func getSelectedDevice(selectedDevice: Device) {
        switch selectedDevice.productType {
        case "Heater":
            delegate?.didTapOnHeater(device: selectedDevice)
        case "Light":
            delegate?.didTapOnLight(device: selectedDevice)
        case "RollerShutter":
            delegate?.didTapOnRollerShutter(device: selectedDevice)
        default:
            break
        }
    }

    func showUser() {
        guard let user = user else { return }
        delegate?.didTapOnProfile(user: user)
    }
}
