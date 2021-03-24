import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate: AnyObject {
    func didTapOnHeater(deviceID: Int?)
    func didTapOnLight(deviceID: Int?)
    func didTapOnRollerShutter(deviceID: Int?)
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
                    self?.setDeviceAndUser(with: result)
                }, onError: { error in
                    print(error.localizedDescription)
                }).disposed(by: disposeBag)
        } catch {}
    }

    func filteredDevices(producTypeName: String) {
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
            delegate?.didTapOnHeater(deviceID: selectedDevice.deviceId)
        case "Light":
            delegate?.didTapOnLight(deviceID: selectedDevice.deviceId)
        case "RollerShutter":
            delegate?.didTapOnRollerShutter(deviceID: selectedDevice.deviceId)
        default: break
        }
    }

    func showUser() {
        guard let user = user else { return }
        delegate?.didTapOnProfile(user: user)
    }

    private func setDeviceAndUser(with result: Response) {
        user = result.user
        if UserDefaultConfig.device == [] {
            UserDefaultConfig.device = result.devices
        }
        if UserDefaultConfig.device.count != unFilteredDevices.count {
            devicesHandler?(UserDefaultConfig.device)
        }
        unFilteredDevices = UserDefaultConfig.device
    }
}
